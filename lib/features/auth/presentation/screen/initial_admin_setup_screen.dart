import 'package:cashier_app_v2/core/constants/app_colors.dart';
import 'package:cashier_app_v2/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter/material.dart';

class InitialAdminSetupScreen extends StatefulWidget {
  final AuthRepository authRepository;
  final VoidCallback onSetupComplete;

  const InitialAdminSetupScreen({
    super.key,
    required this.authRepository,
    required this.onSetupComplete,
  });

  @override
  State<InitialAdminSetupScreen> createState() =>
      _InitialAdminSetupScreenState();
}

class _InitialAdminSetupScreenState extends State<InitialAdminSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _createAdmin() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    try {
      await widget.authRepository.createInitialAdmin(
        username: _usernameController.text,
        fullName: _nameController.text,
        password: _passwordController.text,
      );
      if (!mounted) return;
      widget.onSetupComplete();
    } catch (error) {
      if (mounted) {
        final message = error.toString().replaceFirst('Bad state: ', '');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Card(
                  color: AppColors.surfaceLight,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.admin_panel_settings_outlined,
                            color: AppColors.gold,
                            size: 48,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'إعداد حساب مدير النظام',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'أنشئ الحساب الأول للبدء. كلمة المرور تُخزّن مجزأة بخوارزمية Argon2id.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: _nameController,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: 'الاسم الكامل',
                              prefixIcon: Icon(Icons.person_outline),
                            ),
                            validator: (value) =>
                                (value?.trim().length ?? 0) < 2
                                ? 'أدخل الاسم الكامل'
                                : null,
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _usernameController,
                            textInputAction: TextInputAction.next,
                            autocorrect: false,
                            decoration: const InputDecoration(
                              labelText: 'اسم المستخدم',
                              prefixIcon: Icon(Icons.alternate_email),
                            ),
                            validator: (value) {
                              final username = value?.trim() ?? '';
                              if (username.length < 3 || username.length > 50) {
                                return 'اسم المستخدم يجب أن يكون بين 3 و50 حرفًا';
                              }
                              if (RegExp(r'\s').hasMatch(username)) {
                                return 'لا تستخدم مسافات في اسم المستخدم';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              labelText: 'كلمة المرور (12 حرفًا على الأقل)',
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                onPressed: () => setState(
                                  () => _obscurePassword = !_obscurePassword,
                                ),
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                ),
                              ),
                            ),
                            validator: (value) {
                              final password = value ?? '';
                              if (password.length < 12) {
                                return 'استخدم 12 حرفًا على الأقل';
                              }
                              if (password.length > 256) {
                                return 'كلمة المرور طويلة جدًا';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),
                          TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: _obscurePassword,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (_) => _createAdmin(),
                            decoration: const InputDecoration(
                              labelText: 'تأكيد كلمة المرور',
                              prefixIcon: Icon(Icons.lock_reset_outlined),
                            ),
                            validator: (value) =>
                                value != _passwordController.text
                                ? 'كلمتا المرور غير متطابقتين'
                                : null,
                          ),
                          const SizedBox(height: 22),
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _isSaving ? null : _createAdmin,
                              child: _isSaving
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text('إنشاء حساب المدير'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
