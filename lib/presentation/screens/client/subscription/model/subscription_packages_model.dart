class SubscriptionPackagesModel {
  String? id;
  String? packageTitle;
  String? packageDescription;
  int? numberOfService;
  List<Service>? services;

  SubscriptionPackagesModel({
    this.id,
    this.packageTitle,
    this.packageDescription,
    this.numberOfService,
    this.services,
  });

  factory SubscriptionPackagesModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionPackagesModel(
        id: json["_id"],
        packageTitle: json["packageTitle"],
        packageDescription: json["packageDescription"],
        numberOfService: json["numberOfService"],
        services: json["services"] == null
            ? []
            : List<Service>.from(
                json["services"]!.map((x) => Service.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "packageTitle": packageTitle,
        "packageDescription": packageDescription,
        "numberOfService": numberOfService,
        "services": services == null
            ? []
            : List<dynamic>.from(services!.map((x) => x.toJson())),
      };
}

class Service {
  String? serviceName;
  int? price;
  bool? isCouponApplied;
  dynamic percentage;
  String? id;

  Service({
    this.serviceName,
    this.price,
    this.isCouponApplied,
    this.percentage,
    this.id,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
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
