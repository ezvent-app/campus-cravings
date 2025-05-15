import 'package:campuscravings/src/models/product_item_detail_model.dart';

class CartItem {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String image;
  final List<CustomizationModel> customization;
  final String? size;
  final double sizePrice;
  final List<double> restCoordinates;

  CartItem({
    required this.restCoordinates,
    required this.sizePrice,
    this.size,
    required this.image,
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.customization,
  });

  CartItem copyWith({
    int? quantity,
    String? size,
    double? sizePrice,
    List<CustomizationModel>? customization,
    List<double>? coordinates,
  }) => CartItem(
    restCoordinates: coordinates ?? restCoordinates,
    sizePrice: sizePrice ?? this.sizePrice,
    size: size ?? this.size,
    customization: customization ?? this.customization,
    image: image,
    id: id,
    name: name,
    price: price,
    quantity: quantity ?? this.quantity,
  );
}

extension CartItemToJson on CartItem {
  Map<String, dynamic> toOrderItemJson() {
    final Map<String, dynamic> data = {
      "item_id": id,
      "quantity": quantity,
      "customizations": customization.map((e) => e.id).toList(),
    };

    if (size != null && size!.isNotEmpty) {
      data["size"] = size;
    }

    return data;
  }
}
