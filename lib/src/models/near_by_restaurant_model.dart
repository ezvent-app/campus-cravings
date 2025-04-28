class NearByRestaurantModel {
  final String id;
  final String storeName;
  final String brandName;
  final String floor;
  final String phoneNumber;
  final String cuisine;
  final List<String> deliveryMethods;
  final List<String> paymentMethods;
  final String status;
  final List<String> restaurantImages;
  final OpeningHours openingHours;
  final Address address;
  final Rating ratings;
  final int viewCount;
  final List<Category> categories;
  final List<RestaurantView> views;
  final DateTime createdAt;

  NearByRestaurantModel({
    required this.id,
    required this.storeName,
    required this.brandName,
    required this.floor,
    required this.phoneNumber,
    required this.cuisine,
    required this.deliveryMethods,
    required this.paymentMethods,
    required this.status,
    required this.restaurantImages,
    required this.openingHours,
    required this.address,
    required this.ratings,
    required this.viewCount,
    required this.categories,
    required this.views,
    required this.createdAt,
  });

  factory NearByRestaurantModel.fromJson(Map<String, dynamic> json) {
    return NearByRestaurantModel(
      id: json['_id'] ?? '',
      storeName: json['storeName'] ?? '',
      brandName: json['brandName'] ?? '',
      floor: json['floor'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      cuisine: json['cuisine'] ?? '',
      deliveryMethods: List<String>.from(json['deliveryMethods'] ?? []),
      paymentMethods: List<String>.from(json['paymentMethods'] ?? []),
      status: json['status'] ?? '',
      restaurantImages: List<String>.from(json['restaurantImages'] ?? []),
      openingHours: OpeningHours.fromJson(json['openingHours'] ?? {}),
      address: Address.fromJson(json['addresses'] ?? {}),
      ratings: Rating.fromJson(json['ratings'] ?? {}),
      viewCount: json['view_count'] ?? 0,
      categories: (json['categories'] as List<dynamic>? ?? [])
          .map((e) => Category.fromJson(e))
          .toList(),
      views: (json['views'] as List<dynamic>? ?? [])
          .map((e) => RestaurantView.fromJson(e))
          .toList(),
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }
}

class OpeningHours {
  final String monday;
  final String tuesday;
  final String wednesday;
  final String thursday;
  final String friday;
  final String saturday;
  final String sunday;

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
      monday: json['monday'] ?? 'Closed',
      tuesday: json['tuesday'] ?? 'Closed',
      wednesday: json['wednesday'] ?? 'Closed',
      thursday: json['thursday'] ?? 'Closed',
      friday: json['friday'] ?? 'Closed',
      saturday: json['saturday'] ?? 'Closed',
      sunday: json['sunday'] ?? 'Closed',
    );
  }
}

class Address {
  final String address;
  final Coordinates coordinates;

  Address({
    required this.address,
    required this.coordinates,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['address'] ?? '',
      coordinates: Coordinates.fromJson(json['coordinates'] ?? {}),
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
      type: json['type'] ?? '',
      coordinates: List<double>.from(
          json['coordinates']?.map((e) => (e as num).toDouble()) ?? []),
    );
  }
}

class Rating {
  final double averageRating;
  final int totalRatings;

  Rating({
    required this.averageRating,
    required this.totalRatings,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      totalRatings: json['totalRatings'] ?? 0,
    );
  }
}

class Category {
  final String id;
  final String name;
  final String description;
  final List<String> items;
  final String restaurant;
  final int v;
  final DateTime createdAt;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.items,
    required this.restaurant,
    required this.v,
    required this.createdAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      items: List<String>.from(json['items'] ?? []),
      restaurant: json['restaurant'] ?? '',
      v: json['__v'] ?? 0,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
    );
  }
}

class RestaurantView {
  final String id;
  final DateTime date;
  final int views;

  RestaurantView({
    required this.id,
    required this.date,
    required this.views,
  });

  factory RestaurantView.fromJson(Map<String, dynamic> json) {
    return RestaurantView(
      id: json['_id'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      views: json['views'] ?? 0,
    );
  }
}
