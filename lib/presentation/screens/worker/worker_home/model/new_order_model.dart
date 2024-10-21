class NewOrderModel {
  JobLocation? jobLocation;
  String? id;
  DateTime? bookedDateTime;
  String? address;
  String? clientPhoneNumber;

  NewOrderModel(
      {this.jobLocation,
      this.id,
      this.bookedDateTime,
      this.address,
      this.clientPhoneNumber});

  factory NewOrderModel.fromJson(Map<String, dynamic> json) => NewOrderModel(
        jobLocation: json["jobLocation"] == null
            ? null
            : JobLocation.fromJson(json["jobLocation"]),
        id: json["_id"],
        bookedDateTime: json["bookedDateTime"] == null
            ? null
            : DateTime.parse(json["bookedDateTime"]),
        address: json["address"],
        clientPhoneNumber: json["clientPhoneNumber"],
      );
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
