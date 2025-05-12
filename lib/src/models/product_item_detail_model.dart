class ProductItemDetailModel {
  final String id;
  final String name;
  final double price;
  final String description;
  final int estimatedPreparationTime;
  final List<CustomizationModel> customization;
  final List<SizeOption> sizes;
  final int calories;
  final List<String> images;
  final Category category;
  final String restaurant;
  final String createdAt;
  final String updatedAt;
  final int v;

  ProductItemDetailModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.estimatedPreparationTime,
    required this.customization,
    required this.sizes,
    required this.calories,
    required this.images,
    required this.category,
    required this.restaurant,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ProductItemDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductItemDetailModel(
      id: json['_id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      estimatedPreparationTime: json['estimated_preparation_time'],
      customization:
          (json['customization'] as List)
              .map((e) => CustomizationModel.fromJson(e))
              .toList(),
      sizes:
          (json['sizes'] as List).map((e) => SizeOption.fromJson(e)).toList(),
      calories: json['calories'] ?? 0,
      images: List<String>.from(json['image']),
      category: Category.fromJson(json['category']),
      restaurant: json['restaurant'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}

class CustomizationModel {
  final String id;
  final String name;
  final double price;

  CustomizationModel({
    required this.id,
    required this.name,
    required this.price,
  });

  factory CustomizationModel.fromJson(Map<String, dynamic> json) {
    return CustomizationModel(
      id: json['_id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
    );
  }
}

class SizeOption {
  final String id;
  final String name;
  final double price;

  SizeOption({required this.id, required this.name, required this.price});

  factory SizeOption.fromJson(Map<String, dynamic> json) {
    return SizeOption(
      id: json['_id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
    );
  }
}

class Category {
  final String id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['_id'], name: json['name']);
  }
}
