import 'package:car_wash/dependency_injection/path.dart';
import 'package:car_wash/presentation/screens/profile/model/profile_model.dart';
import 'package:car_wash/service/api_service.dart';
import 'package:car_wash/service/api_url.dart';
import 'package:car_wash/service/check_api.dart';
import 'package:car_wash/utils/app_const/app_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  Rx<TextEditingController> nameController =
      TextEditingController(text: "Fatima Jannat").obs;
  Rx<TextEditingController> emailController =
      TextEditingController(text: "fatima@gmail.com").obs;
  Rx<TextEditingController> phoneController =
      TextEditingController(text: "+880232480457").obs;
  Rx<TextEditingController> locationController =
      TextEditingController(text: "Saudi Arab").obs;
  ApiClient apiClient = serviceLocator();

  /// ========================= Get Profile Information ==========================
  final profileLoading = Status.loading.obs;
  void profileLoadingMethod(Status value) => profileLoading.value = value;
  Rx<ProfileDataModel> profileModel = ProfileDataModel().obs;

  getProfile({required BuildContext context}) async {
    var response = await apiClient.get(url: ApiUrl.baseUrl, context: context);

    if (response.statusCode == 200) {
      profileModel.value = ProfileDataModel.fromJson(response.body);
      profileLoadingMethod(Status.completed);
    } else {
      // ignore: use_build_context_synchronously
      checkApi(response: response, context: context);
    }
  }
}
