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
  final String status;
  final String paymentMethod;
  final double totalPrice;
  final double tip;
  final double deliveryFee;
  final String orderType;
  final DateTime createdAt;
  final User user;
  final Restaurant restaurant;
  final List<Item> items;

  Order({
    required this.id,
    required this.status,
    required this.paymentMethod,
    required this.totalPrice,
    required this.tip,
    required this.deliveryFee,
    required this.orderType,
    required this.createdAt,
    required this.user,
    required this.restaurant,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'],
      status: json['status'],
      paymentMethod: json['payment_method'],
      totalPrice: (json['total_price'] as num).toDouble(),
      tip: (json['tip'] as num).toDouble(),
      deliveryFee: (json['delivery_fee'] as num).toDouble(),
      orderType: json['order_type'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      user: User.fromJson(json['user']),
      restaurant: Restaurant.fromJson(json['restaurant']),
      items: List<Item>.from(json['items'].map((x) => Item.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "status": status,
    "payment_method": paymentMethod,
    "total_price": totalPrice,
    "tip": tip,
    "delivery_fee": deliveryFee,
    "order_type": orderType,
    "created_at": createdAt.toIso8601String(),
    "user": user.toJson(),
    "restaurant": restaurant.toJson(),
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class User {
  final String name;
  final String email;

  User({required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json['name'], email: json['email']);
  }

  Map<String, dynamic> toJson() => {"name": name, "email": email};
}

class Restaurant {
  final String name;
  final String phone;

  Restaurant({required this.name, required this.phone});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(name: json['name'], phone: json['phone']);
  }

  Map<String, dynamic> toJson() => {"name": name, "phone": phone};
}

class Item {
  final String name;
  final int quantity;
  final double totalPricePerItem;

  Item({
    required this.name,
    required this.quantity,
    required this.totalPricePerItem,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      quantity: json['quantity'],
      totalPricePerItem: (json['total_price_per_item'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "quantity": quantity,
    "total_price_per_item": totalPricePerItem,
  };
}
