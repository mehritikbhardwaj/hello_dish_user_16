// To parse this JSON data, do
//
//     final favResturantModel = favResturantModelFromJson(jsonString);

import 'dart:convert';

FavResturantModel favResturantModelFromJson(String str) => FavResturantModel.fromJson(json.decode(str));

String favResturantModelToJson(FavResturantModel data) => json.encode(data.toJson());

class FavResturantModel {
  bool status;
  List<Datum> data;

  FavResturantModel({
    required this.status,
    required this.data,
  });

  factory FavResturantModel.fromJson(Map<String, dynamic> json) => FavResturantModel(
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
  RestaurantId restaurantId;
  String customerId;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Datum({
    required this.id,
    required this.restaurantId,
    required this.customerId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    restaurantId: RestaurantId.fromJson(json["restaurantId"]),
    customerId: json["customerId"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "restaurantId": restaurantId.toJson(),
    "customerId": customerId,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
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
