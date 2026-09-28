
class PurchaseItemSave {
const PurchaseItemSave({
required this.productId,
required this.quantity,
required this.cartonQuantity,
required this.unitsPerCarton,
required this.purchasePrice,
required this.salePrice,
required this.total,
});

final int productId;
final int quantity;
final double cartonQuantity;
final int unitsPerCarton;
final double purchasePrice;
final double salePrice;
final double total;
}

