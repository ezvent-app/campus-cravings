class ProductItemModel {
  final String id;
  final int totalOrdered;
  final String itemId;
  final ItemDetails itemDetails;
  final Restaurant restaurant;

  ProductItemModel({
    required this.id,
    required this.totalOrdered,
    required this.itemId,
    required this.itemDetails,
    required this.restaurant,
  });

  factory ProductItemModel.fromJson(Map<String, dynamic> json) {
    return ProductItemModel(
      id: json['_id']?.toString() ?? '',
      totalOrdered: (json['orderCount'] as num?)?.toInt() ?? 0,
      itemId: json['item_id']?.toString() ?? '',
      itemDetails: ItemDetails.fromJson(json['itemDetails'] ?? {}),
      restaurant: Restaurant.fromJson(json['restaurant'] ?? {}),
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
  final List<Size> sizes;
  final List<String> image;
  final String category;
  final String restaurant;
  final String createdAt;
  final String updatedAt;

  ItemDetails({
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

  factory ItemDetails.fromJson(Map<String, dynamic> json) {
    return ItemDetails(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description']?.toString() ?? '',
      estimatedPreparationTime:
          (json['estimated_preparation_time'] as num?)?.toInt() ?? 0,
      customization:
          (json['customization'] as List<dynamic>?)
              ?.map((x) => Customization.fromJson(x))
              .toList() ??
          [],
      sizes:
          (json['sizes'] as List<dynamic>?)
              ?.map((x) => Size.fromJson(x))
              .toList() ??
          [],
      image: (json['image'] as List?)?.map((e) => e.toString()).toList() ?? [],
      category: json['category']?.toString() ?? '',
      restaurant: json['restaurant']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
      updatedAt: json['updatedAt']?.toString() ?? '',
    );
  }
}

class Customization {
  final String name;
  final double price;
  final String id;

  Customization({required this.name, required this.price, required this.id});

  factory Customization.fromJson(Map<String, dynamic> json) {
    return Customization(
      name: json['name']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      id: json['_id']?.toString() ?? '',
    );
  }
}

class Size {
  final String name;
  final double price;
  final String id;

  Size({required this.name, required this.price, required this.id});

  factory Size.fromJson(Map<String, dynamic> json) {
    return Size(
      name: json['name']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      id: json['_id']?.toString() ?? '',
    );
  }
}

class Restaurant {
  final String storeName;
  final String cuisine;
  final Ratings ratings;
  final List<String> restaurantImages;
  final Address addresses;

  Restaurant({
    required this.storeName,
    required this.cuisine,
    required this.ratings,
    required this.restaurantImages,
    required this.addresses,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      storeName: json['storeName']?.toString() ?? '',
      cuisine: json['cuisine']?.toString() ?? '',
      ratings: Ratings.fromJson(json['ratings'] ?? {}),
      restaurantImages:
          (json['restaurantImages'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      addresses: Address.fromJson(json['addresses'] ?? {}),
    );
  }
}

class Ratings {
  final double averageRating;
  final int totalRatings;

  Ratings({required this.averageRating, required this.totalRatings});

  factory Ratings.fromJson(Map<String, dynamic> json) {
    return Ratings(
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      totalRatings: (json['totalRatings'] as num?)?.toInt() ?? 0,
    );
  }
}

class Address {
  final String address;
  final Coordinates coordinates;

  Address({required this.address, required this.coordinates});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['address']?.toString() ?? '',
      coordinates: Coordinates.fromJson(json['coordinates'] ?? {}),
    );
  }
}

class Coordinates {
  final List<double> coordinates;

  Coordinates({required this.coordinates});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      coordinates:
          (json['coordinates'] as List?)
              ?.map((x) => (x as num).toDouble())
              .toList() ??
          [],
    );
  }
}
