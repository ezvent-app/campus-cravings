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
      id: json['_id'],
      totalOrdered: json['totalOrdered'],
      itemId: json['item_id'],
      itemDetails: ItemDetails.fromJson(json['itemDetails']),
      restaurant: Restaurant.fromJson(json['restaurant']),
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
      id: json['_id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      estimatedPreparationTime: json['estimated_preparation_time'],
      customization: List<Customization>.from(
        (json['customization'] as List).map((x) => Customization.fromJson(x)),
      ),
      sizes: List<Size>.from(
        (json['sizes'] as List).map((x) => Size.fromJson(x)),
      ),
      image: List<String>.from(json['image']),
      category: json['category'],
      restaurant: json['restaurant'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
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
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      id: json['_id'],
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
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      id: json['_id'],
    );
  }
}

class Restaurant {
  final String storeName;
  final String cuisine;
  final Ratings ratings;
  final List<String> restaurantImages;
  Address addresses;

  Restaurant({
    required this.storeName,
    required this.cuisine,
    required this.ratings,
    required this.restaurantImages,
    required this.addresses,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      storeName: json['storeName'],
      cuisine: json['cuisine'],
      ratings: Ratings.fromJson(json['ratings']),
      restaurantImages: List<String>.from(json['restaurantImages']),
      addresses: Address.fromJson(json['addresses']),
    );
  }
}

class Ratings {
  final double averageRating;
  final int totalRatings;

  Ratings({required this.averageRating, required this.totalRatings});

  factory Ratings.fromJson(Map<String, dynamic> json) {
    return Ratings(
      averageRating: (json['averageRating'] as num).toDouble(),
      totalRatings: json['totalRatings'],
    );
  }
}

class Address {
  final String address;
  final Coordinates coordinates;

  Address({required this.address, required this.coordinates});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['address'],
      coordinates: Coordinates.fromJson(json['coordinates']),
    );
  }
}

class Coordinates {
  final List<double> coordinates;

  Coordinates({required this.coordinates});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      coordinates: List<double>.from(
        (json['coordinates'] as List).map((x) => (x as num).toDouble()),
      ),
    );
  }
}
