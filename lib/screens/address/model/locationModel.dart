// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

LocationModel locationModelFromJson(String str) =>
    LocationModel.fromJson(json.decode(str));

String locationModelToJson(LocationModel data) => json.encode(data.toJson());

class LocationModel {
  bool success;
  List<LocationData> location;

  LocationModel({
    required this.success,
    required this.location,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        success: json["success"],
        location: List<LocationData>.from(
            json["Location"].map((x) => LocationData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "Location": List<dynamic>.from(location.map((x) => x.toJson())),
      };
}

class LocationData {
  String id;
  String customerId;
  String locationSaveAs;
  String houseNo;
  String area;
  String address;
  double lat;
  double long;
  String createdAt;
  String updatedAt;
  int v;

  LocationData({
    required this.id,
    required this.customerId,
    required this.locationSaveAs,
    required this.houseNo,
    required this.area,
    required this.address,
    required this.lat,
    required this.long,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) => LocationData(
        id: json["_id"],
        customerId: json["customerId"],
        locationSaveAs: json["locationSaveAs"],
        houseNo: json["houseNo"],
        area: json["area"],
        address: json["address"],
        lat: json["lat"]?.toDouble(),
        long: json["long"]?.toDouble(),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "customerId": customerId,
        "locationSaveAs": locationSaveAs,
        "houseNo": houseNo,
        "area": area,
        "address": address,
        "lat": lat,
        "long": long,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
      };
}
