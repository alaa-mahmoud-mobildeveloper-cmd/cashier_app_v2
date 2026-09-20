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
    gh.factory<_i87.ProductsLocalDataSource>(
      () => _i87.DriftProductsLocalDataSource(gh<_i111.AppDatabase>()),
    );
    gh.factory<_i711.DebtLocalDataSource>(
      () => _i892.DebtLocalDataSourceImpl(gh<_i111.AppDatabase>()),
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
    gh.factory<_i245.DebtRepository>(
      () => _i505.DebtRepositoryImpl(gh<_i711.DebtLocalDataSource>()),
    );
    gh.factory<_i799.GetDebts>(
      () => _i799.GetDebts(gh<_i245.DebtRepository>()),
    );
    gh.factory<_i151.PayDebt>(() => _i151.PayDebt(gh<_i245.DebtRepository>()));
    gh.factory<_i657.WatchDebts>(
      () => _i657.WatchDebts(gh<_i245.DebtRepository>()),
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
    gh.factory<_i584.DebtBloc>(
      () => _i584.DebtBloc(gh<_i657.WatchDebts>(), gh<_i151.PayDebt>()),
    );
    return this;
  }
}
