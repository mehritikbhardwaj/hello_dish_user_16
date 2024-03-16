import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  bool status;
  Data data;

  HomeModel({
    required this.status,
    required this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  List<OfferArray> offerArray;
  List<Restaurant> ratingRestaurantArray;
  List<Restaurant> nearbyRestaurantArray;
  List<SubCategoryItem> subCategoryItems;

  Data({
    required this.offerArray,
    required this.ratingRestaurantArray,
    required this.nearbyRestaurantArray,
    required this.subCategoryItems,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        offerArray: List<OfferArray>.from(
            json["offerArray"].map((x) => OfferArray.fromJson(x))),
        ratingRestaurantArray: List<Restaurant>.from(
            json["ratingRestaurantArray"].map((x) => Restaurant.fromJson(x))),
        nearbyRestaurantArray: List<Restaurant>.from(
            json["nearbyRestaurantArray"].map((x) => Restaurant.fromJson(x))),
        subCategoryItems: List<SubCategoryItem>.from(
            json["subCategoryItems"].map((x) => SubCategoryItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "offerArray": List<dynamic>.from(offerArray.map((x) => x.toJson())),
        "ratingRestaurantArray":
            List<dynamic>.from(ratingRestaurantArray.map((x) => x.toJson())),
        "nearbyRestaurantArray":
            List<dynamic>.from(nearbyRestaurantArray.map((x) => x.toJson())),
        "subCategoryItems":
            List<dynamic>.from(subCategoryItems.map((x) => x.toJson())),
      };
}

class OfferArray {
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
  DateTime expiryDate;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  OfferArray({
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
    required this.expiryDate,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory OfferArray.fromJson(Map<String, dynamic> json) => OfferArray(
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
        expiryDate: DateTime.parse(json["expiryDate"]),
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
        "expiryDate": expiryDate.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Restaurant {
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
  dynamic otpCreatedAt;
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
  String? otp;
  String? profileImage;
  int isFav;

  Restaurant(
      {required this.id,
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
      this.otp,
      this.profileImage,
      required this.isFav});

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
      id: json["_id"],
      ownerName: json["ownerName"],
      restaurantName: json["restaurantName"],
      restaurantAddress: json["restaurantAddress"],
      restaurantLat: json["restaurantLat"].toDouble(),
      restaurantLong: json["restaurantLong"].toDouble(),
      email: json["email"],
      phone: json["phone"],
      password: json["password"],
      active: json["active"],
      otpCreatedAt: json["otpCreatedAt"],
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
      isFav: json["isFav"]);

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
        "otpCreatedAt": otpCreatedAt,
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
        "isFav": isFav
      };
}

class SubCategoryItem {
  SubCategory subCategory;
  List<Restaurant> restaurants;

  SubCategoryItem({
    required this.subCategory,
    required this.restaurants,
  });

  factory SubCategoryItem.fromJson(Map<String, dynamic> json) =>
      SubCategoryItem(
        subCategory: SubCategory.fromJson(json["subCategory"]),
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subCategory": subCategory.toJson(),
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class SubCategory {
  String id;
  String name;

  SubCategory({
    required this.id,
    required this.name,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
