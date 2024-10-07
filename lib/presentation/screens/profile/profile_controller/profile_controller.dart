import 'package:car_wash/dependency_injection/path.dart';
import 'package:car_wash/helper/extension/base_extension.dart';
import 'package:car_wash/presentation/screens/profile/model/profile_model.dart';
import 'package:car_wash/service/api_service.dart';
import 'package:car_wash/service/api_url.dart';
import 'package:car_wash/service/check_api.dart';
import 'package:car_wash/utils/app_const/app_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> dOBController = TextEditingController().obs;

  // Rx<TextEditingController> locationController =
  //     TextEditingController(text: "Saudi Arab").obs;
  RxBool updateProfile = true.obs;
  ApiClient apiClient = serviceLocator();

  /// ========================= Get Profile Information ==========================

  /// TODO Get Profile Needs to be Dynamic

  final profileLoading = Status.loading.obs;
  void profileLoadingMethod(Status value) => profileLoading.value = value;
  Rx<ProfileDataModel> profileModel = ProfileDataModel().obs;

  getProfile({BuildContext? context}) async {
    var response = await apiClient.get(
        url: ApiUrl.clientProfile.addBaseUrl, context: context);

    if (response.statusCode == 200) {
      profileModel.value = ProfileDataModel.fromJson(response.body["data"]);
      profileLoadingMethod(Status.completed);

      saveInfoOnTextField(profileModel: profileModel.value);
    } else {
      if (response.statusCode == 503) {
        profileLoadingMethod(Status.internetError);
      } else {
        profileLoadingMethod(Status.error);
      }
      // ignore: use_build_context_synchronously
      checkApi(response: response, context: context);
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

  /// TODO Update Profile Not Done
  @override
  void onInit() {
    getProfile();
    super.onInit();
  }
}
