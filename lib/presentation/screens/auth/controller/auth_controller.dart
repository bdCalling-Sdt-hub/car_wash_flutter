import 'dart:async';

import 'package:car_wash/core/routes/route_path.dart';
import 'package:car_wash/core/routes/routes.dart';
import 'package:car_wash/dependency_injection/path.dart';
import 'package:car_wash/helper/extension/base_extension.dart';
import 'package:car_wash/helper/local_db/local_db.dart';
import 'package:car_wash/helper/tost_message/show_snackbar.dart';
import 'package:car_wash/service/api_service.dart';
import 'package:car_wash/service/api_url.dart';
import 'package:car_wash/service/check_api.dart';
import 'package:car_wash/utils/app_const/app_const.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  Rx<TextEditingController> nameController =
      TextEditingController(text: kDebugMode ? "Rafsan Hossain" : "").obs;

  Rx<TextEditingController> phoneController =
      TextEditingController(text: kDebugMode ? "123456789" : "").obs;

  Rx<TextEditingController> emailController =
      TextEditingController(text: kDebugMode ? "mdh95831@gmail.com" : "").obs;
  Rx<TextEditingController> passController =
      TextEditingController(text: kDebugMode ? "1234567Rr" : "").obs;
  Rx<TextEditingController> confirmController =
      TextEditingController(text: kDebugMode ? "1234567Rr" : "").obs;

  Rx<TextEditingController> otpController = TextEditingController().obs;

  Rx<bool> rememberMe = false.obs;
  Rx<bool> isAgree = false.obs;
  Rx<bool> isClient = true.obs;

  ApiClient apiClient = serviceLocator();
  DBHelper dbHelper = serviceLocator();

  /// =================== Save Info ===================

  saveInformation({required Response<dynamic> response}) {
    dbHelper.storeTokenUserdata(
        token: response.body["data"]["accessToken"],
        role: response.body["data"]["role"]);
  }

  ///============================ Sign In =========================
  RxBool signInLoading = false.obs;

  signIn({required BuildContext context}) async {
    signInLoading.value = true;

    var body = {
      "email": emailController.value.text,
      "password": passController.value.text
    };
    var response = await apiClient.post(
        context: context,
        body: body,
        isBasic: true,
        url: isClient.value
            ? ApiUrl.signInClient.addBaseUrl
            : ApiUrl.signInWorker.addBaseUrl);

    // // Ensure the widget is still mounted before using BuildContext
    // if (!context.mounted) return;

    if (response.statusCode == 200) {
      saveInformation(response: response);
      if (response.body["data"]["role"] == AppStrings.roleCLIENT) {
        AppRouter.route.replaceNamed(RoutePath.clientHome);
      } else {
        AppRouter.route.replaceNamed(RoutePath.workerHome);
      }
    } else {
      // ignore: use_build_context_synchronously
      checkApi(response: response, context: context);
    }

    signInLoading.value = false;
    signInLoading.refresh();
  }

  ///============================ Sign Up =========================
  RxBool signUpLoading = false.obs;

  signup({required BuildContext context}) async {
    signUpLoading.value = true;
    var body = {
      "name": nameController.value.text,
      "email": emailController.value.text,
      "phone_number": phoneController.value.text,
      "password": passController.value.text,
      "confirmPassword": confirmController.value.text
    };

    var response = await apiClient.post(
        context: context,
        body: body,
        isBasic: true,
        url: isClient.value
            ? ApiUrl.signUpClient.addBaseUrl
            : ApiUrl.signUpWorker.addBaseUrl);

    if (response.statusCode == 200) {
      secondsRemaining.value = 60;
      secondsRemaining.refresh();
      startTimer();
      AppRouter.route.pushNamed(RoutePath.varification,
          extra: {AppStrings.screen: Screen.signUp});
    } else {
      // ignore: use_build_context_synchronously
      checkApi(response: response, context: context);
    }

    signUpLoading.value = false;
    signUpLoading.refresh();
  }

  /// ====================== signUpOtpVarify ========================
  RxBool verifyLoading = false.obs;

  signUpOtpVerify({required BuildContext context}) async {
    verifyLoading.value = true;
    var body = {
      "email": emailController.value.text,
      "activation_code": otpController.value.text
    };

    var response = await apiClient.patch(
        body: body,
        isBasic: true,
        url: isClient.value
            ? ApiUrl.activeClient.addBaseUrl
            : ApiUrl.activeWorker.addBaseUrl);

    if (response.statusCode == 201) {
      timer.cancel();
      showSnackBar(
          // ignore: use_build_context_synchronously
          context: context,
          content: response.body["message"],
          backgroundColor: Colors.green);

      AppRouter.route.pushReplacementNamed(
        RoutePath.login,
      );
    } else {
      // ignore: use_build_context_synchronously
      checkApi(response: response, context: context);
    }

    verifyLoading.value = false;
  }

  /// ======================== Timer ====================

  RxInt secondsRemaining = 60.obs;
  late Timer timer;

  void startTimer() {
    debugPrint("resend OTP Timer -------->>>>>>>>> $secondsRemaining");
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
        secondsRemaining.refresh();
        debugPrint("resend OTP Timer -------->>>>>>>>> $secondsRemaining");
      } else {
        timer.cancel();
      }
    });
  }

  /// ===================== Resent OTP ======================

  Future<bool> resendOTP() async {
    var body = {"email": emailController.value.text};

    var response = await apiClient.patch(
        isBasic: true,
        body: body,
        url: isClient.value
            ? ApiUrl.resendOTpClient.addBaseUrl
            : ApiUrl.resendOTpClient.addBaseUrl);

    if (response.statusCode == 200) {
      secondsRemaining.value = 60;
      secondsRemaining.refresh();
      startTimer();

      return true;
    } else {
      return false;
    }
  }
}
