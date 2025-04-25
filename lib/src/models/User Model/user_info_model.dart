class UserModel {
  String? message;
  UserInfo? userInfo;

  UserModel({this.message, this.userInfo});

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userInfo =
        json['userInfo'] != null
            ? new UserInfo.fromJson(json['userInfo'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.userInfo != null) {
      data['userInfo'] = this.userInfo!.toJson();
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
        addresses!.add(new Addresses.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['phoneNumber'] = this.phoneNumber;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['fullName'] = this.fullName;
    data['userName'] = this.userName;
    data['authMethod'] = this.authMethod;
    data['email'] = this.email;
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['isRestaurant'] = this.isRestaurant;
    data['isDelivery'] = this.isDelivery;
    data['isCustomer'] = this.isCustomer;
    data['isAdmin'] = this.isAdmin;
    data['isEmailVerified'] = this.isEmailVerified;
    data['isPhoneVerified'] = this.isPhoneVerified;
    data['isProfileCompleted'] = this.isProfileCompleted;
    data['lastAccess'] = this.lastAccess;
    data['notificationCount'] = this.notificationCount;
    data['planPro'] = this.planPro;
    data['__v'] = this.iV;
    data['imgUrl'] = this.imgUrl;
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
            ? new Coordinates.fromJson(json['coordinates'])
            : null;
    address = json['address'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates!.toJson();
    }
    data['address'] = this.address;
    data['_id'] = this.sId;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}
