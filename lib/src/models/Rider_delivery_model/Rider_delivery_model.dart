class RiderDeliveryModel {
  String? message;
  Order? order;
 
  RiderDeliveryModel({this.message, this.order});
 
  RiderDeliveryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    order = json['data'] != null ? Order.fromJson(json['data']) : null;
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = message;
    if (order != null) {
      data['data'] = order!.toJson();
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
  String? assignedTo;
  String? status;
  double? totalPrice;
  String? paymentMethod;
  double? tip;
  double? deliveryFee;
  String? estimatedTime;
  String? imageUrl;
  String? orderType;
  List<Items>? items;
  List<Progress>? progress;
  String? createdAt;
  String? updatedAt;
  double? iV;
 
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
            ? Addresses.fromJson(json['addresses'])
            : null;
    sId = json['_id'];
    userId = json['user_id'] != null ? UserId.fromJson(json['user_id']) : null;
    orderNote = json['order_note'];
    restaurantId =
        json['restaurant_id'] != null
            ? RestaurantId.fromJson(json['restaurant_id'])
            : null;
    assignedTo = json['assigned_to'] ?? "";
    status = json['status'];
    totalPrice = (json['total_price'] as num?)?.toDouble();
    paymentMethod = json['payment_method'];
    tip = (json['tip'] as num?)?.toDouble();
    deliveryFee = (json['delivery_fee'] as num?)?.toDouble();
    estimatedTime = json['estimated_time'];
    imageUrl = json['image_url'];
    orderType = json['order_type'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    if (json['progress'] != null) {
      progress = <Progress>[];
      json['progress'].forEach((v) {
        progress!.add(Progress.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = (json['__v'] as num?)?.toDouble();
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (addresses != null) {
      data['addresses'] = addresses!.toJson();
    }
    data['_id'] = sId;
    if (userId != null) {
      data['user_id'] = userId!.toJson();
    }
    data['order_note'] = orderNote;
    if (restaurantId != null) {
      data['restaurant_id'] = restaurantId!.toJson();
    }
    data['assigned_to'] = assignedTo;
    data['status'] = status;
    data['total_price'] = totalPrice;
    data['payment_method'] = paymentMethod;
    data['tip'] = tip;
    data['delivery_fee'] = deliveryFee;
    data['estimated_time'] = estimatedTime;
    data['image_url'] = imageUrl;
    data['order_type'] = orderType;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (progress != null) {
      data['progress'] = progress!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['__v'] = iV;
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
            ? Coordinates.fromJson(json['coordinates'])
            : null;
    address = json['address'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (coordinates != null) {
      data['coordinates'] = coordinates!.toJson();
    }
    data['address'] = address;
    return data;
  }
}
 
class Coordinates {
  String? type;
  List<double>? coordinates;
 
  Coordinates({this.type, this.coordinates});
 
  Coordinates.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates =
        (json['coordinates'] as List)
            .map((e) => (e as num).toDouble())
            .toList();
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['type'] = type;
    data['coordinates'] = coordinates;
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
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['imgUrl'] = imgUrl;
    data['phoneNumber'] = phoneNumber;
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
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['storeName'] = storeName;
    data['brandName'] = brandName;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
 
class Items {
  ItemId? itemId;
  double? quantity;
  List<String>? customizations;
  String? size;
 
  Items({this.itemId, this.quantity, this.customizations, this.size});
 
  Items.fromJson(Map<String, dynamic> json) {
    itemId = json['item_id'] != null ? ItemId.fromJson(json['item_id']) : null;
    quantity = (json['quantity'] as num?)?.toDouble();
    customizations =
        json['customizations'] != null
            ? List<String>.from(json['customizations'])
            : [];
    size = json['size'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (itemId != null) {
      data['item_id'] = itemId!.toJson();
    }
    data['quantity'] = quantity;
    data['customizations'] = customizations;
    data['size'] = size;
    return data;
  }
}
 
class ItemId {
  String? sId;
  String? name;
  double? price;
  List<Sizes>? sizes;
  List<Customization>? customization;
 
  ItemId({this.sId, this.name, this.price, this.sizes, this.customization});
 
  ItemId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    price = (json['price'] as num?)?.toDouble();
    if (json['customization'] != null) {
      customization = <Customization>[];
      json['customization'].forEach((v) {
        customization!.add(Customization.fromJson(v));
      });
    }
    if (json['sizes'] != null) {
      sizes = <Sizes>[];
      json['sizes'].forEach((v) {
        sizes!.add(Sizes.fromJson(v));
      });
    }
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['name'] = name;
    data['price'] = price;
    if (customization != null) {
      data['customization'] = customization!.map((v) => v.toJson()).toList();
    }
    if (sizes != null) {
      data['sizes'] = sizes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
 
class Sizes {
  String? name;
  double? price;
  String? sId;
 
  Sizes({this.name, this.price, this.sId});
 
  Sizes.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "Regular";
    price = (json['price'] as num?)?.toDouble();
    sId = json['_id'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['price'] = price;
    data['_id'] = sId;
    return data;
  }
}
 
class Customization {
  String? name;
  double? price;
  String? sId;
 
  Customization({this.name, this.price, this.sId});
 
  Customization.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = (json['price'] as num?)?.toDouble();
    sId = json['_id'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['price'] = price;
    data['_id'] = sId;
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
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['updated_at'] = updatedAt;
    return data;
  }
}
 
 