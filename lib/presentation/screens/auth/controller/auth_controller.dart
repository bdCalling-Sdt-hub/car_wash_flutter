import 'package:car_wash/helper/extension/base_extension.dart';
import 'package:car_wash/service/api_service.dart';
import 'package:car_wash/service/api_url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passController = TextEditingController().obs;
  Rx<TextEditingController> confirmController = TextEditingController().obs;

  Rx<TextEditingController> otpController = TextEditingController().obs;

  Rx<bool> rememberMe = false.obs;
  Rx<bool> isAgree = false.obs;
  Rx<bool> isClient = true.obs;

  ApiClient apiClient = ApiClient();

  ///============================ Sign Up =========================
  signIn() async {
    var response = await apiClient.post(
        url: isClient.value
            ? ApiUrl.signUpClient.addBaseUrl
            : ApiUrl.signUpWorker);
  }
}
