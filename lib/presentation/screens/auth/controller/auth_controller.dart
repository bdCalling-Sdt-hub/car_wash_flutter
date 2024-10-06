import 'package:car_wash/core/routes/route_path.dart';
import 'package:car_wash/core/routes/routes.dart';
import 'package:car_wash/dependency_injection/path.dart';
import 'package:car_wash/helper/extension/base_extension.dart';
import 'package:car_wash/helper/local_db/local_db.dart';
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
      TextEditingController(text: kDebugMode ? "client1@gmail.com" : "").obs;
  Rx<TextEditingController> passController =
      TextEditingController(text: kDebugMode ? "1234567Rr" : "").obs;
  Rx<TextEditingController> confirmController =
      TextEditingController(text: kDebugMode ? "1234567Rr" : "").obs;

  Rx<TextEditingController> otpController = TextEditingController().obs;

  Rx<bool> rememberMe = false.obs;
  Rx<bool> isAgree = false.obs;
  Rx<bool> isClient = true.obs;

  ApiClient apiClient = ApiClient();

  DBHelper dbHelper = serviceLocator();

  ///============================ Sign In =========================
  RxBool signInLoading = false.obs;

  signIn({required BuildContext context}) async {
    signInLoading.value = true;

    var body = {
      "email": emailController.value.text,
      "password": passController.value.text
    };
    var response = await apiClient.post(
        body: body,
        isBasic: true,
        url: isClient.value
            ? ApiUrl.signInClient.addBaseUrl
            : ApiUrl.signInWorker.addBaseUrl);

    // // Ensure the widget is still mounted before using BuildContext
    // if (!context.mounted) return;

    if (response.statusCode == 200) {
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
        body: body,
        isBasic: true,
        url: isClient.value
            ? ApiUrl.signUpClient.addBaseUrl
            : ApiUrl.signUpWorker.addBaseUrl);

    if (response.statusCode == 200) {
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

    if (response.statusCode == 200) {
      AppRouter.route.pushReplacementNamed(
        RoutePath.login,
      );
    } else {
      // ignore: use_build_context_synchronously
      checkApi(response: response, context: context);
    }

    verifyLoading.value = false;
  }
}
