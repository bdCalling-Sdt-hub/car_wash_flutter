import 'dart:io';

import 'package:car_wash/dependency_injection/path.dart';
import 'package:car_wash/global/general_controller/general_controller.dart';
import 'package:car_wash/helper/extension/base_extension.dart';
import 'package:car_wash/helper/tost_message/show_snackbar.dart';
import 'package:car_wash/presentation/screens/worker/worker_home/model/new_order_model.dart';
import 'package:car_wash/presentation/screens/worker/worker_home/model/spam_model.dart';
import 'package:car_wash/service/api_service.dart';
import 'package:car_wash/service/api_url.dart';
import 'package:car_wash/service/check_api.dart';
import 'package:car_wash/utils/app_const/app_const.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class WorkerHomeController extends GetxController {
  Rx<TextEditingController> searchController = TextEditingController().obs;
  Rx<PageController> pagecontroller = PageController().obs;

  var newOrderLoading = Status.loading.obs;
  newOrderLoadingMethod(Status status) => newOrderLoading.value = status;

  var spamLoading = Status.loading.obs;
  spamLoadingMethod(Status status) => spamLoading.value = status;

  ApiClient apiClient = serviceLocator();
  GeneralController generalController = Get.find<GeneralController>();

  List<String> tapbarItems = [
    AppStrings.newOrder.tr,
    AppStrings.spam.tr,
    AppStrings.history.tr,
  ];

  RxInt tappedIndex = 0.obs;

  /// ===================== Get new Order List =======================

  RxList<NewOrderModel> newOrderList = <NewOrderModel>[].obs;
  getNewOrder({BuildContext? context}) async {
    newOrderLoadingMethod(Status.loading);

    var response = await apiClient.get(
        url: ApiUrl.workerNewOrder.addBaseUrl, showResult: false);

    if (response.statusCode == 200) {
      newOrderList.value = List<NewOrderModel>.from(response.body["data"]
              ["orders"]!
          .map((x) => NewOrderModel.fromJson(x)));
      newOrderLoadingMethod(Status.completed);
    } else {
      checkApi(response: response, context: context);
      if (response.statusCode == 503) {
        newOrderLoadingMethod(Status.internetError);
      } else if (response.statusCode == 404) {
        newOrderLoadingMethod(Status.noDataFound);
      } else {
        newOrderLoadingMethod(Status.error);
      }
    }
  }

  /// ======================= Spam List =========================

  Rx<SpamModel> spamModel = SpamModel().obs;

  getSpamList({BuildContext? context}) async {
    spamLoadingMethod(Status.loading);

    var response = await apiClient.get(
        url: ApiUrl.getSpamList.addBaseUrl, showResult: true);

    if (response.statusCode == 200) {
      spamModel.value = SpamModel.fromJson(response.body["data"]);
      spamLoadingMethod(Status.completed);
    } else {
      checkApi(response: response, context: context);
      if (response.statusCode == 503) {
        spamLoadingMethod(Status.internetError);
      } else if (response.statusCode == 404) {
        spamLoadingMethod(Status.noDataFound);
      } else {
        spamLoadingMethod(Status.error);
      }
    }
  }

  /// ============================ Work Start =============================

  startWork({required BuildContext context, required String jobId}) async {
    generalController.showPopUpLoader(context: context);

    var body = {
      "jobId": jobId,
      "startDateTime": DateFormat('d MMM yyyy hh:mm a').format(
          DateTime.now()), // current dateTime after worker clicked start
      "status": "STARTED"
    };

    var response =
        await apiClient.patch(body: body, url: ApiUrl.startWork.addBaseUrl);

    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      getSpamList();
      showSnackBar(
          context: context,
          content: response.body["message"],
          backgroundColor: Colors.green);
    } else {
      Navigator.of(context).pop();
      checkApi(response: response, context: context);
    }
  }

  /// ============================ Work Accept =============================

  acceptWork({required BuildContext context, required String jobId}) async {
    generalController.showPopUpLoader(context: context);

    var body = {"jobId": jobId, "status": "ACCEPTED"};

    var response =
        await apiClient.patch(body: body, url: ApiUrl.acceptWork.addBaseUrl);

    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      getNewOrder();
      getSpamList();
      showSnackBar(
          context: context,
          content: response.body["message"],
          backgroundColor: Colors.green);
    } else {
      Navigator.of(context).pop();
      checkApi(response: response, context: context);
    }
  }

  /// ============================ Work End =============================

  RxBool isworkEnd = false.obs;
  RxString beforeCleaningImgPath = "".obs;
  RxString afterCleaningImgPath = "".obs;
  RxString endTime = ".....".obs;

  endWork({
    required String jobId,
    required BuildContext context,
  }) async {
    isworkEnd.value = true;

    var body = {
      "jobId": jobId,
      "endDateTime": DateFormat('d MMM yyyy hh:mm a').format(DateTime.now()),
      "status": "ENDED",
    };

    var response = await apiClient.multipartRequest(
        body: body,
        url: ApiUrl.endWork.addBaseUrl,
        reqType: "PATCH",
        multipartBody: [
          MultipartBody("before", File(beforeCleaningImgPath.value)),
          MultipartBody("after", File(afterCleaningImgPath.value)),
        ]);

    if (response.statusCode == 200) {
      generalController.jobHistory();
      getSpamList();
      showSnackBar(
          context: context,
          content: response.body["message"],
          backgroundColor: Colors.green);
    } else {
      getSpamList(context: context);
      checkApi(response: response, context: context);
    }

    isworkEnd.value = false;
  }

  @override
  void onInit() {
    getNewOrder();
    getSpamList();
    super.onInit();
  }
}
