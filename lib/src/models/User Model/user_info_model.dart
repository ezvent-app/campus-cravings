class UserModel {
  String? message;
  UserInfo? userInfo;

  UserModel({this.message, this.userInfo});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userInfo =
        json['userInfo'] != null ? UserInfo.fromJson(json['userInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (userInfo != null) {
      data['userInfo'] = userInfo!.toJson();
    }
    return data;
  }
}

class UserInfo {
  String? sId;
  String? firstName;
  String? lastName;
  String? fullName;
  String? userName;
  String? authMethod;
  String? email;
  String? phoneNumber;
  List<Addresses>? addresses;
  String? status;
  bool? isRestaurant;
  bool? isDelivery;
  bool? isCustomer;
  bool? isAdmin;
  bool? isEmailVerified;
  bool? isPhoneVerified;
  bool? isProfileCompleted;
  String? lastAccess;
  int? notificationCount;
  bool? planPro;
  int? iV;
  String? imgUrl;

  UserInfo({
    this.sId,
    this.firstName,
    this.lastName,
    this.fullName,
    this.userName,
    this.authMethod,
    this.email,
    this.addresses,
    this.status,
    this.isRestaurant,
    this.isDelivery,
    this.isCustomer,
    this.isAdmin,
    this.isEmailVerified,
    this.isPhoneVerified,
    this.isProfileCompleted,
    this.lastAccess,
    this.notificationCount,
    this.planPro,
    this.iV,
    this.phoneNumber,
    this.imgUrl,
  });

  UserInfo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    phoneNumber = json['phoneNumber'];
    lastName = json['lastName'];
    fullName = json['fullName'];
    userName = json['userName'];
    authMethod = json['authMethod'];
    email = json['email'];
    if (json['addresses'] != null) {
      addresses = <Addresses>[];
      json['addresses'].forEach((v) {
        addresses!.add(Addresses.fromJson(v));
      });
    }
    status = json['status'];
    isRestaurant = json['isRestaurant'];
    isDelivery = json['isDelivery'];
    isCustomer = json['isCustomer'];
    isAdmin = json['isAdmin'];
    isEmailVerified = json['isEmailVerified'];
    isPhoneVerified = json['isPhoneVerified'];
    isProfileCompleted = json['isProfileCompleted'];
    lastAccess = json['lastAccess'];
    notificationCount = json['notificationCount'];
    planPro = json['planPro'];
    iV = json['__v'];
    imgUrl = json['imgUrl'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['phoneNumber'] = phoneNumber;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['fullName'] = fullName;
    data['userName'] = userName;
    data['authMethod'] = authMethod;
    data['email'] = email;
    if (addresses != null) {
      data['addresses'] = addresses!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['isRestaurant'] = isRestaurant;
    data['isDelivery'] = isDelivery;
    data['isCustomer'] = isCustomer;
    data['isAdmin'] = isAdmin;
    data['isEmailVerified'] = isEmailVerified;
    data['isPhoneVerified'] = isPhoneVerified;
    data['isProfileCompleted'] = isProfileCompleted;
    data['lastAccess'] = lastAccess;
    data['notificationCount'] = notificationCount;
    data['planPro'] = planPro;
    data['__v'] = iV;
    data['imgUrl'] = imgUrl;
    return data;
  }
}

class Addresses {
  Coordinates? coordinates;
  String? address;
  String? sId;

  Addresses({this.coordinates, this.address, this.sId});

  Addresses.fromJson(Map<String, dynamic> json) {
    coordinates =
        json['coordinates'] != null
            ? Coordinates.fromJson(json['coordinates'])
            : null;
    address = json['address'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (coordinates != null) {
      data['coordinates'] = coordinates!.toJson();
    }
    data['address'] = address;
    data['_id'] = sId;
    return data;
  }
}

class Coordinates {
  String? type;
  List<double>? coordinates;

  Coordinates({this.type, this.coordinates});

  Coordinates.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}
