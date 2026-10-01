enum PaymentAccountType {
  wallet,
  visa;

  String get label => switch (this) {
    PaymentAccountType.wallet => 'محفظة إلكترونية',
    PaymentAccountType.visa => 'فيزا',
  };
}

class PaymentAccountInfo {
  final int id;
  final String type;
  final String name;
  final String? provider;
  final String? reference;
  final bool isActive;

  const PaymentAccountInfo({
    required this.id,
    required this.type,
    required this.name,
    required this.provider,
    required this.reference,
    required this.isActive,
  });

  String get typeLabel => type == PaymentAccountType.wallet.name
      ? PaymentAccountType.wallet.label
      : PaymentAccountType.visa.label;

  String get displayLabel => [
    name,
    if (provider?.trim().isNotEmpty ?? false) provider!.trim(),
    if (reference?.trim().isNotEmpty ?? false) reference!.trim(),
  ].join(' • ');
}

class PaymentAccountSummary extends PaymentAccountInfo {
  final double balance;
  final int transactionCount;

  const PaymentAccountSummary({
    required super.id,
    required super.type,
    required super.name,
    required super.provider,
    required super.reference,
    required super.isActive,
    required this.balance,
    required this.transactionCount,
  });
}

class PaymentAccountEntry {
  final int id;
  final int accountId;
  final int? invoiceId;
  final String? invoiceNumber;
  final int userId;
  final String kind;
  final double amount;
  final String? note;
  final DateTime createdAt;

  const PaymentAccountEntry({
    required this.id,
    required this.accountId,
    required this.invoiceId,
    required this.invoiceNumber,
    required this.userId,
    required this.kind,
    required this.amount,
    required this.note,
    required this.createdAt,
  });

  bool get isRefund => kind == 'refund';
}
