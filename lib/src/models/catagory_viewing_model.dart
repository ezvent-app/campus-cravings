class CategoryViewingModel {
  final String? message;
  final List<SingleCategoryModel>? categories;

  CategoryViewingModel({this.message, this.categories});

  factory CategoryViewingModel.fromJson(Map<String, dynamic> json) {
    return CategoryViewingModel(
      message: json['message'] as String?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => SingleCategoryModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'categories': categories?.map((e) => e.toJson()).toList(),
    };
  }
}

class SingleCategoryModel {
  final String? id;
  final String? name;
  final String? description;
  final List<String>? items;
  final DateTime? createdAt;
  final String? restaurant;

  SingleCategoryModel({
    this.id,
    this.name,
    this.description,
    this.items,
    this.createdAt,
    this.restaurant,
  });

  factory SingleCategoryModel.fromJson(Map<String, dynamic> json) {
    return SingleCategoryModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String? ?? '',
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      restaurant: json['restaurant'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'items': items,
      'created_at': createdAt?.toIso8601String(),
      'restaurant': restaurant,
    };
  }
}
