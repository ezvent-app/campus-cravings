import 'package:campuscravings/src/models/product_item_detail_model.dart';

class CartItem {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String image;
  final List<CustomizationModel> customization;

  CartItem({
    required this.image,
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.customization,
  });

  CartItem copyWith({int? quantity}) => CartItem(
    customization: customization,
    image: image,
    id: id,
    name: name,
    price: price,
    quantity: quantity ?? this.quantity,
  );
}

extension CartItemToJson on CartItem {
  Map<String, dynamic> toOrderItemJson() {
    return {
      "item_id": id,
      "quantity": quantity,
      "customizations": customization.map((e) => e.id).toList(),
    };
  }
}
