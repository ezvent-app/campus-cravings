class PopularItem {
  final String itemId;
  final String name;
  final double price;
  final String description;
  final int totalOrdered;
  final List<String> image;

  PopularItem({
    required this.itemId,
    required this.name,
    required this.price,
    required this.description,
    required this.totalOrdered,
    required this.image,
  });

  // From JSON
  factory PopularItem.fromJson(Map<String, dynamic> json) {
    return PopularItem(
      itemId: json['item_id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String,
      totalOrdered: json['totalOrdered'] as int,
      image: List<String>.from(json['image']),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'item_id': itemId,
      'name': name,
      'price': price,
      'description': description,
      'totalOrdered': totalOrdered,
      'image': image,
    };
  }
}
