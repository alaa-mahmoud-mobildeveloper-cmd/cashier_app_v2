import 'package:cashier_app_v2/core/database/app_database.dart';
import 'package:cashier_app_v2/features/payment_accounts/domain/payment_account.dart';
import 'package:drift/drift.dart';

class PaymentAccountRepository {
  final AppDatabase _database;

  PaymentAccountRepository(this._database);

  Stream<List<PaymentAccountSummary>> watchSummaries() {
    return _database
        .customSelect(
          '''
          SELECT
            accounts.id AS id,
            accounts.type AS type,
            accounts.name AS name,
            accounts.provider AS provider,
            accounts.reference AS reference,
            accounts.is_active AS isActive,
            COALESCE(
              SUM(
                CASE
                  WHEN entries.kind = 'refund' THEN -entries.amount
                  ELSE entries.amount
                END
              ),
              0.0
            ) AS balance,
            COUNT(entries.id) AS entryCount
          FROM payment_accounts AS accounts
          LEFT JOIN payment_account_transactions AS entries
            ON entries.account_id = accounts.id
          GROUP BY accounts.id
          ORDER BY accounts.is_active DESC, accounts.created_at DESC
          ''',
          readsFrom: {
            _database.paymentAccounts,
            _database.paymentAccountTransactions,
          },
        )
        .watch()
        .map(
          (rows) => rows
              .map(
                (row) => PaymentAccountSummary(
                  id: row.read<int>('id'),
                  type: row.read<String>('type'),
                  name: row.read<String>('name'),
                  provider: row.readNullable<String>('provider'),
                  reference: row.readNullable<String>('reference'),
                  isActive: row.read<int>('isActive') != 0,
                  balance: row.read<double>('balance'),
                  transactionCount: row.read<int>('entryCount'),
                ),
              )
              .toList(growable: false),
        );
  }

  Future<List<PaymentAccountInfo>> getActiveAccounts({
    required String type,
  }) async {
    _validateType(type);
    final rows =
        await (_database.select(_database.paymentAccounts)
              ..where(
                (account) =>
                    account.type.equals(type) & account.isActive.equals(true),
              )
              ..orderBy([(account) => OrderingTerm(expression: account.name)]))
            .get();

    return rows
        .map(
          (row) => PaymentAccountInfo(
            id: row.id,
            type: row.type,
            name: row.name,
            provider: row.provider,
            reference: row.reference,
            isActive: row.isActive,
          ),
        )
        .toList(growable: false);
  }

  Future<int> addAccount({
    required String type,
    required String name,
    String? provider,
    String? reference,
  }) {
    _validateType(type);
    final cleanName = name.trim();
    if (cleanName.length < 2 || cleanName.length > 80) {
      throw ArgumentError.value(
        name,
        'name',
        'الاسم يجب أن يكون من حرفين إلى 80 حرفًا',
      );
    }
    final cleanReference = _cleanOptional(reference);
    final referenceDigits = cleanReference?.replaceAll(RegExp(r'\D'), '') ?? '';
    if (type == PaymentAccountType.visa.name &&
        referenceDigits.length >= 13 &&
        referenceDigits.length <= 19) {
      throw ArgumentError.value(
        reference,
        'reference',
        'لا تحفظ رقم البطاقة؛ استخدم اسم جهاز نقاط البيع فقط',
      );
    }

    return _database
        .into(_database.paymentAccounts)
        .insert(
          PaymentAccountsCompanion.insert(
            type: type,
            name: cleanName,
            provider: Value(_cleanOptional(provider)),
            reference: Value(cleanReference),
          ),
        );
  }

  Future<int> setAccountActive({
    required int accountId,
    required bool isActive,
  }) {
    return (_database.update(_database.paymentAccounts)
          ..where((account) => account.id.equals(accountId)))
        .write(PaymentAccountsCompanion(isActive: Value(isActive)));
  }

  Stream<List<PaymentAccountEntry>> watchEntries(int accountId) {
    return (_database.select(_database.paymentAccountTransactions)
          ..where((entry) => entry.accountId.equals(accountId))
          ..orderBy([
            (entry) => OrderingTerm(
              expression: entry.createdAt,
              mode: OrderingMode.desc,
            ),
            (entry) =>
                OrderingTerm(expression: entry.id, mode: OrderingMode.desc),
          ]))
        .watch()
        .map(
          (rows) => rows
              .map(
                (row) => PaymentAccountEntry(
                  id: row.id,
                  accountId: row.accountId,
                  invoiceId: row.invoiceId,
                  invoiceNumber: row.invoiceNumber,
                  userId: row.userId,
                  kind: row.kind,
                  amount: row.amount,
                  note: row.note,
                  createdAt: row.createdAt,
                ),
              )
              .toList(growable: false),
        );
  }

  void _validateType(String type) {
    if (type != PaymentAccountType.wallet.name &&
        type != PaymentAccountType.visa.name) {
      throw ArgumentError.value(type, 'type', 'نوع الحساب غير مدعوم');
    }
  }

  String? _cleanOptional(String? value) {
    final clean = value?.trim();
    return clean == null || clean.isEmpty ? null : clean;
  }
}
