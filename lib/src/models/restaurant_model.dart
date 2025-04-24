class RestaurantModel {
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
  final List<dynamic> categories;
  final String createdAt;
  final Address address;
  final Ratings ratings;

  RestaurantModel({
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
    required this.address,
    required this.ratings,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['_id'] ?? '',
      storeName: json['storeName'] ?? '',
      brandName: json['brandName'] ?? '',
      floor: json['floor'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      cuisine: json['cuisine'] ?? '',
      deliveryMethods: List<String>.from(json['deliveryMethods'] ?? []),
      viewCount: json['view_count'] ?? 0,
      paymentMethods: List<String>.from(json['paymentMethods'] ?? []),
      status: json['status'] ?? '',
      categories: List<dynamic>.from(json['categories'] ?? []),
      createdAt: json['createdAt'] ?? '',
      address: Address.fromJson(json['addresses'] ?? {}),
      ratings: Ratings.fromJson(json['ratings'] ?? {}),
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
      coordinates: List<double>.from(json['coordinates']?.map((x) => (x as num).toDouble()) ?? []),
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
      averageRating: (json['averageRating'] ?? 0).toDouble(),
      totalRatings: json['totalRatings'] ?? 0,
    );
  }
}
