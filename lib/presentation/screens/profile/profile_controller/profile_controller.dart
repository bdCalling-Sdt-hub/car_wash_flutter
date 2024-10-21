import 'dart:io';

import 'package:car_wash/dependency_injection/path.dart';
import 'package:car_wash/helper/extension/base_extension.dart';
import 'package:car_wash/helper/local_db/local_db.dart';
import 'package:car_wash/helper/tost_message/show_snackbar.dart';
import 'package:car_wash/presentation/screens/profile/model/profile_model.dart';
import 'package:car_wash/service/api_service.dart';
import 'package:car_wash/service/api_url.dart';
import 'package:car_wash/service/check_api.dart';
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:car_wash/utils/app_const/app_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> dOBController = TextEditingController().obs;
  RxString imagePath = "".obs;

  // Rx<TextEditingController> locationController =
  //     TextEditingController(text: "Saudi Arab").obs;
  RxBool isUpdateProfile = true.obs;
  RxBool updateProfileLoading = false.obs;
  ApiClient apiClient = serviceLocator();
  final DBHelper _dbHelper = serviceLocator();

  /// ========================= Get Profile Information ==========================

  final profileLoading = Status.loading.obs;
  void profileLoadingMethod(Status value) => profileLoading.value = value;
  Rx<ProfileDataModel> profileModel = ProfileDataModel().obs;

  getProfile({BuildContext? context}) async {
    String role = await _dbHelper.getUserRole();
    var response = await apiClient.get(
        url: role == "CLIENT"
            ? ApiUrl.clientProfile.addBaseUrl
            : ApiUrl.workerProfile.addBaseUrl,
        context: context);

    if (response.statusCode == 200) {
      profileModel.value = ProfileDataModel.fromJson(response.body["data"]);
      profileLoadingMethod(Status.completed);

      saveInfoOnTextField(profileModel: profileModel.value);
    } else {
      checkApi(response: response, context: context);
      if (response.statusCode == 503) {
        profileLoadingMethod(Status.internetError);
      } else if (response.statusCode == 404) {
        profileLoadingMethod(Status.noDataFound);
      } else {
        profileLoadingMethod(Status.error);
      }
    }
  }

  /// ======================= Save Info on Textediting Field ======================

  void saveInfoOnTextField({required ProfileDataModel profileModel}) {
    nameController = TextEditingController(text: profileModel.name ?? "").obs;
    emailController = TextEditingController(text: profileModel.email ?? "").obs;
    phoneController =
        TextEditingController(text: profileModel.phoneNumber ?? "").obs;

    addressController =
        TextEditingController(text: profileModel.address ?? "").obs;
    dOBController =
        TextEditingController(text: profileModel.dateOfBirth ?? "").obs;
  }

  /// ============================ Update Profile ===============================

  updateProfile({required BuildContext context}) async {
    String role = await _dbHelper.getUserRole();
    updateProfileLoading.value = true;

    var body = {
      "name": nameController.value.text,
      "phone_number": phoneController.value.text,
      "date_of_birth": dOBController.value.text,
      "address": addressController.value.text,
    };

    var response = imagePath.isEmpty
        ? await apiClient.patch(
            body: body,
            url: role == "CLIENT"
                ? ApiUrl.clientUpdateProfile.addBaseUrl
                : ApiUrl.workerUpdateProfile.addBaseUrl)
        : await apiClient.multipartRequest(
            multipartBody: [
                MultipartBody("profile_image", File(imagePath.value))
              ],
            url: role == "CLIENT"
                ? ApiUrl.clientUpdateProfile.addBaseUrl
                : ApiUrl.workerUpdateProfile.addBaseUrl,
            reqType: "PATCH");

    if (response.statusCode == 200) {
      getProfile();
      showSnackBar(
          context: context,
          content: response.body["message"],
          backgroundColor: AppColors.greenColor);
    } else {
      checkApi(response: response, context: context);
    }

    updateProfileLoading.value = false;
  }

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }
}
