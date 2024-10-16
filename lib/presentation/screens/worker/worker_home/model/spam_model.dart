class SpamModel {
  Location? jobLocation;
  bool? isPaid;
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
  AssignedWorker? assignedWorker;
  DateTime? startDateTime;

  SpamModel({
    this.jobLocation,
    this.isPaid,
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
    this.assignedWorker,
    this.startDateTime,
  });

  factory SpamModel.fromJson(Map<String, dynamic> json) => SpamModel(
        jobLocation: json["jobLocation"] == null
            ? null
            : Location.fromJson(json["jobLocation"]),
        isPaid: json["isPaid"],
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
        assignedWorker: json["assignedWorker"] == null
            ? null
            : AssignedWorker.fromJson(json["assignedWorker"]),
        startDateTime: json["startDateTime"] == null
            ? null
            : DateTime.parse(json["startDateTime"]),
      );

  Map<String, dynamic> toJson() => {
        "jobLocation": jobLocation?.toJson(),
        "isPaid": isPaid,
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
        "assignedWorker": assignedWorker?.toJson(),
        "startDateTime": startDateTime?.toIso8601String(),
      };
}

class AssignedWorker {
  Location? location;
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? role;
  String? profileImage;
  String? dateOfBirth;
  int? activationCode;
  DateTime? expirationTime;
  bool? isBlock;
  bool? isActive;
  int? amount;
  String? address;
  int? totalCompletedService;
  List<dynamic>? allCompletedService;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  AssignedWorker({
    this.location,
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.role,
    this.profileImage,
    this.dateOfBirth,
    this.activationCode,
    this.expirationTime,
    this.isBlock,
    this.isActive,
    this.amount,
    this.address,
    this.totalCompletedService,
    this.allCompletedService,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory AssignedWorker.fromJson(Map<String, dynamic> json) => AssignedWorker(
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        role: json["role"],
        profileImage: json["profile_image"],
        dateOfBirth: json["date_of_birth"],
        activationCode: json["activationCode"],
        expirationTime: json["expirationTime"] == null
            ? null
            : DateTime.parse(json["expirationTime"]),
        isBlock: json["is_block"],
        isActive: json["isActive"],
        amount: json["amount"],
        address: json["address"],
        totalCompletedService: json["totalCompletedService"],
        allCompletedService: json["allCompletedService"] == null
            ? []
            : List<dynamic>.from(json["allCompletedService"]!.map((x) => x)),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
        "_id": id,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "role": role,
        "profile_image": profileImage,
        "date_of_birth": dateOfBirth,
        "activationCode": activationCode,
        "expirationTime": expirationTime?.toIso8601String(),
        "is_block": isBlock,
        "isActive": isActive,
        "amount": amount,
        "address": address,
        "totalCompletedService": totalCompletedService,
        "allCompletedService": allCompletedService == null
            ? []
            : List<dynamic>.from(allCompletedService!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates: json["coordinates"] == null
            ? []
            : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
      };
}
