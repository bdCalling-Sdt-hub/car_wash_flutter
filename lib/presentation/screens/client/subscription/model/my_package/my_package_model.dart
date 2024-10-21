// To parse this JSON data, do
//
//     final myPackageModel = myPackageModelFromJson(jsonString);

import 'dart:convert';

MyPackageModel myPackageModelFromJson(String str) =>
    MyPackageModel.fromJson(json.decode(str));

String myPackageModelToJson(MyPackageModel data) => json.encode(data.toJson());

class MyPackageModel {
  int? statusCode;
  bool? success;
  String? message;
  Data? data;

  MyPackageModel({
    this.statusCode,
    this.success,
    this.message,
    this.data,
  });

  factory MyPackageModel.fromJson(Map<String, dynamic> json) => MyPackageModel(
        statusCode: json["statusCode"],
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  MyServices? service;
  Subscription? subscription;
  Package? package;

  Data({
    this.service,
    this.subscription,
    this.package,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        service: json["service"] == null
            ? null
            : MyServices.fromJson(json["service"]),
        subscription: json["subscription"] == null
            ? null
            : Subscription.fromJson(json["subscription"]),
        package:
            json["package"] == null ? null : Package.fromJson(json["package"]),
      );

  Map<String, dynamic> toJson() => {
        "service": service?.toJson(),
        "subscription": subscription?.toJson(),
        "package": package?.toJson(),
      };
}

class Package {
  String? id;
  String? packageTitle;
  String? packageDescription;
  int? numberOfService;
  List<MyServices>? services;
  int? v;

  Package({
    this.id,
    this.packageTitle,
    this.packageDescription,
    this.numberOfService,
    this.services,
    this.v,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        id: json["_id"],
        packageTitle: json["packageTitle"],
        packageDescription: json["packageDescription"],
        numberOfService: json["numberOfService"],
        services: json["services"] == null
            ? []
            : List<MyServices>.from(
                json["services"]!.map((x) => MyServices.fromJson(x))),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "packageTitle": packageTitle,
        "packageDescription": packageDescription,
        "numberOfService": numberOfService,
        "services": services == null
            ? []
            : List<dynamic>.from(services!.map((x) => x.toJson())),
        "__v": v,
      };
}

class MyServices {
  String? serviceName;
  int? price;
  bool? isCouponApplied;
  dynamic percentage;
  String? id;

  MyServices({
    this.serviceName,
    this.price,
    this.isCouponApplied,
    this.percentage,
    this.id,
  });

  factory MyServices.fromJson(Map<String, dynamic> json) => MyServices(
        serviceName: json["serviceName"],
        price: json["price"],
        isCouponApplied: json["isCouponApplied"],
        percentage: json["percentage"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "serviceName": serviceName,
        "price": price,
        "isCouponApplied": isCouponApplied,
        "percentage": percentage,
        "_id": id,
      };
}

class Subscription {
  String? id;
  String? clientId;
  String? packageId;
  String? serviceId;
  int? price;
  bool? coupon;
  int? totalService;
  int? availableService;
  bool? isUsed;
  bool? isExpired;
  String? transactionId;
  DateTime? expiryTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Subscription({
    this.id,
    this.clientId,
    this.packageId,
    this.serviceId,
    this.price,
    this.coupon,
    this.totalService,
    this.availableService,
    this.isUsed,
    this.isExpired,
    this.transactionId,
    this.expiryTime,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json["_id"],
        clientId: json["clientId"],
        packageId: json["packageId"],
        serviceId: json["serviceId"],
        price: json["price"],
        coupon: json["coupon"],
        totalService: json["totalService"],
        availableService: json["availableService"],
        isUsed: json["isUsed"],
        isExpired: json["isExpired"],
        transactionId: json["transactionId"],
        expiryTime: json["expiryTime"] == null
            ? null
            : DateTime.parse(json["expiryTime"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "clientId": clientId,
        "packageId": packageId,
        "serviceId": serviceId,
        "price": price,
        "coupon": coupon,
        "totalService": totalService,
        "availableService": availableService,
        "isUsed": isUsed,
        "isExpired": isExpired,
        "transactionId": transactionId,
        "expiryTime": expiryTime?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
