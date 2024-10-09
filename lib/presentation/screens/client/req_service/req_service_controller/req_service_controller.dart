import 'package:car_wash/dependency_injection/path.dart';
import 'package:car_wash/presentation/screens/client/req_service/model/place_search_model.dart';
import 'package:car_wash/scret_key.dart';
import 'package:car_wash/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReqServiceController extends GetxController {
  ApiClient apiClient = serviceLocator();

  RxList<PlaceDetailsModel> places = <PlaceDetailsModel>[].obs;
  Future<List<PlaceDetailsModel>> fetchPlaceDetails(
      {required String searchQuery}) async {
    // First API call: Place Autocomplete API
    var autocompleteResponse =
        await apiClient.get(url: GOOGLE_MAP_SEARCH(searchQuery: searchQuery));

    if (autocompleteResponse.statusCode == 200) {
      if (autocompleteResponse.body['status'] == 'OK') {
        // Loop through the predictions and get place_id for each
        for (var result in autocompleteResponse.body['predictions']) {
          String placeId = result['place_id'];
          String description = result['description'];

          // Second API call: Place Details API using place_id to get lat/lng
          var placeDetails = await getPlaceDetails(placeId);

          if (placeDetails != null) {
            // Create and add the combined model
            places.add(
              PlaceDetailsModel(
                description: description,
                placeId: placeId,
                lat: placeDetails['lat'] ?? 0.0,
                lng: placeDetails['lng'] ?? 0.0,
              ),
            );
          }
        }
      } else {
        throw Exception('Failed to load places');
      }
    } else {
      throw Exception('Failed to load autocomplete results');
    }

    return places;
  }

  Future<Map<String, double>?> getPlaceDetails(String placeId) async {
    var url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$GOOGLE_MAP_KEY";

    var detailsResponse = await apiClient.get(url: url);

    if (detailsResponse.statusCode == 200) {
      if (detailsResponse.body['status'] == 'OK') {
        var location = detailsResponse.body['result']['geometry']['location'];
        double lat = location['lat'];
        double lng = location['lng'];

        return {
          'lat': lat,
          'lng': lng,
        };
      } else {
        throw Exception('Failed to load place details');
      }
    } else {
      throw Exception('Failed to load place details');
    }
  }

  Rx<TextEditingController> dateController = TextEditingController().obs;
  Rx<TextEditingController> timeController = TextEditingController().obs;
  Rx<TextEditingController> descController = TextEditingController().obs;
  Rx<TextEditingController> locationController = TextEditingController().obs;

  RxBool isSearchFocused = false.obs;
  RxBool isMapFocused = false.obs;
}
