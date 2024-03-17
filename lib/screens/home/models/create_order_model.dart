class CreateOrderModel {
  bool? status;
  String? message;
  CreateOrderData? data;

  CreateOrderModel({this.status, this.message, this.data});

  CreateOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? CreateOrderData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CreateOrderData {
  String? restaurantId;
  String? customerId;
  String? customerLocationId;
  // ignore: prefer_void_to_null
  Null driverId;
  String? offer;
  List<OrderItems>? orderItems;
  dynamic orderPrice;
  String? paymentType;
  dynamic foodPrepStatus;
  dynamic driverAcceptStatus;
  dynamic cancelStatus;
  int? status;
  dynamic discountAmount;
  dynamic deliveryCharge;
  dynamic gstCharge;
  dynamic totalCost;
  double? lat;
  double? long;
  Location? location;
  int? restaurnatRating;
  int? driverRating;
  int? rejectByRestaurant;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CreateOrderData(
      {this.restaurantId,
      this.customerId,
      this.customerLocationId,
      this.driverId,
      this.offer,
      this.orderItems,
      this.orderPrice,
      this.paymentType,
      this.foodPrepStatus,
      this.driverAcceptStatus,
      this.cancelStatus,
      this.status,
      this.discountAmount,
      this.deliveryCharge,
      this.gstCharge,
      this.totalCost,
      this.lat,
      this.long,
      this.location,
      this.restaurnatRating,
      this.driverRating,
      this.rejectByRestaurant,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CreateOrderData.fromJson(Map<String, dynamic> json) {
    restaurantId = json['restaurantId'];
    customerId = json['customerId'];
    customerLocationId = json['customerLocationId'];
    driverId = json['driverId'];
    offer = json['offer'];
    if (json['orderItems'] != null) {
      orderItems = <OrderItems>[];
      json['orderItems'].forEach((v) {
        orderItems!.add(OrderItems.fromJson(v));
      });
    }
    orderPrice = json['orderPrice'];
    paymentType = json['paymentType'];
    foodPrepStatus = json['foodPrepStatus'];
    driverAcceptStatus = json['driverAcceptStatus'];
    cancelStatus = json['cancelStatus'];
    status = json['status'];
    discountAmount = json['discountAmount'];
    deliveryCharge = json['deliveryCharge'];
    gstCharge = json['gstCharge'];
    totalCost = json['totalCost'];
    lat = json['lat'];
    long = json['long'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    restaurnatRating = json['restaurnatRating'];
    driverRating = json['driverRating'];
    rejectByRestaurant = json['rejectByRestaurant'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['restaurantId'] = restaurantId;
    data['customerId'] = customerId;
    data['customerLocationId'] = customerLocationId;
    data['driverId'] = driverId;
    data['offer'] = offer;
    if (orderItems != null) {
      data['orderItems'] = orderItems!.map((v) => v.toJson()).toList();
    }
    data['orderPrice'] = orderPrice;
    data['paymentType'] = paymentType;
    data['foodPrepStatus'] = foodPrepStatus;
    data['driverAcceptStatus'] = driverAcceptStatus;
    data['cancelStatus'] = cancelStatus;
    data['status'] = status;
    data['discountAmount'] = discountAmount;
    data['deliveryCharge'] = deliveryCharge;
    data['gstCharge'] = gstCharge;
    data['totalCost'] = totalCost;
    data['lat'] = lat;
    data['long'] = long;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['restaurnatRating'] = restaurnatRating;
    data['driverRating'] = driverRating;
    data['rejectByRestaurant'] = rejectByRestaurant;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class OrderItems {
  String? item;
  int? quantity;
  String? image;
  int? price;

  OrderItems({this.item, this.quantity, this.image, this.price});

  OrderItems.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    quantity = json['quantity'];
    image = json['image'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item'] = item;
    data['quantity'] = quantity;
    data['image'] = image;
    data['price'] = price;
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
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
