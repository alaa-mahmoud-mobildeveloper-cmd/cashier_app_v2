// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'core/database/app_database.dart' as _i111;
import 'features/auth/domain/session_provider.dart' as _i764;
import 'features/dashbord/data/datasources/dashboard_local_data_source.dart'
    as _i989;
import 'features/dashbord/data/datasources/dashboard_local_data_source_impl.dart'
    as _i99;
import 'features/dashbord/data/repositories/dashboard_repository_impl.dart'
    as _i102;
import 'features/dashbord/domain/repositories/dashboard_repository.dart'
    as _i484;
import 'features/dashbord/domain/usecases/get_dashboard.dart' as _i68;
import 'features/dashbord/presentation/bloc/dash_bloc.dart' as _i224;
import 'features/debts/data/datasources/debt_local_data_source.dart' as _i711;
import 'features/debts/data/datasources/debt_local_data_source_impl.dart'
    as _i892;
import 'features/debts/data/repositories/debt_repository_impl.dart' as _i505;
import 'features/debts/domain/repositories/debt_repository.dart' as _i245;
import 'features/debts/domain/usecases/get_debts.dart' as _i799;
import 'features/debts/domain/usecases/pay_debt.dart' as _i151;
import 'features/debts/domain/usecases/watch_debts.dart' as _i657;
import 'features/debts/presentation/bloc/debt_bloc.dart' as _i584;
import 'features/inventory/data/data_source/drift_product_repository.dart'
    as _i247;
import 'features/inventory/data/data_source/products_local_data_source.dart'
    as _i87;
import 'features/inventory/domain/repositories/product_repository.dart'
    as _i448;
import 'features/inventory/domain/usecases/add_product.dart' as _i564;
import 'features/inventory/domain/usecases/delete_product.dart' as _i737;
import 'features/inventory/domain/usecases/get_products.dart' as _i123;
import 'features/inventory/domain/usecases/update_product.dart' as _i34;
import 'features/inventory/domain/usecases/watch_products.dart' as _i250;
import 'features/pos/data/repositories/sales_repository_impl.dart' as _i405;
import 'features/pos/domain/repositories/sales_repository.dart' as _i465;
import 'features/pos/presentation/bloc/pos_bloc.dart' as _i16;
import 'features/purchases/data/datasources/product_lookup_local_datasource.dart'
    as _i954;
import 'features/purchases/data/datasources/product_lookup_local_datasource_impl.dart'
    as _i140;
import 'features/purchases/data/datasources/purchase_local_datasource.dart'
    as _i217;
import 'features/purchases/data/datasources/purchase_local_datasource_impl.dart'
    as _i247;
import 'features/purchases/data/repositories/product_lookup_repository_impl.dart'
    as _i289;
import 'features/purchases/data/repositories/purchase_repository_impl.dart'
    as _i742;
import 'features/purchases/domian/repositories/product_lookup_repository.dart'
    as _i444;
import 'features/purchases/domian/repositories/purchase_repository.dart'
    as _i785;
import 'features/purchases/domian/usecases/add_product_quickly_usecase.dart'
    as _i163;
import 'features/purchases/domian/usecases/collect_purchase_payment.dart'
    as _i808;
import 'features/purchases/domian/usecases/get_product_by_barcode_usecase.dart'
    as _i565;
import 'features/purchases/domian/usecases/get_purchase_invoice_details.dart'
    as _i707;
import 'features/purchases/domian/usecases/save_purchase.dart' as _i359;
import 'features/purchases/domian/usecases/search_products_usecase.dart'
    as _i900;
import 'features/purchases/domian/usecases/watch_purchase_invoices.dart'
    as _i607;
import 'features/purchases/presentation/bloc/product_search_bloc.dart' as _i376;
import 'features/purchases/presentation/bloc/purchase_bloc/purchase_bloc.dart'
    as _i748;
import 'features/reports/data/datasources/sales_report_local_data_source.dart'
    as _i96;
import 'features/reports/data/repositories/sales_report_repository_impl.dart'
    as _i1019;
import 'features/reports/domain/repositories/sales_report_repository.dart'
    as _i859;
import 'features/reports/presentation/bloc/sales_report_bloc.dart' as _i757;
import 'features/suppliers/data/datasource/supplier_local_datasource.dart'
    as _i397;
import 'features/suppliers/data/datasource/supplier_local_datasource_impl.dart'
    as _i901;
import 'features/suppliers/data/datasource/supplier_statement_local_datasource.dart'
    as _i1011;
import 'features/suppliers/data/datasource/supplier_statement_local_datasource_impl.dart'
    as _i132;
import 'features/suppliers/data/repo/supplier_repository_impl.dart' as _i1036;
import 'features/suppliers/data/repo/supplier_statement_repository_impl.dart'
    as _i107;
import 'features/suppliers/domain/repo/supplier_repository.dart' as _i807;
import 'features/suppliers/domain/repo/supplier_statement_repository.dart'
    as _i143;
import 'features/suppliers/domain/usecase/add_supplier_use_case.dart' as _i996;
import 'features/suppliers/domain/usecase/collect_purchase_payment_use_case.dart'
    as _i924;
import 'features/suppliers/domain/usecase/delete_supplier_use_case.dart'
    as _i284;
import 'features/suppliers/domain/usecase/get_suppliers_usecase.dart' as _i976;
import 'features/suppliers/domain/usecase/update_supplier_use_case.dart'
    as _i70;
import 'features/suppliers/domain/usecase/watch_supplier_statement_use_case.dart'
    as _i464;
import 'features/suppliers/presentation/bloc/supplier_statement_bloc/supplier_statement_bloc.dart'
    as _i443;
import 'features/suppliers/presentation/bloc/suppliers_bloc.dart' as _i219;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i111.AppDatabase>(() => _i111.AppDatabase());
    gh.lazySingleton<_i764.SessionProvider>(
      () => _i764.StaticSessionProvider(),
    );
    gh.factory<_i465.SalesRepository>(
      () => _i405.SalesRepositoryImpl(gh<_i111.AppDatabase>()),
    );
    gh.lazySingleton<_i217.PurchaseLocalDataSource>(
      () => _i247.PurchaseLocalDataSourceImpl(gh<_i111.AppDatabase>()),
    );
    gh.lazySingleton<_i1011.SupplierStatementLocalDataSource>(
      () => _i132.SupplierStatementLocalDataSourceImpl(gh<_i111.AppDatabase>()),
    );
    gh.lazySingleton<_i989.DashboardLocalDataSource>(
      () => _i99.DashboardLocalDataSourceImpl(gh<_i111.AppDatabase>()),
    );
    gh.factory<_i87.ProductsLocalDataSource>(
      () => _i87.DriftProductsLocalDataSource(gh<_i111.AppDatabase>()),
    );
    gh.lazySingleton<_i397.SupplierLocalDataSource>(
      () => _i901.SupplierLocalDataSourceImpl(gh<_i111.AppDatabase>()),
    );
    gh.lazySingleton<_i96.SalesReportLocalDataSource>(
      () => _i96.SalesReportLocalDataSourceImpl(gh<_i111.AppDatabase>()),
    );
    gh.factory<_i711.DebtLocalDataSource>(
      () => _i892.DebtLocalDataSourceImpl(gh<_i111.AppDatabase>()),
    );
    gh.lazySingleton<_i954.ProductLookupLocalDataSource>(
      () => _i140.ProductLookupLocalDataSourceImpl(gh<_i111.AppDatabase>()),
    );
    gh.lazySingleton<_i859.SalesReportRepository>(
      () => _i1019.SalesReportRepositoryImpl(
        gh<_i96.SalesReportLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i785.PurchaseRepository>(
      () => _i742.PurchaseRepositoryImpl(gh<_i217.PurchaseLocalDataSource>()),
    );
    gh.lazySingleton<_i143.SupplierStatementRepository>(
      () => _i107.SupplierStatementRepositoryImpl(
        gh<_i1011.SupplierStatementLocalDataSource>(),
      ),
    );
    gh.factory<_i757.SalesReportBloc>(
      () => _i757.SalesReportBloc(gh<_i859.SalesReportRepository>()),
    );
    gh.factory<_i484.DashboardRepository>(
      () => _i102.DashboardRepositoryImpl(gh<_i989.DashboardLocalDataSource>()),
    );
    gh.lazySingleton<_i444.ProductLookupRepository>(
      () => _i289.ProductLookupRepositoryImpl(
        gh<_i954.ProductLookupLocalDataSource>(),
      ),
    );
    gh.factory<_i924.CollectPurchasePaymentUseCase>(
      () => _i924.CollectPurchasePaymentUseCase(
        gh<_i143.SupplierStatementRepository>(),
      ),
    );
    gh.factory<_i464.WatchSupplierStatementUseCase>(
      () => _i464.WatchSupplierStatementUseCase(
        gh<_i143.SupplierStatementRepository>(),
      ),
    );
    gh.factory<_i808.CollectPurchasePayment>(
      () => _i808.CollectPurchasePayment(gh<_i785.PurchaseRepository>()),
    );
    gh.factory<_i448.ProductRepository>(
      () => _i247.DriftProductRepository(gh<_i87.ProductsLocalDataSource>()),
    );
    gh.factory<_i16.CartBloc>(
      () => _i16.CartBloc(
        gh<_i465.SalesRepository>(),
        gh<_i764.SessionProvider>(),
      ),
    );
    gh.lazySingleton<_i807.SupplierRepository>(
      () => _i1036.SupplierRepositoryImpl(gh<_i397.SupplierLocalDataSource>()),
    );
    gh.factory<_i443.SupplierStatementBloc>(
      () => _i443.SupplierStatementBloc(
        gh<_i464.WatchSupplierStatementUseCase>(),
        gh<_i924.CollectPurchasePaymentUseCase>(),
      ),
    );
    gh.factory<_i68.GetDashboard>(
      () => _i68.GetDashboard(gh<_i484.DashboardRepository>()),
    );
    gh.factory<_i245.DebtRepository>(
      () => _i505.DebtRepositoryImpl(gh<_i711.DebtLocalDataSource>()),
    );
    gh.factory<_i707.GetPurchaseInvoiceDetails>(
      () => _i707.GetPurchaseInvoiceDetails(gh<_i785.PurchaseRepository>()),
    );
    gh.factory<_i359.SavePurchase>(
      () => _i359.SavePurchase(gh<_i785.PurchaseRepository>()),
    );
    gh.factory<_i607.WatchPurchaseInvoices>(
      () => _i607.WatchPurchaseInvoices(gh<_i785.PurchaseRepository>()),
    );
    gh.factory<_i799.GetDebts>(
      () => _i799.GetDebts(gh<_i245.DebtRepository>()),
    );
    gh.factory<_i151.PayDebt>(() => _i151.PayDebt(gh<_i245.DebtRepository>()));
    gh.factory<_i657.WatchDebts>(
      () => _i657.WatchDebts(gh<_i245.DebtRepository>()),
    );
    gh.factory<_i224.DashboardBloc>(
      () => _i224.DashboardBloc(gh<_i68.GetDashboard>()),
    );
    gh.lazySingleton<_i163.AddProductQuicklyUseCase>(
      () => _i163.AddProductQuicklyUseCase(gh<_i444.ProductLookupRepository>()),
    );
    gh.lazySingleton<_i565.GetProductByBarcodeUseCase>(
      () =>
          _i565.GetProductByBarcodeUseCase(gh<_i444.ProductLookupRepository>()),
    );
    gh.lazySingleton<_i900.SearchProductsUseCase>(
      () => _i900.SearchProductsUseCase(gh<_i444.ProductLookupRepository>()),
    );
    gh.factory<_i996.AddSupplierUseCase>(
      () => _i996.AddSupplierUseCase(gh<_i807.SupplierRepository>()),
    );
    gh.factory<_i284.DeleteSupplierUseCase>(
      () => _i284.DeleteSupplierUseCase(gh<_i807.SupplierRepository>()),
    );
    gh.factory<_i976.GetSuppliersUseCase>(
      () => _i976.GetSuppliersUseCase(gh<_i807.SupplierRepository>()),
    );
    gh.factory<_i70.UpdateSupplierUseCase>(
      () => _i70.UpdateSupplierUseCase(gh<_i807.SupplierRepository>()),
    );
    gh.factory<_i564.AddProduct>(
      () => _i564.AddProduct(gh<_i448.ProductRepository>()),
    );
    gh.factory<_i737.DeleteProduct>(
      () => _i737.DeleteProduct(gh<_i448.ProductRepository>()),
    );
    gh.factory<_i123.GetProducts>(
      () => _i123.GetProducts(gh<_i448.ProductRepository>()),
    );
    gh.factory<_i34.UpdateProduct>(
      () => _i34.UpdateProduct(gh<_i448.ProductRepository>()),
    );
    gh.factory<_i250.WatchProducts>(
      () => _i250.WatchProducts(gh<_i448.ProductRepository>()),
    );
    gh.factory<_i376.ProductSearchBloc>(
      () => _i376.ProductSearchBloc(
        gh<_i900.SearchProductsUseCase>(),
        gh<_i565.GetProductByBarcodeUseCase>(),
        gh<_i163.AddProductQuicklyUseCase>(),
      ),
    );
    gh.factory<_i748.PurchaseBloc>(
      () => _i748.PurchaseBloc(
        gh<_i359.SavePurchase>(),
        gh<_i607.WatchPurchaseInvoices>(),
        gh<_i707.GetPurchaseInvoiceDetails>(),
        gh<_i808.CollectPurchasePayment>(),
      ),
    );
    gh.factory<_i584.DebtBloc>(
      () => _i584.DebtBloc(gh<_i657.WatchDebts>(), gh<_i151.PayDebt>()),
    );
    gh.factory<_i219.SuppliersBloc>(
      () => _i219.SuppliersBloc(
        gh<_i976.GetSuppliersUseCase>(),
        gh<_i996.AddSupplierUseCase>(),
        gh<_i70.UpdateSupplierUseCase>(),
        gh<_i284.DeleteSupplierUseCase>(),
      ),
    );
    return this;
  }
}
