class PopularItem {
  final String id;
  final int totalOrdered;
  final String itemId;
  final ItemDetails itemDetails;

  PopularItem({
    required this.id,
    required this.totalOrdered,
    required this.itemId,
    required this.itemDetails,
  });

  factory PopularItem.fromJson(Map<String, dynamic> json) {
    return PopularItem(
      id: json["_id"],
      totalOrdered: json["totalOrdered"],
      itemId: json["item_id"],
      itemDetails: ItemDetails.fromJson(json["itemDetails"]),
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
      id: json["_id"],
      name: json["name"],
      price: (json["price"] as num).toDouble(),
      description: json["description"],
      estimatedPreparationTime: json["estimated_preparation_time"],
      customization: (json["customization"] as List)
          .map((e) => Customization.fromJson(e))
          .toList(),
      image: List<String>.from(json["image"]),
      category: json["category"],
      restaurant: json["restaurant"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      v: json["__v"],
    );
  }
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
      name: json["name"],
      price: (json["price"] as num).toDouble(),
      id: json["_id"],
    );
  }
}
