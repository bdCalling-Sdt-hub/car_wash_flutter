class ProfileDataModel {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? role;
  String? profileImage;
  String? address;
  String? dateOfBirth;

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

  ProfileDataModel(
      {this.id,
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
      this.address,
      this.dateOfBirth});

  factory ProfileDataModel.fromJson(Map<String, dynamic> json) =>
      ProfileDataModel(
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
        address: json["address"].isEmpty ? null : json["address"].isEmpty,
        dateOfBirth: json["date_of_birth"],
      );
}
