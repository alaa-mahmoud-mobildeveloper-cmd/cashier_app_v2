import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/database/app_database.dart';

import 'supplier_local_datasource.dart';

@LazySingleton(as: SupplierLocalDataSource)
class SupplierLocalDataSourceImpl implements SupplierLocalDataSource {
  final AppDatabase database;

  SupplierLocalDataSourceImpl(this.database);

  @override
  Stream<List<Supplier>> watchSuppliers() {
    final query = database.select(database.suppliers)
      ..orderBy([
            (t) => OrderingTerm(
          expression: t.createdAt,
          mode: OrderingMode.desc,
        ),
      ]);

    return query.watch().map(
          (rows) => rows
          .map(
            (row) => Supplier(
          id: row.id,
          name: row.name,
          phone: row.phone,
          address: row.address,
          createdAt: row.createdAt,
        ),
      )
          .toList(),
    );
  }

  @override
  Future<int> addSupplier({
    required String name,
    String? phone,
    String? address,
  }) {
    return database.into(database.suppliers).insert(
      SuppliersCompanion.insert(
        name: name.trim(),
        phone: Value(
          phone?.trim().isEmpty == true ? null : phone?.trim(),
        ),
        address: Value(
          address?.trim().isEmpty == true ? null : address?.trim(),
        ),
      ),
    );
  }

  @override
  Future<void> updateSupplier(Supplier supplier) async {
    await (database.update(database.suppliers)
      ..where((t) => t.id.equals(supplier.id)))
        .write(
      SuppliersCompanion(
        name: Value(supplier.name.trim()),
        phone: Value(
          supplier.phone?.trim().isEmpty == true
              ? null
              : supplier.phone?.trim(),
        ),
        address: Value(
          supplier.address?.trim().isEmpty == true
              ? null
              : supplier.address?.trim(),
        ),
      ),
    );
  }

  @override
  Future<void> deleteSupplier(int id) async {
    await (database.delete(database.suppliers)
      ..where((t) => t.id.equals(id)))
        .go();
  }
}