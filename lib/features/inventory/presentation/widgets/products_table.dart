
import 'package:cashier_app_v2/core/constants/app_colors.dart';
import 'package:cashier_app_v2/features/inventory/domain/entities/product_items_entit.dart';
import 'package:cashier_app_v2/features/inventory/presentation/widgets/product_table_row.dart';
import 'package:flutter/material.dart';

class ProductsGrid extends StatelessWidget {
final List<ProductItem> items;
final ValueChanged<ProductItem>? onEdit;

const ProductsGrid({
super.key,
required this.items,
this.onEdit,
});

static const double _cardMinWidth = 260;

@override
Widget build(BuildContext context) {
if (items.isEmpty) {
return const Padding(
padding: EdgeInsets.symmetric(vertical: 48),
child: Center(
child: Text(
'لا توجد أصناف مطابقة',
style: TextStyle(
color: AppColors.textSecondary,
),
),
),
);
}

return LayoutBuilder(
builder: (context, constraints) {
final crossAxisCount =
(constraints.maxWidth / _cardMinWidth).floor().clamp(1, 6);

final cardHeight = constraints.maxWidth < 700
? 560.0
    : constraints.maxWidth < 1100
? 550.0
    : 520.0;

return GridView.builder(
shrinkWrap: true,
physics: const NeverScrollableScrollPhysics(),
itemCount: items.length,
gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
crossAxisCount: crossAxisCount,
mainAxisExtent: cardHeight,
mainAxisSpacing: 14,
crossAxisSpacing: 14,
),
itemBuilder: (context, index) {
final item = items[index];

return ProductCard(
item: item,
onEdit: () => onEdit?.call(item),
);
},
);
},
);
}
}
