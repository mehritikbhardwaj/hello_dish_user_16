// To parse this JSON data, do
//
//     final offersModel = offersModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OffersModel offersModelFromJson(String str) =>
    OffersModel.fromJson(json.decode(str));

String offersModelToJson(OffersModel data) => json.encode(data.toJson());

class OffersModel {
  bool success;
  List<RestaurantOffer> restaurant;

  OffersModel({
    required this.success,
    required this.restaurant,
  });

  factory OffersModel.fromJson(Map<String, dynamic> json) => OffersModel(
        success: json["success"],
        restaurant: List<RestaurantOffer>.from(
            json["restaurant"].map((x) => RestaurantOffer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "restaurant": List<dynamic>.from(restaurant.map((x) => x.toJson())),
      };
}

class RestaurantOffer {
  String id;
  String restaurantId;
  String code;
  String description;
  String image;
  int discount;
  int type;
  int upto;
  int above;
  int active;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  RestaurantOffer({
    required this.id,
    required this.restaurantId,
    required this.code,
    required this.description,
    required this.image,
    required this.discount,
    required this.type,
    required this.upto,
    required this.above,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory RestaurantOffer.fromJson(Map<String, dynamic> json) =>
      RestaurantOffer(
        id: json["_id"],
        restaurantId: json["restaurantId"],
        code: json["code"],
        description: json["description"],
        image: json["image"],
        discount: json["discount"],
        type: json["type"],
        upto: json["upto"],
        above: json["above"],
        active: json["active"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "restaurantId": restaurantId,
        "code": code,
        "description": description,
        "image": image,
        "discount": discount,
        "type": type,
        "upto": upto,
        "above": above,
        "active": active,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
