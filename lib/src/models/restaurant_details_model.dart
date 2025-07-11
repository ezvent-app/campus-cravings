// restaurant_details.dart

class RestaurantDetailsModel {
  final Restaurant restaurant;
  final List<Category> categories;

  RestaurantDetailsModel({required this.restaurant, required this.categories});

  factory RestaurantDetailsModel.fromJson(Map<String, dynamic> json) {
    return RestaurantDetailsModel(
      restaurant: Restaurant.fromJson(json['restaurant']),
      categories: List<Category>.from(
        json['categories'].map((x) => Category.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'restaurant': restaurant.toJson(),
    'categories': categories.map((x) => x.toJson()).toList(),
  };
}

class Restaurant {
  final String id;
  final String storeName;

  final String phoneNumber;
  final String cuisine;
  final String status;
  final List<String> deliveryMethods;
  final List<String> paymentMethods;
  final List<String> restaurantImages;
  final List<String> categories;
  final Address addresses;
  final Ratings ratings;
  final OpeningHours openingHours;

  Restaurant({
    required this.id,
    required this.storeName,

    required this.phoneNumber,
    required this.cuisine,
    required this.status,
    required this.deliveryMethods,
    required this.paymentMethods,
    required this.restaurantImages,
    required this.categories,
    required this.addresses,
    required this.ratings,
    required this.openingHours,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['_id'] ?? '',
      storeName: json['storeName'] ?? '',
      phoneNumber: json['phoneNumber']?.toString() ?? '',
      cuisine: json['cuisine'] ?? '',
      status: json['status'] ?? '',
      deliveryMethods:
          json['deliveryMethods'] != null
              ? List<String>.from(json['deliveryMethods'])
              : [],
      paymentMethods:
          json['paymentMethods'] != null
              ? List<String>.from(json['paymentMethods'])
              : [],
      restaurantImages:
          json['restaurantImages'] != null
              ? List<String>.from(json['restaurantImages'])
              : [],
      categories:
          json['categories'] != null
              ? List<String>.from(json['categories'])
              : [],
      addresses:
          json['addresses'] != null
              ? Address.fromJson(json['addresses'])
              : Address(
                address: '',
                coordinates: Coordinates(type: '', coordinates: []),
              ),
      ratings:
          json['ratings'] != null
              ? Ratings.fromJson(json['ratings'])
              : Ratings(averageRating: 0, totalRatings: 0),
      openingHours:
          json['openingHours'] != null
              ? OpeningHours.fromJson(json['openingHours'])
              : OpeningHours(
                monday: '',
                tuesday: '',
                wednesday: '',
                thursday: '',
                friday: '',
                saturday: '',
                sunday: '',
              ),
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'storeName': storeName,

    'phoneNumber': phoneNumber,
    'cuisine': cuisine,
    'status': status,
    'deliveryMethods': deliveryMethods,
    'paymentMethods': paymentMethods,
    'restaurantImages': restaurantImages,
    'categories': categories,
    'addresses': addresses.toJson(),
    'ratings': ratings.toJson(),
    'openingHours': openingHours.toJson(),
  };
}

class Address {
  final String address;
  final Coordinates coordinates;

  Address({required this.address, required this.coordinates});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['address'] ?? '',
      coordinates:
          json['coordinates'] != null
              ? Coordinates.fromJson(json['coordinates'])
              : Coordinates(type: '', coordinates: []),
    );
  }

  Map<String, dynamic> toJson() => {
    'address': address,
    'coordinates': coordinates.toJson(),
  };
}

class Coordinates {
  final String type;
  final List<double> coordinates;

  Coordinates({required this.type, required this.coordinates});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      type: json['type'] ?? '',
      coordinates: List<double>.from(
        (json['coordinates'] ?? []).map((x) => (x as num).toDouble()),
      ),
    );
  }

  Map<String, dynamic> toJson() => {'type': type, 'coordinates': coordinates};
}

class Ratings {
  final double averageRating;
  final int totalRatings;

  Ratings({required this.averageRating, required this.totalRatings});

  factory Ratings.fromJson(Map<String, dynamic> json) {
    return Ratings(
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      totalRatings: json['totalRatings'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'averageRating': averageRating,
    'totalRatings': totalRatings,
  };
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

  Map<String, dynamic> toJson() => {
    'monday': monday,
    'tuesday': tuesday,
    'wednesday': wednesday,
    'thursday': thursday,
    'friday': friday,
    'saturday': saturday,
    'sunday': sunday,
  };
}

class Category {
  final String id;
  final String name;
  final String description;
  final List<Item> items;
  final String restaurant;
  final String createdAt;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.items,
    required this.restaurant,
    required this.createdAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      items: List<Item>.from(json['items'].map((x) => Item.fromJson(x))),
      restaurant: json['restaurant'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'description': description,
    'items': items.map((x) => x.toJson()).toList(),
    'restaurant': restaurant,
    'created_at': createdAt,
  };
}

class Item {
  final String id;
  final String name;
  final double price;
  final String description;
  final int estimatedPreparationTime;
  final List<Customization> customization;
  final List<Size> sizes;
  final int calories;
  final List<String> image;
  final String category;
  final String restaurant;
  final String createdAt;
  final String updatedAt;

  Item({
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
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['_id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      estimatedPreparationTime: int.parse(
        json['estimated_preparation_time'].toString(),
      ),
      customization: List<Customization>.from(
        json['customization'].map((x) => Customization.fromJson(x)),
      ),
      sizes: List<Size>.from(json['sizes'].map((x) => Size.fromJson(x))),
      calories: json['calories'] ?? 0,
      image: List<String>.from(json['image']),
      category: json['category'],
      restaurant: json['restaurant'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'price': price,
    'description': description,
    'estimated_preparation_time': estimatedPreparationTime,
    'customization': customization.map((x) => x.toJson()).toList(),
    'sizes': sizes.map((x) => x.toJson()).toList(),
    'calories': calories,
    'image': image,
    'category': category,
    'restaurant': restaurant,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
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

  Map<String, dynamic> toJson() => {'name': name, 'price': price, '_id': id};
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

  Map<String, dynamic> toJson() => {'name': name, 'price': price, '_id': id};
}
