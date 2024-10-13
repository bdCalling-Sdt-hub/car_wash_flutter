// class PlaceSearchModel {
//   final String description;
//   final String placeId;

//   PlaceSearchModel({required this.description, required this.placeId});

//   factory PlaceSearchModel.fromJson(Map<String, dynamic> json) {
//     return PlaceSearchModel(
//       description: json['description'],
//       placeId: json['place_id'],
//     );
//   }
// }

class PlaceDetailsModel {
  String? description;
  String? placeId;
  final double lat;
  final double lng;

  PlaceDetailsModel({
    required this.description,
    required this.placeId,
    required this.lat,
    required this.lng,
  });

  factory PlaceDetailsModel.fromJson(
      Map<String, dynamic> json, double lat, double lng) {
    return PlaceDetailsModel(
      description: json['description'],
      placeId: json['place_id'],
      lat: lat,
      lng: lng,
    );
  }
}
