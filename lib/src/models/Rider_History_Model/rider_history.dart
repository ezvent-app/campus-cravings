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
}

class Order {
  final String id;
  final Address address;
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
    required this.address,
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
      address: Address.fromJson(json['address']),
      status: json['status'],
      paymentMethod: json['payment_method'],
      totalPrice: (json['total_price'] as num).toDouble(),
      tip: (json['tip'] as num).toDouble(),
      deliveryFee: (json['delivery_fee'] as num).toDouble(),
      orderType: json['order_type'],
      createdAt: DateTime.parse(json['created_at']),
      user: User.fromJson(json['user']),
      restaurant: Restaurant.fromJson(json['restaurant']),
      items: List<Item>.from(json['items'].map((x) => Item.fromJson(x))),
    );
  }
}

class Address {
  final Coordinates coordinates;
  final String? address; // make optional

  Address({required this.coordinates, this.address});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      coordinates: Coordinates.fromJson(json['coordinates']),
      address: json['address'], // can be null
    );
  }
}

class Coordinates {
  final String type;
  final List<double> coordinates;

  Coordinates({required this.type, required this.coordinates});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      type: json['type'],
      coordinates: List<double>.from(
        json['coordinates'].map((x) => (x as num).toDouble()),
      ),
    );
  }
}

class User {
  final String name;
  final String email;
  final String image; // added imageUrl

  User({
    required this.name,
    required this.email,
    this.image = '',
  }); // default value for imageUrl

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      image: json['image'] ?? '',
    );
  }
}

class Restaurant {
  final String name;
  final String phone;
  final List<String> image;

  Restaurant({required this.name, required this.phone, required this.image});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      name: json['name'],
      phone: json['phone'],
      image: List<String>.from(json['image'] ?? []),
    );
  }
}

class Item {
  final String name;
  final int quantity;
  final double totalPricePerItem;
  final List<Customization> customizationList;
  final Size? size; // make optional

  Item({
    required this.name,
    required this.quantity,
    required this.totalPricePerItem,
    required this.customizationList,
    this.size,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['name'],
      quantity: json['quantity'],
      totalPricePerItem: (json['total_price_per_item'] as num).toDouble(),
      customizationList: List<Customization>.from(
        json['customizationList'].map((x) => Customization.fromJson(x)),
      ),
      size: json['size'] != null ? Size.fromJson(json['size']) : null,
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
