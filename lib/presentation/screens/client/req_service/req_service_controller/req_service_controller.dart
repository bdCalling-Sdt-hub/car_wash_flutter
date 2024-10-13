import 'dart:async';

import 'package:car_wash/dependency_injection/path.dart';
import 'package:car_wash/helper/extension/base_extension.dart';
import 'package:car_wash/helper/tost_message/show_snackbar.dart';
import 'package:car_wash/presentation/screens/client/req_service/model/place_search_model.dart';
import 'package:car_wash/scret_key.dart';
import 'package:car_wash/service/api_service.dart';
import 'package:car_wash/service/api_url.dart';
import 'package:car_wash/service/check_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  Rx<LatLng> sourceLocation = const LatLng(23.7599042, 90.410031).obs;
  Rx<CameraPosition> cameraPosition =
      const CameraPosition(target: LatLng(23.7599042, 90.410031), zoom: 13).obs;

  final Rx<Completer<GoogleMapController>> mapController =
      Completer<GoogleMapController>().obs;

  Future<void> changeCameraPosition() async {
    try {
      debugPrint("Source Location -------------->>>>>> $sourceLocation");
      // Ensure that the map controller has been initialized

      final GoogleMapController controller = await mapController.value.future;

      // Update the camera position with the new target (sourceLocation)
      cameraPosition.value = CameraPosition(
        target: sourceLocation.value,
        zoom: 13,
      );

      // Animate the camera to the new position
      await controller.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition.value),
      );

      // Refresh the sourceLocation if needed
      sourceLocation.refresh();
    } catch (e) {
      // Catch and log any errors that occur during the camera animation
      debugPrint('Error changing camera position: $e');
    }
  }

  Rx<TextEditingController> dateController = TextEditingController().obs;
  Rx<TextEditingController> timeController = TextEditingController().obs;
  Rx<TextEditingController> descController = TextEditingController().obs;
  Rx<TextEditingController> locationController = TextEditingController().obs;

  RxBool isSearchFocused = false.obs;

  //// =================== Send Service Request =====================
  sendServiceRequest({required BuildContext context}) async {
    var body = {
      "bookedDate": dateController.value.text,
      "bookedTime": timeController.value.text,
      "longitude": sourceLocation.value.longitude,
      "latitude": sourceLocation.value.latitude,
      "jobDescription": descController.value.text,
      "address": locationController.value.text
    };
    var response = await apiClient.post(
        body: body, url: ApiUrl.createJob.addBaseUrl, context: context);

    if (response.statusCode == 200) {
      showSnackBar(
          // ignore: use_build_context_synchronously
          context: context,
          content: response.body["message"],
          backgroundColor: Colors.green);
    } else {
      // ignore: use_build_context_synchronously
      checkApi(response: response, context: context);
    }
  }

  @override
  void dispose() {
    mapController.value = Completer();
    super.dispose();
  }
}
