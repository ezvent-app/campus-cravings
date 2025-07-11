import 'dart:developer';

class ProductItemDetailModel {
  final String id;
  final String name;
  final double price;
  final String description;
  final int estimatedPreparationTime;
  final List<CustomizationModel> customization;
  final List<SizeOption> sizes;
  final List<String> images;
  final Category? category;
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
    required this.images,
    required this.category,
    required this.restaurant,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ProductItemDetailModel.fromJson(Map<String, dynamic> json) {
    log("🧪 ProductItemDetailModel input: $json");

    return ProductItemDetailModel(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description']?.toString() ?? '',
      estimatedPreparationTime:
          (json['estimated_preparation_time'] as num?)?.toInt() ?? 0,
      customization:
          (json['customization'] as List<dynamic>?)
              ?.map(
                (e) => CustomizationModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      sizes:
          (json['sizes'] as List<dynamic>?)
              ?.map((e) => SizeOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      images: (json['image'] as List?)?.map((e) => e.toString()).toList() ?? [],
      category: json['category'] is Map<String, dynamic>
          ? Category.fromJson(json['category'] as Map<String, dynamic>)
          : null,
      restaurant: json['restaurant']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
      v: (json['__v'] as num?)?.toInt() ?? 0,
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
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
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
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class Category {
  final String id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }
}
