import 'dart:convert';

import 'package:car_wash/dependency_injection/path.dart';
import 'package:car_wash/helper/extension/base_extension.dart';
import 'package:car_wash/presentation/screens/client/client_home/model/upcoming_service_model.dart';
import 'package:car_wash/presentation/screens/worker/worker_home/model/spam_model.dart';
import 'package:car_wash/service/api_service.dart';
import 'package:car_wash/service/api_url.dart';
import 'package:car_wash/service/check_api.dart';
import 'package:car_wash/service/socket_service.dart';
import 'package:car_wash/utils/app_const/app_const.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClientHomeController extends GetxController {
  var upComingLoading = Status.loading.obs;
  upComingLoadingMethod(Status status) => upComingLoading.value = status;
  Rx<TextEditingController> searchController = TextEditingController().obs;

  var currentServiceLoading = Status.loading.obs;
  currentServiceLoadingMethod(Status status) =>
      currentServiceLoading.value = status;

  List<String> tapbarItems = [
    AppStrings.upcomingDate.tr,
    AppStrings.current.tr,
    AppStrings.completed.tr,
  ];

  RxInt tappedIndex = 0.obs;

  ApiClient apiClient = serviceLocator();

  /// ====================== Req Service Upcoming =====================
  Rx<UpcomingModel> upcomingModel = UpcomingModel().obs;

  getUpComingService({BuildContext? context}) async {
    upComingLoadingMethod(Status.loading);
    var response = await apiClient.get(url: ApiUrl.upcomingService.addBaseUrl);

    if (response.statusCode == 200) {
      upcomingModel.value = UpcomingModel.fromJson(response.body["data"]);
      upComingLoadingMethod(Status.completed);
    } else {
      checkApi(response: response, context: context);
      if (response.statusCode == 503) {
        upComingLoadingMethod(Status.internetError);
      } else if (response.statusCode == 404) {
        upComingLoadingMethod(Status.noDataFound);
      } else {
        upComingLoadingMethod(Status.error);
      }
    }
  }

  /// ======================= Current Service Model =========================

  Rx<SpamModel> currentServiceModel = SpamModel().obs;
  Rx<LatLng> driverLocation = const LatLng(63.6847545, 63.6847545).obs;

  getCurrentServiceList({BuildContext? context}) async {
    currentServiceLoadingMethod(Status.loading);

    var response = await apiClient.get(
      url: ApiUrl.getSpamList.addBaseUrl,
    );

    if (response.statusCode == 200) {
      currentServiceModel.value = SpamModel.fromJson(response.body["data"]);

      driverLocation.value = LatLng(
          currentServiceModel.value.assignedWorker?.location?.coordinates?[1] ??
              63.6847545,
          currentServiceModel.value.assignedWorker?.location?.coordinates?[0] ??
              63.6847545);
      currentServiceLoadingMethod(Status.completed);
    } else {
      checkApi(response: response, context: context);
      if (response.statusCode == 503) {
        currentServiceLoadingMethod(Status.internetError);
      } else if (response.statusCode == 404) {
        currentServiceLoadingMethod(Status.noDataFound);
      } else {
        currentServiceLoadingMethod(Status.error);
      }
    }
  }

//// ========================= Listen to New Driver Location Update ===========================

  listenDriverLocation() {
    SocketApi.socket.on(
      "get-worker-location",
      (data) {
        debugPrint("Driver Location ---------->>>>>>>>>> $data");

        driverLocation.value = LatLng(data["location"]["coordinates"][1],
            data["location"]["coordinates"][0]);

        driverLocation.refresh();
      },
    );
  }

  @override
  void onInit() {
    listenDriverLocation();
    getUpComingService();
    getCurrentServiceList();
    super.onInit();
  }
}

class LocationModelClass {
  String type;
  List<double> coordinates;

  LocationModelClass({
    required this.type,
    required this.coordinates,
  });

  factory LocationModelClass.fromMap(Map<String, dynamic> map) {
    return LocationModelClass(
      type: map['type'] ?? 'Point',
      coordinates: List<double>.from(map['coordinates'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'coordinates': coordinates,
    };
  }
}
