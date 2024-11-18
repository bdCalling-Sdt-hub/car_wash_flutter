import 'dart:io';

import 'package:car_wash/core/custom_assets/assets.gen.dart';
import 'package:car_wash/dependency_injection/path.dart';
import 'package:car_wash/global/model/job_history_model.dart';
import 'package:car_wash/global/model/notification_model.dart';
import 'package:car_wash/helper/extension/base_extension.dart';
import 'package:car_wash/service/api_service.dart';
import 'package:car_wash/service/api_url.dart';
import 'package:car_wash/service/check_api.dart';
import 'package:car_wash/utils/app_const/app_const.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class GeneralController extends GetxController {
  RxBool isEnglish = true.obs;

  List<String> languages = [
    AppStrings.english,
    AppStrings.arabic,
  ];

  /// ========================= Picked Date =======================

  RxString pickedDate = "".obs;

  Future<String> pickDate(BuildContext context) async {
    // Show Date Picker
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      // Format the date to "25 Aug 2024"
      String formattedDate = DateFormat('d MMM y').format(date);

      // debugPrint("Picked Date ----->>>>>> $pickedDate");
      return pickedDate.value = formattedDate;
    }

    return "";
  }

  RxString pickedTime = "".obs;

  /// ========================= Picked Tine =======================

  Future<String> pickTime(BuildContext context) async {
    // Show Time Picker
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      // Convert to 12-hour format
      final hours = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
      final minutes = time.minute.toString().padLeft(2, '0');
      final period = time.period == DayPeriod.am ? "AM" : "PM";

      String formattedTime = "$hours:$minutes $period";

      // Update the observable variable with the formatted time
      return pickedTime.value = formattedTime;
    }

    // Return an empty string if no time is selected
    return "";
  }

  /// =========================== Pop Up Loader ===========================
  showPopUpLoader({required BuildContext context}) {
    return showDialog(
        barrierDismissible: true,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          return SizedBox(
            height: 70,
            child: AlertDialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              content: Assets.lottie.screenLoadingAni.lottie(
                height: 100,
                width: 100,
                fit: BoxFit.contain,
              ),
            ),
          );
        });
  }

  ///============================= Pick Image ===============================

  Rx<File> imageFile = File("").obs;
  RxString imagePath = "".obs;
  Future<String> selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
    refresh();
    if (getImages != null) {
      imageFile.value = File(getImages.path);
      imagePath.value = getImages.path;

      return imagePath.value;
    }

    return "";
  }

  /// ============================= Job History =====================================
  var historyLoading = Status.loading.obs;
  historyLoadingMethod(Status status) => historyLoading.value = status;
  ApiClient apiClient = serviceLocator();

  RxList<JobHistoryModel> jobList = <JobHistoryModel>[].obs;
  jobHistory({BuildContext? context}) async {
    historyLoadingMethod(Status.loading);

    var response = await apiClient.get(
      url: ApiUrl.jobHistory.addBaseUrl,
    );

    if (response.statusCode == 200) {
      jobList.value = List<JobHistoryModel>.from(response.body["data"]
              ["history"]
          .map((x) => JobHistoryModel.fromJson(x)));
      historyLoadingMethod(Status.completed);
    } else {
      checkApi(response: response, context: context);
      if (response.statusCode == 503) {
        historyLoadingMethod(Status.internetError);
      } else if (response.statusCode == 404) {
        historyLoadingMethod(Status.noDataFound);
      } else {
        historyLoadingMethod(Status.error);
      }
    }
  }

  /// ============================ Notification ===========================
  var notificationLoading = Status.loading.obs;
  notificationLoadingMethod(Status status) =>
      notificationLoading.value = status;

  RxList<NotificationModel> notificationList = <NotificationModel>[].obs;

  getNotification({BuildContext? context}) async {
    notificationLoadingMethod(Status.loading);

    var response = await apiClient.get(
      url: ApiUrl.notification.addBaseUrl,
    );

    if (response.statusCode == 200) {
      notificationList.value = List<NotificationModel>.from(response
          .body["data"]["result"]
          .map((x) => NotificationModel.fromJson(x)));
      notificationLoadingMethod(Status.completed);
    } else {
      checkApi(response: response, context: context);
      if (response.statusCode == 503) {
        notificationLoadingMethod(Status.internetError);
      } else if (response.statusCode == 404) {
        notificationLoadingMethod(Status.noDataFound);
      } else {
        notificationLoadingMethod(Status.error);
      }
    }
  }

  /// ============================ Real all Notification ===========================
  readAllNotification({required BuildContext context}) async {
    showPopUpLoader(context: context);

    var response = await apiClient.patch(
        body: {}, url: ApiUrl.readNotification.addBaseUrl, showResult: true);

    if (response.statusCode == 200) {
      Navigator.of(context).pop();
      getNotification();
    } else {
      Navigator.of(context).pop();
      checkApi(response: response);
    }
  }

  /// ======================== Privacy Policy =====================
  var privacyLoading = Status.loading.obs;
  privacyLoadingMethod(Status status) => privacyLoading.value = status;

  RxString privacy = "".obs;
  getPrivacy({BuildContext? context}) async {
    privacyLoadingMethod(Status.loading);

    var response = await apiClient.get(
      url: ApiUrl.getPrivacy.addBaseUrl,
    );

    if (response.statusCode == 200) {
      privacy.value = response.body["data"]["description"];
      privacyLoadingMethod(Status.completed);
    } else {
      checkApi(response: response, context: context);
      if (response.statusCode == 503) {
        privacyLoadingMethod(Status.internetError);
      } else if (response.statusCode == 404) {
        privacyLoadingMethod(Status.noDataFound);
      } else {
        privacyLoadingMethod(Status.error);
      }
    }
  }

  /// ================================= Terms of Use ================================

  var termsLoading = Status.loading.obs;
  termsLoadingMethod(Status status) => termsLoading.value = status;

  RxString terms = "".obs;
  getTerms({BuildContext? context}) async {
    termsLoadingMethod(Status.loading);

    var response = await apiClient.get(
      url: ApiUrl.getPrivacy.addBaseUrl,
    );

    if (response.statusCode == 200) {
      terms.value = response.body["data"]["description"];
      termsLoadingMethod(Status.completed);
    } else {
      checkApi(response: response, context: context);
      if (response.statusCode == 503) {
        termsLoadingMethod(Status.internetError);
      } else if (response.statusCode == 404) {
        termsLoadingMethod(Status.noDataFound);
      } else {
        termsLoadingMethod(Status.error);
      }
    }
  }

  @override
  void onInit() {
    getTerms();
    getPrivacy();
    getNotification();
    jobHistory();
    super.onInit();
  }
}
