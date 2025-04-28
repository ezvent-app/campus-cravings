class ProductItemModel {
  final String id;
  final int totalOrdered;
  final String itemId;
  final ItemDetails itemDetails;

  ProductItemModel({
    required this.id,
    required this.totalOrdered,
    required this.itemId,
    required this.itemDetails,
  });

  factory ProductItemModel.fromJson(Map<String, dynamic> json) {
    return ProductItemModel(
      id: json["_id"] ?? "",
      totalOrdered: json["totalOrdered"] ?? 0,
      itemId: json["item_id"] ?? "",
      itemDetails: json["itemDetails"] != null
          ? ItemDetails.fromJson(json["itemDetails"])
          : ItemDetails.empty(),
    );
  }
}

class ItemDetails {
  final String id;
  final String name;
  final double price;
  final String description;
  final int estimatedPreparationTime;
  final List<Customization> customization;
  final List<String> image;
  final String category;
  final String restaurant;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  ItemDetails({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.estimatedPreparationTime,
    required this.customization,
    required this.image,
    required this.category,
    required this.restaurant,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ItemDetails.fromJson(Map<String, dynamic> json) {
    return ItemDetails(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      price: (json["price"] ?? 0).toDouble(),
      description: json["description"] ?? "",
      estimatedPreparationTime: json["estimated_preparation_time"] ?? 0,
      customization: (json["customization"] as List?)
          ?.map((e) => Customization.fromJson(e))
          .toList() ??
          [],
      image: (json["image"] as List?)?.map((e) => e.toString()).toList() ?? [],
      category: json["category"] ?? "",
      restaurant: json["restaurant"] ?? "",
      createdAt: json["createdAt"] != null
          ? DateTime.parse(json["createdAt"])
          : DateTime.now(),
      updatedAt: json["updatedAt"] != null
          ? DateTime.parse(json["updatedAt"])
          : DateTime.now(),
      v: json["__v"] ?? 0,
    );
  }

  factory ItemDetails.empty() => ItemDetails(
    id: "",
    name: "",
    price: 0.0,
    description: "",
    estimatedPreparationTime: 0,
    customization: [],
    image: [],
    category: "",
    restaurant: "",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    v: 0,
  );
}

class Customization {
  final String name;
  final double price;
  final String id;

  Customization({
    required this.name,
    required this.price,
    required this.id,
  });

  factory Customization.fromJson(Map<String, dynamic> json) {
    return Customization(
      name: json["name"] ?? "",
      price: (json["price"] ?? 0).toDouble(),
      id: json["_id"] ?? "",
    );
  }
}
