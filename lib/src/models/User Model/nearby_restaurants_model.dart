class NearbyRestaurantsResponse {
  final String message;
  final SearchResult searchResult;

  NearbyRestaurantsResponse({
    required this.message,
    required this.searchResult,
  });

  factory NearbyRestaurantsResponse.fromJson(Map<String, dynamic> json) {
    return NearbyRestaurantsResponse(
      message: json['message'] ?? '',
      searchResult: SearchResult.fromJson(json['searchResult'] ?? {}),
    );
  }
}

class SearchResult {
  final List<Restaurant> restaurants;
  final List<Category> categories;

  SearchResult({required this.restaurants, required this.categories});

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      restaurants:
          (json['restaurants'] as List? ?? [])
              .map((e) => Restaurant.fromJson(e))
              .toList(),
      categories:
          (json['categories'] as List? ?? [])
              .map((e) => Category.fromJson(e))
              .toList(),
    );
  }
}

class Restaurant {
  final String id;
  final String storeName;
  final String? brandName;
  final String? floor;
  final String? phoneNumber;
  final String? cuisine;
  final List<String> restaurantImages;
  final List<String> deliveryMethods;
  final List<String> paymentMethods;
  final String status;
  final List<String> categories;
  final int viewCount;
  final Ratings ratings;
  final OpeningHours openingHours;
  final Address addresses;
  final List<View> views;
  final String createdAt;

  Restaurant({
    required this.id,
    required this.storeName,
    this.brandName,
    this.floor,
    this.phoneNumber,
    this.cuisine,
    required this.restaurantImages,
    required this.deliveryMethods,
    required this.paymentMethods,
    required this.status,
    required this.categories,
    required this.viewCount,
    required this.ratings,
    required this.openingHours,
    required this.addresses,
    required this.views,
    required this.createdAt,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['_id'] ?? '',
      storeName: json['storeName'] ?? '',
      brandName: json['brandName'],
      floor: json['floor'],
      phoneNumber: json['phoneNumber'],
      cuisine: json['cuisine'],
      restaurantImages: List<String>.from(json['restaurantImages'] ?? []),
      deliveryMethods: List<String>.from(json['deliveryMethods'] ?? []),
      paymentMethods: List<String>.from(json['paymentMethods'] ?? []),
      status: json['status'] ?? '',
      categories: List<String>.from(json['categories'] ?? []),
      viewCount: json['view_count'] ?? 0,
      ratings: Ratings.fromJson(json['ratings'] ?? {}),
      openingHours: OpeningHours.fromJson(json['openingHours'] ?? {}),
      addresses: Address.fromJson(json['addresses'] ?? {}),
      views:
          (json['views'] as List? ?? []).map((e) => View.fromJson(e)).toList(),
      createdAt: json['createdAt'] ?? '',
    );
  }
}

class Ratings {
  final double averageRating;
  final int totalRatings;

  Ratings({required this.averageRating, required this.totalRatings});

  factory Ratings.fromJson(Map<String, dynamic> json) {
    return Ratings(
      averageRating: (json['averageRating'] ?? 0).toDouble(),
      totalRatings: json['totalRatings'] ?? 0,
    );
  }
}

class OpeningHours {
  final Map<String, String> days;

  OpeningHours({required this.days});

  factory OpeningHours.fromJson(Map<String, dynamic> json) {
    return OpeningHours(days: Map<String, String>.from(json));
  }
}

class Address {
  final String address;
  final Coordinates coordinates;

  Address({required this.address, required this.coordinates});

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

  Coordinates({required this.type, required this.coordinates});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      type: json['type'] ?? '',
      coordinates: List<double>.from(
        (json['coordinates'] as List? ?? []).map((e) => (e as num).toDouble()),
      ),
    );
  }
}

class View {
  final String id;
  final String date;
  final int views;

  View({required this.id, required this.date, required this.views});

  factory View.fromJson(Map<String, dynamic> json) {
    return View(
      id: json['_id'] ?? '',
      date: json['date'] ?? '',
      views: json['views'] ?? 0,
    );
  }
}

class Category {
  final String id;
  final String name;
  final String? description;
  final List<FoodItem> items;
  final String restaurant;
  final String createdAt;

  Category({
    required this.id,
    required this.name,
    this.description,
    required this.items,
    required this.restaurant,
    required this.createdAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      items:
          (json['items'] as List? ?? [])
              .map((e) => FoodItem.fromJson(e))
              .toList(),
      restaurant: json['restaurant'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}

class FoodItem {
  final String id;
  final String name;
  final double price;
  final String description;
  final int estimatedPreparationTime;
  final List<Customization> customization;
  final List<SizeOption> sizes;
  final List<String> image;
  final String category;
  final String restaurant;
  final String createdAt;
  final String updatedAt;

  FoodItem({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.estimatedPreparationTime,
    required this.customization,
    required this.sizes,
    required this.image,
    required this.category,
    required this.restaurant,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      estimatedPreparationTime: json['estimated_preparation_time'] ?? 0,
      customization:
          (json['customization'] as List? ?? [])
              .map((e) => Customization.fromJson(e))
              .toList(),
      sizes:
          (json['sizes'] as List? ?? [])
              .map((e) => SizeOption.fromJson(e))
              .toList(),
      image: List<String>.from(json['image'] ?? []),
      category: json['category'] ?? '',
      restaurant: json['restaurant'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }
}

class Customization {
  final String name;
  final double price;

  Customization({required this.name, required this.price});

  factory Customization.fromJson(Map<String, dynamic> json) {
    return Customization(
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    );
  }
}

class SizeOption {
  final String name;
  final double price;

  SizeOption({required this.name, required this.price});

  factory SizeOption.fromJson(Map<String, dynamic> json) {
    return SizeOption(
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
    );
  }
}
