class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String userName;
  final String authMethod;
  final String email;
  final int? activationCode;
  final List<Address> addresses;
  final String status;
  final bool isRestaurant;
  final bool isDelivery;
  final bool isCustomer;
  final bool isAdmin;
  final bool isEmailVerified;
  final bool isPhoneVerified;
  final bool isProfileCompleted;
  final DateTime lastAccess;
  final int notificationCount;
  final bool planPro;
  final String? imgUrl;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.userName,
    required this.authMethod,
    required this.email,
    this.activationCode,
    required this.addresses,
    required this.status,
    required this.isRestaurant,
    required this.isDelivery,
    required this.isCustomer,
    required this.isAdmin,
    required this.isEmailVerified,
    required this.isPhoneVerified,
    required this.isProfileCompleted,
    required this.lastAccess,
    required this.notificationCount,
    required this.planPro,
    this.imgUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      fullName: json['fullName'],
      userName: json['userName'],
      authMethod: json['authMethod'],
      email: json['email'],

      activationCode: json['activationCode'],
      addresses:
          (json['addresses'] as List<dynamic>)
              .map((e) => Address.fromJson(e))
              .toList(),
      status: json['status'],
      isRestaurant: json['isRestaurant'],
      isDelivery: json['isDelivery'],
      isCustomer: json['isCustomer'],
      isAdmin: json['isAdmin'],
      isEmailVerified: json['isEmailVerified'],
      isPhoneVerified: json['isPhoneVerified'],
      isProfileCompleted: json['isProfileCompleted'],
      lastAccess: DateTime.parse(json['lastAccess']),
      notificationCount: json['notificationCount'],
      planPro: json['planPro'],
      imgUrl: json['imgUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'firstName': firstName,
    'lastName': lastName,
    'fullName': fullName,
    'userName': userName,
    'authMethod': authMethod,
    'email': email,
    if (activationCode != null) 'activationCode': activationCode,
    'addresses': addresses.map((e) => e.toJson()).toList(),
    'status': status,
    'isRestaurant': isRestaurant,
    'isDelivery': isDelivery,
    'isCustomer': isCustomer,
    'isAdmin': isAdmin,
    'isEmailVerified': isEmailVerified,
    'isPhoneVerified': isPhoneVerified,
    'isProfileCompleted': isProfileCompleted,
    'lastAccess': lastAccess.toIso8601String(),
    'notificationCount': notificationCount,
    'planPro': planPro,
    if (imgUrl != null) 'imgUrl': imgUrl,
  };
}

class Address {
  final String id;
  final String address;
  final Coordinates coordinates;

  Address({required this.id, required this.address, required this.coordinates});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['_id'],
      address: json['address'],
      coordinates: Coordinates.fromJson(json['coordinates']),
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
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
      type: json['type'],
      coordinates: List<double>.from(
        json['coordinates'].map((e) => e.toDouble()),
      ),
    );
  }

  Map<String, dynamic> toJson() => {'type': type, 'coordinates': coordinates};
}
