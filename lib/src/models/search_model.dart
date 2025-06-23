import 'package:campuscravings/src/models/near_by_restaurant_model.dart';

class SearchModel {
  final List<FoodItemModel> listOfFoodItemModel;
  final List<RestaurantSearchModel> listOfNearByRestaurantModel;

  SearchModel({
    required this.listOfFoodItemModel,
    required this.listOfNearByRestaurantModel,
  });
  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      listOfFoodItemModel:
          (json['FoodItems'] as List)
              .map((e) => FoodItemModel.fromJson(e))
              .toList(),
      listOfNearByRestaurantModel:
          (json['restaurants'] as List)
              .map((e) => RestaurantSearchModel.fromJson(e))
              .toList(),
    );
  }
}

class FoodItemModel {
  final String id;
  final String name;
  final double price;
  final String description;
  final int estimatedPreparationTime;
  final List<Customization> customization;
  final List<Size> sizes;
  final int calories;
  final List<String> image;
  final Category category;
  final String restaurant;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  FoodItemModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.estimatedPreparationTime,
    required this.customization,
    required this.sizes,
    required this.calories,
    required this.image,
    required this.category,
    required this.restaurant,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory FoodItemModel.fromJson(Map<String, dynamic> json) {
    return FoodItemModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] ?? '',
      estimatedPreparationTime: json['estimated_preparation_time'] ?? 0,
      customization:
          (json['customization'] as List<dynamic>?)
              ?.map((e) => Customization.fromJson(e))
              .toList() ??
          [],
      sizes:
          (json['sizes'] as List<dynamic>?)
              ?.map((e) => Size.fromJson(e))
              .toList() ??
          [],
      calories: json['calories'] ?? 0,
      image:
          (json['image'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      category: Category.fromJson(json['category'] ?? {}),
      restaurant: json['restaurant'] ?? '',
      createdAt:
          DateTime.tryParse(json['createdAt'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      updatedAt:
          DateTime.tryParse(json['updatedAt'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      v: json['__v'] ?? 0,
    );
  }
}

class Customization {
  final String id;
  final String name;
  final double price;

  Customization({required this.id, required this.name, required this.price});

  factory Customization.fromJson(Map<String, dynamic> json) {
    return Customization(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class Size {
  final String id;
  final String name;
  final double price;

  Size({required this.id, required this.name, required this.price});

  factory Size.fromJson(Map<String, dynamic> json) {
    return Size(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class Category {
  final String id;
  final String name;
  final String description;
  final List<String> items;
  final DateTime createdAt;
  final String restaurant;
  final int v;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.items,
    required this.createdAt,
    required this.restaurant,
    required this.v,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      createdAt:
          DateTime.tryParse(json['created_at'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      restaurant: json['restaurant'] ?? '',
      v: json['__v'] ?? 0,
    );
  }
}

class RestaurantSearchModel {
  String id;
  String storeName;
  String brandName;
  String floor;
  String phoneNumber;
  String cuisine;
  OpeningHours openingHours;
  Address addresses;
  Ratings ratings;
  List<String> deliveryMethods;
  List<String> paymentMethods;
  String status;
  List<dynamic> categories;
  List<dynamic> restaurantImages;
  int viewCount;
  List<dynamic> views;
  DateTime createdAt;
  int v;

  RestaurantSearchModel({
    required this.id,
    required this.storeName,
    required this.brandName,
    required this.floor,
    required this.phoneNumber,
    required this.cuisine,
    required this.openingHours,
    required this.addresses,
    required this.ratings,
    required this.deliveryMethods,
    required this.paymentMethods,
    required this.status,
    required this.categories,
    required this.restaurantImages,
    required this.viewCount,
    required this.views,
    required this.createdAt,
    required this.v,
  });

  factory RestaurantSearchModel.fromJson(Map<String, dynamic> json) {
    return RestaurantSearchModel(
      id: json['_id'] as String,
      storeName: json['storeName'] as String,
      brandName: json['brandName'] as String,
      floor: json['floor'] as String,
      phoneNumber: json['phoneNumber'] as String,
      cuisine: json['cuisine'] as String,
      openingHours: OpeningHours.fromJson(json['openingHours']),
      addresses: Address.fromJson(json['addresses']),
      ratings: Ratings.fromJson(json['ratings']),
      deliveryMethods: List<String>.from(json['deliveryMethods']),
      paymentMethods: List<String>.from(json['paymentMethods']),
      status: json['status'] as String,
      categories: List<dynamic>.from(json['categories']),
      restaurantImages: List<dynamic>.from(json['restaurantImages']),
      viewCount: json['view_count'] as int,
      views: List<dynamic>.from(json['views']),
      createdAt: DateTime.parse(json['createdAt']),
      v: json['__v'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'storeName': storeName,
      'brandName': brandName,
      'floor': floor,
      'phoneNumber': phoneNumber,
      'cuisine': cuisine,
      'openingHours': openingHours.toJson(),
      'addresses': addresses.toJson(),
      'ratings': ratings.toJson(),
      'deliveryMethods': deliveryMethods,
      'paymentMethods': paymentMethods,
      'status': status,
      'categories': categories,
      'restaurantImages': restaurantImages,
      'view_count': viewCount,
      'views': views,
      'createdAt': createdAt.toIso8601String(),
      '__v': v,
    };
  }
}

class OpeningHours {
  String monday;
  String tuesday;
  String wednesday;
  String thursday;
  String friday;
  String saturday;
  String sunday;

  OpeningHours({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  factory OpeningHours.fromJson(Map<String, dynamic> json) {
    return OpeningHours(
      monday: json['monday'] as String,
      tuesday: json['tuesday'] as String,
      wednesday: json['wednesday'] as String,
      thursday: json['thursday'] as String,
      friday: json['friday'] as String,
      saturday: json['saturday'] as String,
      sunday: json['sunday'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'monday': monday,
      'tuesday': tuesday,
      'wednesday': wednesday,
      'thursday': thursday,
      'friday': friday,
      'saturday': saturday,
      'sunday': sunday,
    };
  }
}

class Address {
  Coordinates coordinates;
  String address;

  Address({required this.coordinates, required this.address});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      coordinates: Coordinates.fromJson(json['coordinates']),
      address: json['address'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'coordinates': coordinates.toJson(), 'address': address};
  }
}

class Coordinates {
  String type;
  List<double> coordinates;

  Coordinates({required this.type, required this.coordinates});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      type: json['type'] as String,
      coordinates: List<double>.from(
        json['coordinates'].map((x) => x.toDouble()),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'coordinates': coordinates};
  }
}

class Ratings {
  double averageRating;
  int totalRatings;

  Ratings({required this.averageRating, required this.totalRatings});

  factory Ratings.fromJson(Map<String, dynamic> json) {
    return Ratings(
      averageRating: (json['averageRating'] as num).toDouble(),
      totalRatings: json['totalRatings'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'averageRating': averageRating, 'totalRatings': totalRatings};
  }
}
