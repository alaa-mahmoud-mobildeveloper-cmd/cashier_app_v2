import 'dart:convert';
import 'dart:math';

import 'package:cryptography/cryptography.dart';

class PasswordVerification {
  final bool isValid;
  final bool needsUpgrade;

  const PasswordVerification({
    required this.isValid,
    this.needsUpgrade = false,
  });
}

class PasswordHasher {
  static const _scheme = 'argon2id-v1';
  static const _memory = 19456; // 19 MiB in 1 kB blocks.
  static const _iterations = 2;
  static const _parallelism = 1;
  static const _hashLength = 32;
  static const _saltLength = 16;
  static const _disabledWorkerPrefix = 'WORKER_LOGIN_DISABLED:';

  static final Random _secureRandom = Random.secure();

  final Argon2id _argon2id = Argon2id(
    memory: _memory,
    iterations: _iterations,
    parallelism: _parallelism,
    hashLength: _hashLength,
  );

  Future<String> hashPassword(String password) async {
    if (password.isEmpty || password.length > 256) {
      throw ArgumentError.value(password.length, 'password.length');
    }

    final salt = List<int>.generate(
      _saltLength,
      (_) => _secureRandom.nextInt(256),
      growable: false,
    );
    final derivedKey = await _argon2id.deriveKeyFromPassword(
      password: password,
      nonce: salt,
    );
    final hash = await derivedKey.extractBytes();

    return [
      _scheme,
      '$_memory',
      '$_iterations',
      '$_parallelism',
      base64Url.encode(salt),
      base64Url.encode(hash),
    ].join(':');
  }

  Future<PasswordVerification> verifyPassword({
    required String password,
    required String storedValue,
  }) async {
    if (password.isEmpty || password.length > 256) {
      return const PasswordVerification(isValid: false);
    }
    if (storedValue.startsWith(_disabledWorkerPrefix)) {
      return const PasswordVerification(isValid: false);
    }

    if (storedValue.startsWith('$_scheme:')) {
      final parts = storedValue.split(':');
      if (parts.length != 6 ||
          parts[0] != _scheme ||
          parts[1] != '$_memory' ||
          parts[2] != '$_iterations' ||
          parts[3] != '$_parallelism') {
        return const PasswordVerification(isValid: false);
      }

      try {
        final salt = base64Url.decode(base64Url.normalize(parts[4]));
        final expectedHash = base64Url.decode(base64Url.normalize(parts[5]));
        if (salt.length != _saltLength || expectedHash.length != _hashLength) {
          return const PasswordVerification(isValid: false);
        }

        final derivedKey = await _argon2id.deriveKeyFromPassword(
          password: password,
          nonce: salt,
        );
        final actualHash = await derivedKey.extractBytes();
        return PasswordVerification(
          isValid: _constantTimeEquals(actualHash, expectedHash),
        );
      } on FormatException {
        return const PasswordVerification(isValid: false);
      }
    }

    // Compatibility path for pre-auth records that stored a plaintext value.
    // On a successful login AuthRepository immediately replaces it with Argon2id.
    final matchesLegacyValue = _constantTimeEquals(
      utf8.encode(password),
      utf8.encode(storedValue),
    );
    return PasswordVerification(
      isValid: matchesLegacyValue,
      needsUpgrade: matchesLegacyValue,
    );
  }

  bool _constantTimeEquals(List<int> left, List<int> right) {
    if (left.length != right.length) return false;
    var difference = 0;
    for (var index = 0; index < left.length; index++) {
      difference |= left[index] ^ right[index];
    }
    return difference == 0;
  }
}
