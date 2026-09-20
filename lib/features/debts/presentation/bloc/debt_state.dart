import 'package:equatable/equatable.dart';
import 'package:cashier_app_v2/features/debts/domain/entities/debt_invoice.dart';

abstract class DebtState extends Equatable {
  const DebtState();

  @override
  List<Object?> get props => [];
}

class DebtInitial extends DebtState {
  const DebtInitial();
}

class DebtLoading extends DebtState {
  const DebtLoading();
}

class DebtLoaded extends DebtState {
  final List<DebtInvoice> invoices;

  final String searchQuery;

  /// فلتر وسيلة الدفع:
  /// الكل / نقدي / آجل
  final String selectedPaymentFilter;

  /// فلتر حالة الفاتورة:
  /// الكل / محصل / جزئي / غير محصل
  final String selectedStatusFilter;

  const DebtLoaded({
    required this.invoices,
    this.searchQuery = '',
    this.selectedPaymentFilter = 'الكل',
    this.selectedStatusFilter = 'الكل',
  });

  List<DebtInvoice> get filteredInvoices {
    final query = searchQuery.trim().toLowerCase();

    return invoices.where((invoice) {
      final matchesSearch =
          query.isEmpty ||
              invoice.customerName.toLowerCase().contains(query) ||
              invoice.invoiceNumber.toLowerCase().contains(query) ||
              invoice.phone.toLowerCase().contains(query);

      final matchesPayment =
          selectedPaymentFilter == 'الكل' ||
              (selectedPaymentFilter == 'نقدي' &&
                  invoice.paymentMethod == 'cash') ||
              (selectedPaymentFilter == 'آجل' &&
                  invoice.paymentMethod == 'credit');

      final matchesStatus =
          selectedStatusFilter == 'الكل' ||
              (selectedStatusFilter == 'محصل' &&
                  invoice.status == DebtStatus.paid) ||
              (selectedStatusFilter == 'جزئي' &&
                  invoice.status == DebtStatus.partial) ||
              (selectedStatusFilter == 'غير محصل' &&
                  invoice.status == DebtStatus.unpaid);

      return matchesSearch &&
          matchesPayment &&
          matchesStatus;
    }).toList();
  }

  // =========================
  // إجمالي كل الفواتير
  // =========================

  double get total {
    return invoices.fold(
      0.0,
          (sum, invoice) => sum + invoice.total,
    );
  }

  double get paid {
    return invoices.fold(
      0.0,
          (sum, invoice) => sum + invoice.paid,
    );
  }

  double get remaining {
    return invoices.fold(
      0.0,
          (sum, invoice) => sum + invoice.remaining,
    );
  }

  // =========================
  // فواتير النقدي
  // =========================

  List<DebtInvoice> get cashInvoices {
    return invoices
        .where((invoice) => invoice.paymentMethod == 'cash')
        .toList();
  }

  double get cashTotal {
    return cashInvoices.fold(
      0.0,
          (sum, invoice) => sum + invoice.total,
    );
  }

  // =========================
  // فواتير الآجل
  // =========================

  List<DebtInvoice> get creditInvoices {
    return invoices
        .where((invoice) => invoice.paymentMethod == 'credit')
        .toList();
  }

  double get creditTotal {
    return creditInvoices.fold(
      0.0,
          (sum, invoice) => sum + invoice.total,
    );
  }

  double get creditPaid {
    return creditInvoices.fold(
      0.0,
          (sum, invoice) => sum + invoice.paid,
    );
  }

  double get creditRemaining {
    return creditInvoices.fold(
      0.0,
          (sum, invoice) => sum + invoice.remaining,
    );
  }

  // =========================
  // حالات فواتير الآجل
  // =========================

  List<DebtInvoice> get unpaidInvoices {
    return invoices
        .where(
          (invoice) =>
      invoice.paymentMethod == 'credit' &&
          invoice.status == DebtStatus.unpaid,
    )
        .toList();
  }

  List<DebtInvoice> get partialInvoices {
    return invoices
        .where(
          (invoice) =>
      invoice.paymentMethod == 'credit' &&
          invoice.status == DebtStatus.partial,
    )
        .toList();
  }

  List<DebtInvoice> get paidInvoices {
    return invoices
        .where(
          (invoice) =>
      invoice.status == DebtStatus.paid,
    )
        .toList();
  }

  // =========================
  // أعداد الفواتير
  // =========================

  int get totalInvoices => invoices.length;

  int get cashInvoicesCount => cashInvoices.length;

  int get creditInvoicesCount => creditInvoices.length;

  int get unpaidInvoicesCount => unpaidInvoices.length;

  int get partialInvoicesCount => partialInvoices.length;

  int get paidInvoicesCount => paidInvoices.length;

  // =========================
  // Copy With
  // =========================

  DebtLoaded copyWith({
    List<DebtInvoice>? invoices,
    String? searchQuery,
    String? selectedPaymentFilter,
    String? selectedStatusFilter,
  }) {
    return DebtLoaded(
      invoices: invoices ?? this.invoices,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedPaymentFilter:
      selectedPaymentFilter ?? this.selectedPaymentFilter,
      selectedStatusFilter:
      selectedStatusFilter ?? this.selectedStatusFilter,
    );
  }

  @override
  List<Object?> get props => [
    invoices,
    searchQuery,
    selectedPaymentFilter,
    selectedStatusFilter,
  ];
}

class DebtError extends DebtState {
  final String message;

  const DebtError(this.message);

  @override
  List<Object?> get props => [message];
}