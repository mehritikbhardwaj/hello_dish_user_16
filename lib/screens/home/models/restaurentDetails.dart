import 'dart:convert';

RestDetailsModel restDetailsModelFromJson(String str) =>
    RestDetailsModel.fromJson(json.decode(str));

String restDetailsModelToJson(RestDetailsModel data) =>
    json.encode(data.toJson());

class RestDetailsModel {
  RestDetailsModel({
    required this.status,
    required this.data,
  });

  bool status;
  Data data;

  factory RestDetailsModel.fromJson(Map<String, dynamic> json) =>
      RestDetailsModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.restaurant,
    required this.restaurantTiming,
    required this.restaurantOffer,
    required this.isFav,
    required this.item,
    required this.recommended,
    required this.previousOrder,
  });

  RestaurantDetails restaurant;
  RestaurantTiming restaurantTiming;
  List<RestaurantOffer> restaurantOffer;
  int isFav;
  List<ItemWrapper> item;
  List<dynamic> recommended;
  List<PreviousOrder> previousOrder;

  factory Data.fromJson(Map<String, dynamic> json) {
    // if (json["restaurant"] != null) {
    //   throw Exception("Restaurant data is missing");
    // }

    if (json["restaurant"] != null &&
        json["restaurant"] is Map<String, dynamic>) {
      return Data(
        restaurant: RestaurantDetails.fromJson(json["restaurant"]),
        restaurantTiming: RestaurantTiming.fromJson(json["restaurantTiming"]),
        restaurantOffer: List<RestaurantOffer>.from(
            json["restaurantOffer"].map((x) => RestaurantOffer.fromJson(x))),
        isFav: json["isFav"],
        item: List<ItemWrapper>.from(
            json["item"].map((x) => ItemWrapper.fromJson(x))),
        recommended: List<dynamic>.from(json["recommended"].map((x) => x)),
        previousOrder: List<PreviousOrder>.from(
            json["previousOrder"].map((x) => PreviousOrder.fromJson(x))),
      );
    } else {
      throw Exception("Restaurant data is missing or not properly formatted");
    }
  }

  // factory Data.fromJson(Map<String, dynamic> json) => Data(
  //   restaurant: Restaurant.fromJson(json["restaurant"]),
  //   restaurantTiming: RestaurantTiming.fromJson(json["restaurantTiming"]),
  //   restaurantOffer: List<RestaurantOffer>.from(
  //       json["restaurantOffer"].map((x) => RestaurantOffer.fromJson(x))),
  //   isFav: json["isFav"],
  //   item: List<Item>.from(json["item"].map((x) => Item.fromJson(x))),
  //   recommended: List<dynamic>.from(json["recommended"].map((x) => x)),
  //   previousOrder: List<PreviousOrder>.from(
  //       json["previousOrder"].map((x) => PreviousOrder.fromJson(x))),
  // );

  Map<String, dynamic> toJson() => {
        "restaurant": restaurant.toJson(),
        "restaurantTiming": restaurantTiming.toJson(),
        "restaurantOffer":
            List<dynamic>.from(restaurantOffer.map((x) => x.toJson())),
        "isFav": isFav,
        "item": List<dynamic>.from(item.map((x) => x.toJson())),
        "recommended": List<dynamic>.from(recommended.map((x) => x)),
        "previousOrder":
            List<dynamic>.from(previousOrder.map((x) => x.toJson())),
      };
}

class Meal {
  String id;
  String restaurantId;
  String name;
  int active;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Meal({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        id: json["_id"],
        restaurantId: json["restaurantId"],
        name: json["name"],
        active: json["active"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "restaurantId": restaurantId,
        "name": name,
        "active": active,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Item {
  String id;
  String mealId;
  Map<String, dynamic> categoryId;
  String restaurantId;
  String restaurantTimingId;
  Map<String, dynamic> subCategoryId;
  String name;
  int price;
  String image;
  int size;
  int isFrom;
  int vegNonVeg;
  String quantityType;
  int rating;
  int reviewCount;
  int active;
  int takingTime;
  DateTime createdAt;
  DateTime updatedAt;
  int quantity = 0;
  int v;

  Item({
    required this.id,
    required this.mealId,
    required this.categoryId,
    required this.restaurantId,
    required this.restaurantTimingId,
    required this.subCategoryId,
    required this.name,
    required this.price,
    required this.image,
    required this.size,
    required this.isFrom,
    required this.vegNonVeg,
    required this.quantityType,
    required this.rating,
    required this.reviewCount,
    required this.active,
    required this.takingTime,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["_id"],
        mealId: json["mealId"],
        categoryId: json["categoryId"],
        restaurantId: json["restaurantId"],
        restaurantTimingId: json["restaurantTimingId"],
        subCategoryId: json["subCategoryId"],
        name: json["name"],
        price: json["price"],
        image: json["image"],
        size: json["size"],
        isFrom: json["isFrom"],
        vegNonVeg: json["vegNonVeg"],
        quantityType: json["quantity_type"],
        rating: json["rating"],
        reviewCount: json["reviewCount"],
        active: json["active"],
        takingTime: json["takingTime"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "mealId": mealId,
        "categoryId": categoryId,
        "restaurantId": restaurantId,
        "restaurantTimingId": restaurantTimingId,
        "subCategoryId": subCategoryId,
        "name": name,
        "price": price,
        "image": image,
        "size": size,
        "isFrom": isFrom,
        "vegNonVeg": vegNonVeg,
        "quantity_type": quantityType,
        "rating": rating,
        "reviewCount": reviewCount,
        "active": active,
        "takingTime": takingTime,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class ItemWrapper {
  Meal meal;
  List<Item> items;
  int itemLength;
  bool isExpanded = false;

  ItemWrapper({
    required this.meal,
    required this.items,
    required this.itemLength,
  });

  factory ItemWrapper.fromJson(Map<String, dynamic> json) => ItemWrapper(
        meal: Meal.fromJson(json["meal"]),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        itemLength: json["itemLength"],
      );

  Map<String, dynamic> toJson() => {
        "meal": meal.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "itemLength": itemLength,
      };
}

class PreviousOrder {
  PreviousOrder({
    required this.id,
    required this.location,
    required this.restaurantId,
    required this.customerId,
    required this.customerLocationId,
    required this.driverId,
    required this.offer,
    required this.orderItems,
    required this.orderPrice,
    required this.paymentType,
    required this.foodPrepStatus,
    required this.driverAcceptStatus,
    required this.cancelStatus,
    required this.status,
    required this.discountAmount,
    required this.deliveryCharge,
    required this.gstCharge,
    required this.totalCost,
    required this.packingCharge,
    required this.lat,
    required this.long,
    required this.restaurantRating,
    required this.driverRating,
    required this.rejectByRestaurant,
    required this.adminPaidToRestaurant,
    required this.adminPaidToDriver,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  Location location;
  String restaurantId;
  String customerId;
  String customerLocationId;
  String? driverId;
  String offer;
  List<OrderItem> orderItems;
  int orderPrice;
  String paymentType;
  int foodPrepStatus;
  int driverAcceptStatus;
  int cancelStatus;
  int status;
  int discountAmount;
  dynamic deliveryCharge;
  dynamic gstCharge;
  dynamic totalCost;
  dynamic packingCharge;
  double lat;
  double long;
  int restaurantRating;
  int driverRating;
  int rejectByRestaurant;
  int adminPaidToRestaurant;
  int adminPaidToDriver;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory PreviousOrder.fromJson(Map<String, dynamic> json) => PreviousOrder(
        id: json["_id"],
        location: Location.fromJson(json["location"]),
        restaurantId: json["restaurantId"],
        customerId: json["customerId"],
        customerLocationId: json["customerLocationId"],
        driverId: json["driverId"],
        offer: json["offer"],
        orderItems: List<OrderItem>.from(
            json["orderItems"].map((x) => OrderItem.fromJson(x))),
        orderPrice: json["orderPrice"],
        paymentType: json["paymentType"],
        foodPrepStatus: json["foodPrepStatus"],
        driverAcceptStatus: json["driverAcceptStatus"],
        cancelStatus: json["cancelStatus"],
        status: json["status"],
        discountAmount: json["discountAmount"],
        deliveryCharge: json["deliveryCharge"],
        gstCharge: json["gstCharge"],
        totalCost: json["totalCost"],
        packingCharge: json["packingCharge"],
        lat: json["lat"].toDouble(),
        long: json["long"].toDouble(),
        restaurantRating: json["restaurnatRating"],
        driverRating: json["driverRating"],
        rejectByRestaurant: json["rejectByRestaurant"],
        adminPaidToRestaurant: json["adminPaidToRestaurant"],
        adminPaidToDriver: json["adminPaidToDriver"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "location": location.toJson(),
        "restaurantId": restaurantId,
        "customerId": customerId,
        "customerLocationId": customerLocationId,
        "driverId": driverId,
        "offer": offer,
        "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "orderPrice": orderPrice,
        "paymentType": paymentType,
        "foodPrepStatus": foodPrepStatus,
        "driverAcceptStatus": driverAcceptStatus,
        "cancelStatus": cancelStatus,
        "status": status,
        "discountAmount": discountAmount,
        "deliveryCharge": deliveryCharge,
        "gstCharge": gstCharge,
        "totalCost": totalCost,
        "packingCharge": packingCharge,
        "lat": lat,
        "long": long,
        "restaurnatRating": restaurantRating,
        "driverRating": driverRating,
        "rejectByRestaurant": rejectByRestaurant,
        "adminPaidToRestaurant": adminPaidToRestaurant,
        "adminPaidToDriver": adminPaidToDriver,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Location {
  Location({
    required this.type,
    required this.coordinates,
  });

  String type;
  List<double> coordinates;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class OrderItem {
  OrderItem({
    required this.item,
    required this.quantity,
    required this.image,
    required this.price,
  });

  String item;
  int quantity;
  String image;
  dynamic price;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        item: json["item"],
        quantity: json["quantity"],
        image: json["image"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "item": item,
        "quantity": quantity,
        "image": image,
        "price": price,
      };
}

class RestaurantDetails {
  RestaurantDetails({
    required this.id,
    required this.name,
    required this.restAddress,
    required this.city,
    required this.state,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.rating,
  });

  String id;
  String name;
  String restAddress;
  String city;
  String state;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  int rating;

  factory RestaurantDetails.fromJson(Map<String, dynamic> json) =>
      RestaurantDetails(
          id: json["_id"],
          name: json["restaurantName"],
          restAddress: json["restaurantAddress"],
          city: json["city"],
          state: json["state"],
          createdAt: DateTime.parse(json["createdAt"]),
          updatedAt: DateTime.parse(json["updatedAt"]),
          v: json["__v"],
          rating: json['rating']);

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": restAddress,
        "city": city,
        "state": state,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class RestaurantOffer {
  RestaurantOffer({
    required this.id,
    required this.restaurantId,
    required this.offerCode,
    required this.description,
    required this.image,
    required this.discount,
    required this.type,
    required this.upto,
    required this.above,
    required this.active,
    required this.expiryDate,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String id;
  String restaurantId;
  String offerCode;
  String description;
  String image;
  int discount;
  int type;
  int upto;
  int above;
  int active;
  DateTime expiryDate;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory RestaurantOffer.fromJson(Map<String, dynamic> json) =>
      RestaurantOffer(
        id: json["_id"],
        restaurantId: json["restaurantId"],
        offerCode: json["code"],
        description: json["description"],
        image: json["image"],
        discount: json["discount"],
        type: json["type"],
        upto: json["upto"],
        above: json["above"],
        active: json["active"],
        expiryDate: DateTime.parse(json["expiryDate"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "restaurantId": restaurantId,
        "code": offerCode,
        "description": description,
        "image": image,
        "discount": discount,
        "type": type,
        "upto": upto,
        "above": above,
        "active": active,
        "expiryDate": expiryDate.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class RestaurantTiming {
  String id;
  String restaurantId;
  int monday;
  int tuesday;
  int wednesday;
  int thursday;
  int friday;
  int saturday;
  int sunday;
  int sameTime;
  String mondayTime;
  String tuesdayTime;
  String wednesdayTime;
  String thursdayTime;
  String fridayTime;
  String saturdayTime;
  String sundayTime;
  String time;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  RestaurantTiming({
    required this.id,
    required this.restaurantId,
    required this.monday,
    required this.mondayTime,
    required this.tuesday,
    required this.tuesdayTime,
    required this.wednesday,
    required this.wednesdayTime,
    required this.thursday,
    required this.thursdayTime,
    required this.friday,
    required this.fridayTime,
    required this.saturday,
    required this.saturdayTime,
    required this.sunday,
    required this.sundayTime,
    required this.sameTime,
    required this.time,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory RestaurantTiming.fromJson(Map<String, dynamic> json) {
    return RestaurantTiming(
      id: json["_id"],
      restaurantId: json["restaurantId"],
      monday: json["monday"],
      mondayTime: json["mondayTime"],
      tuesday: json["tuesday"],
      tuesdayTime: json["tuesdayTime"],
      wednesday: json["wednesday"],
      wednesdayTime: json["wednesdayTime"],
      thursday: json["thursday"],
      thursdayTime: json["thursdayTime"],
      friday: json["friday"],
      fridayTime: json["fridayTime"],
      saturday: json["saturday"],
      saturdayTime: json["saturdayTime"],
      sunday: json["sunday"],
      sundayTime: json["sundayTime"],
      sameTime: json["sameTime"],
      time: json["time"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "restaurantId": restaurantId,
      "monday": monday,
      "mondayTime": mondayTime,
      "tuesday": tuesday,
      "tuesdayTime": tuesdayTime,
      "wednesday": wednesday,
      "wednesdayTime": wednesdayTime,
      "thursday": thursday,
      "thursdayTime": thursdayTime,
      "friday": friday,
      "fridayTime": fridayTime,
      "saturday": saturday,
      "saturdayTime": saturdayTime,
      "sunday": sunday,
      "sundayTime": sundayTime,
      "sameTime": sameTime,
      "time": time,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "__v": v,
    };
  }
}
