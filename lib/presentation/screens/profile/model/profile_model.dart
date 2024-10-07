class ProfileDataModel {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? role;
  String? profileImage;
  int? activationCode;
  DateTime? expirationTime;
  bool? isBlock;
  bool? isActive;
  bool? isSubscribed;
  bool? isFirstRequest;
  int? totalService;
  int? availableService;
  int? currentServiceNumber;
  String? currentPackageName;
  dynamic currentSubscription;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ProfileDataModel({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.role,
    this.profileImage,
    this.activationCode,
    this.expirationTime,
    this.isBlock,
    this.isActive,
    this.isSubscribed,
    this.isFirstRequest,
    this.totalService,
    this.availableService,
    this.currentServiceNumber,
    this.currentPackageName,
    this.currentSubscription,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) => ProfileDataModel(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        role: json["role"],
        profileImage: json["profile_image"],
        activationCode: json["activationCode"],
        expirationTime: json["expirationTime"] == null
            ? null
            : DateTime.parse(json["expirationTime"]),
        isBlock: json["is_block"],
        isActive: json["isActive"],
        isSubscribed: json["isSubscribed"],
        isFirstRequest: json["isFirstRequest"],
        totalService: json["totalService"],
        availableService: json["availableService"],
        currentServiceNumber: json["currentServiceNumber"],
        currentPackageName: json["currentPackageName"],
        currentSubscription: json["currentSubscription"],
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
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "role": role,
        "profile_image": profileImage,
        "activationCode": activationCode,
        "expirationTime": expirationTime?.toIso8601String(),
        "is_block": isBlock,
        "isActive": isActive,
        "isSubscribed": isSubscribed,
        "isFirstRequest": isFirstRequest,
        "totalService": totalService,
        "availableService": availableService,
        "currentServiceNumber": currentServiceNumber,
        "currentPackageName": currentPackageName,
        "currentSubscription": currentSubscription,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
