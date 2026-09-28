import 'package:flutter/material.dart';
import 'package:cashier_app_v2/core/constants/app_colors.dart';
class SupplierSelector extends StatelessWidget {
  const SupplierSelector({
    super.key, required this.suppliers,
    required this.selectedSupplierId,
    required this.onChanged,
  }
  );
  final List<SupplierSummary> suppliers;
  final int? selectedSupplierId;
  final ValueChanged<int?> onChanged;
  @override
  Widget build(BuildContext context) {
    final hasSelected = suppliers.any( (supplier) => supplier.id == selectedSupplierId, );
    return DropdownButtonFormField<int>(
      value: hasSelected ? selectedSupplierId : null,
      decoration: const InputDecoration(
        labelText: 'المورد',
        prefixIcon: Icon( Icons.local_shipping_outlined, ),
      ),
      dropdownColor: AppColors.surfaceLight,
      isExpanded: true,
      items: suppliers.map((supplier) {
        return DropdownMenuItem<int>(
          value: supplier.id,
          child: Text( supplier.name,
            overflow: TextOverflow.ellipsis,
          ),
        );
      }
      ).toList(),
      onChanged: onChanged,
      validator: (value) {
        return value == null ? 'اختر المورد' : null;
        },
    );
  }
}
class SupplierSummary {
  final int id;
  final String name;
  const SupplierSummary({
    required this.id,
    required this.name,
  }
  );
}