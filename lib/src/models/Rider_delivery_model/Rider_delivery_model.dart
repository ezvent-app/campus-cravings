class RiderDeliveryModel {
  String? message;
  Order? order;

  RiderDeliveryModel({this.message, this.order});

  RiderDeliveryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    return data;
  }
}

class Order {
  Addresses? addresses;
  String? sId;
  UserId? userId;
  String? orderNote;
  RestaurantId? restaurantId;
  Null? assignedTo;
  String? status;
  int? totalPrice;
  String? paymentMethod;
  int? tip;
  int? deliveryFee;
  String? estimatedTime;
  String? imageUrl;
  String? orderType;
  List<Items>? items;
  List<Progress>? progress;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Order({
    this.addresses,
    this.sId,
    this.userId,
    this.orderNote,
    this.restaurantId,
    this.assignedTo,
    this.status,
    this.totalPrice,
    this.paymentMethod,
    this.tip,
    this.deliveryFee,
    this.estimatedTime,
    this.imageUrl,
    this.orderType,
    this.items,
    this.progress,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Order.fromJson(Map<String, dynamic> json) {
    addresses =
        json['addresses'] != null
            ? new Addresses.fromJson(json['addresses'])
            : null;
    sId = json['_id'];
    userId =
        json['user_id'] != null ? new UserId.fromJson(json['user_id']) : null;
    orderNote = json['order_note'];
    restaurantId =
        json['restaurant_id'] != null
            ? new RestaurantId.fromJson(json['restaurant_id'])
            : null;
    assignedTo = json['assigned_to'];
    status = json['status'];
    totalPrice = json['total_price'];
    paymentMethod = json['payment_method'];
    tip = json['tip'];
    deliveryFee = json['delivery_fee'];
    estimatedTime = json['estimated_time'];
    imageUrl = json['image_url'];
    orderType = json['order_type'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    if (json['progress'] != null) {
      progress = <Progress>[];
      json['progress'].forEach((v) {
        progress!.add(new Progress.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.toJson();
    }
    data['_id'] = this.sId;
    if (this.userId != null) {
      data['user_id'] = this.userId!.toJson();
    }
    data['order_note'] = this.orderNote;
    if (this.restaurantId != null) {
      data['restaurant_id'] = this.restaurantId!.toJson();
    }
    data['assigned_to'] = this.assignedTo;
    data['status'] = this.status;
    data['total_price'] = this.totalPrice;
    data['payment_method'] = this.paymentMethod;
    data['tip'] = this.tip;
    data['delivery_fee'] = this.deliveryFee;
    data['estimated_time'] = this.estimatedTime;
    data['image_url'] = this.imageUrl;
    data['order_type'] = this.orderType;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.progress != null) {
      data['progress'] = this.progress!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Addresses {
  Coordinates? coordinates;
  String? address;

  Addresses({this.coordinates, this.address});

  Addresses.fromJson(Map<String, dynamic> json) {
    coordinates =
        json['coordinates'] != null
            ? new Coordinates.fromJson(json['coordinates'])
            : null;
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates!.toJson();
    }
    data['address'] = this.address;
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

class UserId {
  String? sId;
  String? firstName;
  String? lastName;
  String? imgUrl;
  String? phoneNumber;

  UserId({
    this.sId,
    this.firstName,
    this.lastName,
    this.imgUrl,
    this.phoneNumber,
  });

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    imgUrl = json['imgUrl'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['imgUrl'] = this.imgUrl;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}

class RestaurantId {
  String? sId;
  String? storeName;
  String? brandName;
  String? phoneNumber;

  RestaurantId({this.sId, this.storeName, this.brandName, this.phoneNumber});

  RestaurantId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    storeName = json['storeName'];
    brandName = json['brandName'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['storeName'] = this.storeName;
    data['brandName'] = this.brandName;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}

class Items {
  ItemId? itemId;
  int? quantity;
  List<String>? customizations;
  String? size;

  Items({this.itemId, this.quantity, this.customizations, this.size});

  Items.fromJson(Map<String, dynamic> json) {
    itemId =
        json['item_id'] != null ? new ItemId.fromJson(json['item_id']) : null;
    quantity = json['quantity'];
    customizations = json['customizations'].cast<String>();
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.itemId != null) {
      data['item_id'] = this.itemId!.toJson();
    }
    data['quantity'] = this.quantity;
    data['customizations'] = this.customizations;
    data['size'] = this.size;
    return data;
  }
}

class ItemId {
  String? sId;
  String? name;
  int? price;
  List<Sizes>? sizes;
  List<Customization>? customization;

  ItemId({this.sId, this.name, this.price, this.sizes, this.customization});

  ItemId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    price = json['price'];
    if (json['customization'] != null) {
      customization = <Customization>[];
      json['customization'].forEach((v) {
        customization!.add(new Customization.fromJson(v));
      });
    }
    if (json['sizes'] != null) {
      sizes = <Sizes>[];
      json['sizes'].forEach((v) {
        sizes!.add(new Sizes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['price'] = this.price;
    if (this.customization != null) {
      data['customization'] =
          this.customization!.map((v) => v.toJson()).toList();
    }
    if (this.sizes != null) {
      data['sizes'] = this.sizes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sizes {
  String? name;
  int? price;
  String? sId;

  Sizes({this.name, this.price, this.sId});

  Sizes.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['_id'] = this.sId;
    return data;
  }
}

class Customization {
  String? name;
  int? price;
  String? sId;

  Customization({this.name, this.price, this.sId});

  Customization.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['_id'] = this.sId;
    return data;
  }
}

class Progress {
  String? status;
  String? updatedAt;

  Progress({this.status, this.updatedAt});

  Progress.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
