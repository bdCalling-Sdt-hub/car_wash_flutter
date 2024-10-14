class UpcomingModel {
  int? count;
  List<Upcoming>? upcoming;

  UpcomingModel({
    this.count,
    this.upcoming,
  });

  factory UpcomingModel.fromJson(Map<String, dynamic> json) => UpcomingModel(
        count: json["count"],
        upcoming: json["upcoming"] == null
            ? []
            : List<Upcoming>.from(
                json["upcoming"]!.map((x) => Upcoming.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "upcoming": upcoming == null
            ? []
            : List<dynamic>.from(upcoming!.map((x) => x.toJson())),
      };
}

class Upcoming {
  JobLocation? jobLocation;
  String? id;
  String? clientName;
  String? clientId;
  String? clientPhoneNumber;
  int? currentServiceNumber;
  DateTime? bookedDateTime;
  String? address;
  String? status;
  String? carImageBefore;
  String? carImageAfter;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Upcoming({
    this.jobLocation,
    this.id,
    this.clientName,
    this.clientId,
    this.clientPhoneNumber,
    this.currentServiceNumber,
    this.bookedDateTime,
    this.address,
    this.status,
    this.carImageBefore,
    this.carImageAfter,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Upcoming.fromJson(Map<String, dynamic> json) => Upcoming(
        jobLocation: json["jobLocation"] == null
            ? null
            : JobLocation.fromJson(json["jobLocation"]),
        id: json["_id"],
        clientName: json["clientName"],
        clientId: json["clientId"],
        clientPhoneNumber: json["clientPhoneNumber"],
        currentServiceNumber: json["currentServiceNumber"],
        bookedDateTime: json["bookedDateTime"] == null
            ? null
            : DateTime.parse(json["bookedDateTime"]),
        address: json["address"],
        status: json["status"],
        carImageBefore: json["carImageBefore"],
        carImageAfter: json["carImageAfter"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "jobLocation": jobLocation?.toJson(),
        "_id": id,
        "clientName": clientName,
        "clientId": clientId,
        "clientPhoneNumber": clientPhoneNumber,
        "currentServiceNumber": currentServiceNumber,
        "bookedDateTime": bookedDateTime?.toIso8601String(),
        "address": address,
        "status": status,
        "carImageBefore": carImageBefore,
        "carImageAfter": carImageAfter,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class JobLocation {
  List<double>? coordinates;
  String? type;

  JobLocation({
    this.coordinates,
    this.type,
  });

  factory JobLocation.fromJson(Map<String, dynamic> json) => JobLocation(
        coordinates: json["coordinates"] == null
            ? []
            : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
        "type": type,
      };
}
