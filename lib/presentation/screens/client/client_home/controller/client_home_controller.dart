import 'package:car_wash/dependency_injection/path.dart';
import 'package:car_wash/helper/extension/base_extension.dart';
import 'package:car_wash/presentation/screens/client/client_home/model/upcoming_service_model.dart';
import 'package:car_wash/service/api_service.dart';
import 'package:car_wash/service/api_url.dart';
import 'package:car_wash/service/check_api.dart';
import 'package:car_wash/utils/app_const/app_const.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientHomeController extends GetxController {
  var upComingLoading = Status.loading.obs;
  upComingLoadingMethod(Status status) => upComingLoading.value = status;

  Rx<TextEditingController> searchController = TextEditingController().obs;

  List<String> tapbarItems = [
    AppStrings.upcomingDate,
    AppStrings.current,
    AppStrings.completed,
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

  @override
  void onInit() {
    getUpComingService();
    super.onInit();
  }
}
