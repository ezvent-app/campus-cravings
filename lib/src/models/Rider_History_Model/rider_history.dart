class RiderHistory {
  final String message;
  final List<Order> orders;

  RiderHistory({required this.message, required this.orders});

  factory RiderHistory.fromJson(Map<String, dynamic> json) {
    return RiderHistory(
      message: json['message'],
      orders: List<Order>.from(json['orders'].map((x) => Order.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
  };
}

class Order {
  final String id;
  final User user;
  final Restaurant restaurant;
  final Address addresses;
  final String? assignedTo;
  final String status;
  final double totalPrice;
  final String paymentMethod;
  final double tip;
  final double deliveryFee;
  final String estimatedTime;
  final String imageUrl;
  final String orderType;
  final List<Item> items;
  final List<dynamic> progress;
  final DateTime createdAt;
  final DateTime updatedAt;

  Order({
    required this.id,
    required this.user,
    required this.restaurant,
    required this.addresses,
    this.assignedTo,
    required this.status,
    required this.totalPrice,
    required this.paymentMethod,
    required this.tip,
    required this.deliveryFee,
    required this.estimatedTime,
    required this.imageUrl,
    required this.orderType,
    required this.items,
    required this.progress,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'],
      user: User.fromJson(json['user_id']),
      restaurant: Restaurant.fromJson(json['restaurant_id']),
      addresses: Address.fromJson(json['addresses']),
      assignedTo: json['assigned_to'],
      status: json['status'],
      totalPrice: (json['total_price'] as num).toDouble(),
      paymentMethod: json['payment_method'],
      tip: (json['tip'] as num).toDouble(),
      deliveryFee: (json['delivery_fee'] as num).toDouble(),
      estimatedTime: json['estimated_time'] ?? '',
      imageUrl: json['image_url'] ?? '',
      orderType: json['order_type'] ?? '',
      items: List<Item>.from(json['items'].map((x) => Item.fromJson(x))),
      progress: List<dynamic>.from(json['progress']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "user_id": user.toJson(),
    "restaurant_id": restaurant.toJson(),
    "addresses": addresses.toJson(),
    "assigned_to": assignedTo,
    "status": status,
    "total_price": totalPrice,
    "payment_method": paymentMethod,
    "tip": tip,
    "delivery_fee": deliveryFee,
    "estimated_time": estimatedTime,
    "image_url": imageUrl,
    "order_type": orderType,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "progress": progress,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
  };
}

class Restaurant {
  final String id;
  final String storeName;
  final String brandName;
  final String phoneNumber;

  Restaurant({
    required this.id,
    required this.storeName,
    required this.brandName,
    required this.phoneNumber,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['_id'],
      storeName: json['storeName'],
      brandName: json['brandName'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "storeName": storeName,
    "brandName": brandName,
    "phoneNumber": phoneNumber,
  };
}

class Address {
  final Coordinates coordinates;
  final String address;

  Address({required this.coordinates, required this.address});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      coordinates: Coordinates.fromJson(json['coordinates']),
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() => {
    "coordinates": coordinates.toJson(),
    "address": address,
  };
}

class Coordinates {
  final String type;
  final List<double> coordinates;

  Coordinates({required this.type, required this.coordinates});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      type: json['type'],
      coordinates: List<double>.from(
        json['coordinates'].map((x) => x.toDouble()),
      ),
    );
  }

  Map<String, dynamic> toJson() => {"type": type, "coordinates": coordinates};
}

class Item {
  final ItemDetails itemId;
  final int quantity;
  final List<Customization> customizations;
  final String id;

  Item({
    required this.itemId,
    required this.quantity,
    required this.customizations,
    required this.id,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    itemId: ItemDetails.fromJson(json['item_id']),
    quantity: json['quantity'],
    customizations: List<Customization>.from(
      json['customizations'].map((x) => Customization.fromJson(x)),
    ),
    id: json['_id'],
  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId.toJson(),
    "quantity": quantity,
    "customizations": List<dynamic>.from(customizations.map((x) => x.toJson())),
    "_id": id,
  };
}

class ItemDetails {
  final String id;
  final String name;
  final double price;

  ItemDetails({required this.id, required this.name, required this.price});

  factory ItemDetails.fromJson(Map<String, dynamic> json) {
    return ItemDetails(
      id: json['_id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "price": price};
}

class Customization {
  final String id;
  final String name;
  final double price;

  Customization({required this.id, required this.name, required this.price});

  factory Customization.fromJson(Map<String, dynamic> json) => Customization(
    id: json['_id'],
    name: json['name'],
    price: (json['price'] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "price": price};
}
