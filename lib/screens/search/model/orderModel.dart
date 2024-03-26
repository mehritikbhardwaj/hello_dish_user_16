// To parse this JSON data, do
//
//     final searchOrderModel = searchOrderModelFromJson(jsonString);

import 'dart:convert';

SearchOrderModel searchOrderModelFromJson(String str) => SearchOrderModel.fromJson(json.decode(str));

String searchOrderModelToJson(SearchOrderModel data) => json.encode(data.toJson());

class SearchOrderModel {
  bool status;
  List<Datum> data;

  SearchOrderModel({
    required this.status,
    required this.data,
  });

  factory SearchOrderModel.fromJson(Map<String, dynamic> json) => SearchOrderModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String id;
  String mealId;
  CategoryId categoryId;
  RestaurantId restaurantId;
  RestaurantTimingId restaurantTimingId;
  String subCategoryId;
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
  int v;
  int isFav;

  Datum({
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
    required this.isFav,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    mealId: json["mealId"],
    categoryId: CategoryId.fromJson(json["categoryId"]),
    restaurantId: RestaurantId.fromJson(json["restaurantId"]),
    restaurantTimingId: RestaurantTimingId.fromJson(json["restaurantTimingId"]),
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
    isFav: json["isFav"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "mealId": mealId,
    "categoryId": categoryId.toJson(),
    "restaurantId": restaurantId.toJson(),
    "restaurantTimingId": restaurantTimingId.toJson(),
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
    "isFav": isFav,
  };
}

class CategoryId {
  String id;
  String name;
  int active;
  int admin;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String image;

  CategoryId({
    required this.id,
    required this.name,
    required this.active,
    required this.admin,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.image,
  });

  factory CategoryId.fromJson(Map<String, dynamic> json) => CategoryId(
    id: json["_id"],
    name: json["name"],
    active: json["active"],
    admin: json["admin"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "active": active,
    "admin": admin,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "image": image,
  };
}

class RestaurantId {
  String id;
  String ownerName;
  String restaurantName;
  String restaurantAddress;
  double restaurantLat;
  double restaurantLong;
  String email;
  String phone;
  String password;
  int active;
  DateTime otpCreatedAt;
  int rating;
  String state;
  String city;
  int userType;
  int onlineOffline;
  int restaurantReview;
  String uniqueId;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String otp;
  String profileImage;

  RestaurantId({
    required this.id,
    required this.ownerName,
    required this.restaurantName,
    required this.restaurantAddress,
    required this.restaurantLat,
    required this.restaurantLong,
    required this.email,
    required this.phone,
    required this.password,
    required this.active,
    required this.otpCreatedAt,
    required this.rating,
    required this.state,
    required this.city,
    required this.userType,
    required this.onlineOffline,
    required this.restaurantReview,
    required this.uniqueId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.otp,
    required this.profileImage,
  });

  factory RestaurantId.fromJson(Map<String, dynamic> json) => RestaurantId(
    id: json["_id"],
    ownerName: json["ownerName"],
    restaurantName: json["restaurantName"],
    restaurantAddress: json["restaurantAddress"],
    restaurantLat: json["restaurantLat"]?.toDouble(),
    restaurantLong: json["restaurantLong"]?.toDouble(),
    email: json["email"],
    phone: json["phone"],
    password: json["password"],
    active: json["active"],
    otpCreatedAt: DateTime.parse(json["otpCreatedAt"]),
    rating: json["rating"],
    state: json["state"],
    city: json["city"],
    userType: json["userType"],
    onlineOffline: json["onlineOffline"],
    restaurantReview: json["restaurantReview"],
    uniqueId: json["uniqueId"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    otp: json["otp"],
    profileImage: json["profileImage"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "ownerName": ownerName,
    "restaurantName": restaurantName,
    "restaurantAddress": restaurantAddress,
    "restaurantLat": restaurantLat,
    "restaurantLong": restaurantLong,
    "email": email,
    "phone": phone,
    "password": password,
    "active": active,
    "otpCreatedAt": otpCreatedAt.toIso8601String(),
    "rating": rating,
    "state": state,
    "city": city,
    "userType": userType,
    "onlineOffline": onlineOffline,
    "restaurantReview": restaurantReview,
    "uniqueId": uniqueId,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "otp": otp,
    "profileImage": profileImage,
  };
}

class RestaurantTimingId {
  String id;
  String restaurantId;
  int monday;
  String mondayTime;
  int tuesday;
  String tuesdayTime;
  int wednesday;
  String wednesdayTime;
  int thursday;
  String thursdayTime;
  int friday;
  String fridayTime;
  int saturday;
  String saturdayTime;
  int sunday;
  String sundayTime;
  int sameTime;
  String time;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  RestaurantTimingId({
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

  factory RestaurantTimingId.fromJson(Map<String, dynamic> json) => RestaurantTimingId(
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

  Map<String, dynamic> toJson() => {
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
