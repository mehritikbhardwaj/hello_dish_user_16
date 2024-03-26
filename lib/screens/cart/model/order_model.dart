var isList = true;

class OrderModel {
  bool? status;
  OrderData? data;

  OrderModel({this.status, this.data});

  OrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    final obj = OrderData.fromJson(json['data'] as Map<String, dynamic>);
    data = obj;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['data'] = this.data;
    return data;
  }
}

class OrderData {
  Location? location;
  String? sId;
  String? customerId;
  // String? customerLocationId;
  String? offer;
  List<OrderItems>? orderItems;
  dynamic orderPrice;
  String? paymentType;
  dynamic foodPrepStatus;
  int? driverAcceptStatus;
  int? cancelStatus;
  int? status;
  dynamic discountAmount;
  dynamic deliveryCharge;
  dynamic gstCharge;
  dynamic totalCost;
  dynamic packingCharge;
  double? lat;
  double? long;
  int? restaurnatRating;
  int? driverRating;
  int? rejectByRestaurant;
  int? adminPaidToRestaurant;
  int? adminPaidToDriver;
  String? createdAt;
  String? updatedAt;
  int? iV;

  OrderData(
      {this.location,
      this.sId,
      this.customerId,
      // this.customerLocationId,
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
      this.packingCharge,
      this.lat,
      this.long,
      this.restaurnatRating,
      this.driverRating,
      this.rejectByRestaurant,
      this.adminPaidToRestaurant,
      this.adminPaidToDriver,
      this.createdAt,
      this.updatedAt,
      this.iV});

  OrderData.fromJson(Map<String, dynamic> json) {
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    sId = json['_id'];
    customerId = json['customerId'];
    // customerLocationId = json['customerLocationId'];
    // customerLocationId = json['customerLocationId'] != null
    //     ? CustomerLocationId.fromJson(json['customerLocationId'])
    //     : null;
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
    packingCharge = json['packingCharge'];
    lat = json['lat'];
    long = json['long'];
    restaurnatRating = json['restaurnatRating'];
    driverRating = json['driverRating'];
    rejectByRestaurant = json['rejectByRestaurant'];
    adminPaidToRestaurant = json['adminPaidToRestaurant'];
    adminPaidToDriver = json['adminPaidToDriver'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['_id'] = sId;
    data['customerId'] = customerId;
    // data['customerLocationId'] = customerLocationId;
    // if (customerLocationId != null) {
    //   data['customerLocationId'] = customerLocationId!.toJson();
    // }
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
    data['packingCharge'] = packingCharge;
    data['lat'] = lat;
    data['long'] = long;
    data['restaurnatRating'] = restaurnatRating;
    data['driverRating'] = driverRating;
    data['rejectByRestaurant'] = rejectByRestaurant;
    data['adminPaidToRestaurant'] = adminPaidToRestaurant;
    data['adminPaidToDriver'] = adminPaidToDriver;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
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

class CustomerLocationId {
  String? sId;
  String? customerId;
  String? locationSaveAs;
  String? houseNo;
  String? area;
  String? address;
  double? lat;
  double? long;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CustomerLocationId(
      {this.sId,
      this.customerId,
      this.locationSaveAs,
      this.houseNo,
      this.area,
      this.address,
      this.lat,
      this.long,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CustomerLocationId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customerId = json['customerId'];
    locationSaveAs = json['locationSaveAs'];
    houseNo = json['houseNo'];
    area = json['area'];
    address = json['address'];
    lat = json['lat'];
    long = json['long'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['customerId'] = customerId;
    data['locationSaveAs'] = locationSaveAs;
    data['houseNo'] = houseNo;
    data['area'] = area;
    data['address'] = address;
    data['lat'] = lat;
    data['long'] = long;
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
