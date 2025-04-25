class RestaurantDetailsModel {
  final List<Category> categories;
  final Restaurant restaurant;

  RestaurantDetailsModel({
    required this.categories,
    required this.restaurant,
  });

  factory RestaurantDetailsModel.fromJson(Map<String, dynamic> json) {
    return RestaurantDetailsModel(
      categories: (json['categories'] as List)
          .map((e) => Category.fromJson(e))
          .toList(),
      restaurant: Restaurant.fromJson(json['restaurant']),
    );
  }
}

class Category {
  final String id;
  final String name;
  final String description;
  final List<Item> items;
  final DateTime createdAt;
  final String restaurantId;
  final int v;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.items,
    required this.createdAt,
    required this.restaurantId,
    required this.v,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      items: (json['items'] as List)
          .map((e) => Item.fromJson(e))
          .toList(),
      createdAt: DateTime.parse(json['created_at']),
      restaurantId: json['restaurant'],
      v: json['__v'],
    );
  }
}

class Item {
  final String id;
  final String name;
  final double price;
  final String description;
  final int estimatedPreparationTime;
  final List<Customization> customization;
  final List<String> images;
  final String categoryId;
  final String restaurantId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final List<dynamic> sizes;

  Item({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.estimatedPreparationTime,
    required this.customization,
    required this.images,
    required this.categoryId,
    required this.restaurantId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.sizes,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['_id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      estimatedPreparationTime: json['estimated_preparation_time'],
      customization: (json['customization'] as List)
          .map((e) => Customization.fromJson(e))
          .toList(),
      images: List<String>.from(json['image']),
      categoryId: json['category'],
      restaurantId: json['restaurant'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
      sizes: json['sizes'] ?? [],
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
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      id: json['_id'],
    );
  }
}

class Restaurant {
  final Address addresses;
  final Ratings ratings;
  final String id;
  final String storeName;
  final String brandName;
  final String floor;
  final String phoneNumber;
  final String cuisine;
  final List<String> deliveryMethods;
  final int viewCount;
  final List<String> paymentMethods;
  final String status;
  final List<String> categories;
  final DateTime createdAt;
  final int v;
  final List<View> views;

  Restaurant({
    required this.addresses,
    required this.ratings,
    required this.id,
    required this.storeName,
    required this.brandName,
    required this.floor,
    required this.phoneNumber,
    required this.cuisine,
    required this.deliveryMethods,
    required this.viewCount,
    required this.paymentMethods,
    required this.status,
    required this.categories,
    required this.createdAt,
    required this.v,
    required this.views,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      addresses: Address.fromJson(json['addresses']),
      ratings: Ratings.fromJson(json['ratings']),
      id: json['_id'],
      storeName: json['storeName'],
      brandName: json['brandName'],
      floor: json['floor'],
      phoneNumber: json['phoneNumber'],
      cuisine: json['cuisine'],
      deliveryMethods: List<String>.from(json['deliveryMethods']),
      viewCount: json['view_count'],
      paymentMethods: List<String>.from(json['paymentMethods']),
      status: json['status'],
      categories: List<String>.from(json['categories']),
      createdAt: DateTime.parse(json['createdAt']),
      v: json['__v'],
      views: (json['views'] as List)
          .map((e) => View.fromJson(e))
          .toList(),
    );
  }
}

class Address {
  final Coordinates coordinates;
  final String address;

  Address({
    required this.coordinates,
    required this.address,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      coordinates: Coordinates.fromJson(json['coordinates']),
      address: json['address'],
    );
  }
}

class Coordinates {
  final String type;
  final List<double> coordinates;

  Coordinates({
    required this.type,
    required this.coordinates,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      type: json['type'],
      coordinates: List<double>.from(json['coordinates'].map((e) => e.toDouble())),
    );
  }
}

class Ratings {
  final double averageRating;
  final int totalRatings;

  Ratings({
    required this.averageRating,
    required this.totalRatings,
  });

  factory Ratings.fromJson(Map<String, dynamic> json) {
    return Ratings(
      averageRating: (json['averageRating'] as num).toDouble(),
      totalRatings: json['totalRatings'],
    );
  }
}

class View {
  final DateTime date;
  final int views;
  final String id;

  View({
    required this.date,
    required this.views,
    required this.id,
  });

  factory View.fromJson(Map<String, dynamic> json) {
    return View(
      date: DateTime.parse(json['date']),
      views: json['views'],
      id: json['_id'],
    );
  }
}
