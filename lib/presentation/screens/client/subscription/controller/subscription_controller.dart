import 'package:car_wash/dependency_injection/path.dart';
import 'package:car_wash/global/general_controller/general_controller.dart';
import 'package:car_wash/helper/extension/base_extension.dart';
import 'package:car_wash/helper/tost_message/show_snackbar.dart';
import 'package:car_wash/presentation/screens/client/subscription/model/my_package/my_package_model.dart';
import 'package:car_wash/presentation/screens/client/subscription/model/subscription_packages_model.dart';
import 'package:car_wash/service/api_service.dart';
import 'package:car_wash/service/api_url.dart';
import 'package:car_wash/service/check_api.dart';
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:car_wash/utils/app_const/app_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionController extends GetxController {
  ApiClient apiClient = serviceLocator();

  GeneralController generalController = Get.find<GeneralController>();

  final subscriptionLoading = Status.loading.obs;
  void subscriptionLoadingMethod(Status value) =>
      subscriptionLoading.value = value;

  final mySubscriptionLoading = Status.loading.obs;
  void mySubscriptionLoadingMethod(Status value) =>
      mySubscriptionLoading.value = value;

  /// ===================== Get Subscription Package List =====================

  RxList<SubscriptionPackagesModel> subscriptionList =
      <SubscriptionPackagesModel>[].obs;

  getSubscriptionPackages({BuildContext? context}) async {
    subscriptionLoadingMethod(Status.loading);

    var response = await apiClient.get(
        url: ApiUrl.subscriptionPackages.addBaseUrl, context: context);

    if (response.statusCode == 200) {
      subscriptionList.value = List<SubscriptionPackagesModel>.from(response
          .body["data"]["result"]
          .map((x) => SubscriptionPackagesModel.fromJson(x)));
      subscriptionLoadingMethod(Status.completed);
    } else {
      checkApi(response: response, context: context);
      if (response.statusCode == 503) {
        subscriptionLoadingMethod(Status.internetError);
      } else if (response.statusCode == 404) {
        subscriptionLoadingMethod(Status.noDataFound);
      } else {
        subscriptionLoadingMethod(Status.error);
      }
    }
  }

  /// ============================== Select Service ===============================

  RxInt selectedMoney = 0.obs;
  RxInt discount = 0.obs;

// Track the currently selected service and package
  Rx<Service?> selectedService = Rx<Service?>(null);
  RxString selectedPackageId = ''.obs;
  RxString selectedServiceId = ''.obs;
  RxString paymentIntentId = ''.obs;

  // This will clear the previous selection if the user selects a service from a different package
  void selectService(Service service, String packageId) {
    if (selectedPackageId.value != packageId) {
      // If a new package is selected, clear the previous service selection
      selectedService.value = null;
    }
    selectedService.value = service;
    selectedPackageId.value = packageId;
    selectedServiceId.value = service.id ?? "";
    selectedMoney.value = service.price ?? 0;
    selectedMoney.refresh();
    debugPrint("Selected Service Price ===>>> ${service.price}");
  }

  int calculateDiscountedPrice(
      {required int amount, required int discountPercentage}) {
    // Convert discount percentage to a decimal and calculate the discount amount
    double discount = (discountPercentage / 100) * amount;

    // Subtract discount from the original amount to get the final price
    int finalPrice = amount - discount.toInt();

    return finalPrice;
  }

  /// ======================- Apply Coupon Code =====================

  // RxBool isApplyCoupon = false.obs;
  Rx<TextEditingController> couponCodeTextfield = TextEditingController().obs;

  applyCouponCode({required BuildContext context}) async {
    generalController.showPopUpLoader(context: context);
    discount.value = 0;

    var response = await apiClient.get(
        showResult: true,
        url: ApiUrl.applyCoupon(couponCode: couponCodeTextfield.value.text)
            .addBaseUrl);

    if (response.statusCode == 200) {
      discount.value = response.body["data"]["percentage"];

      couponCodeTextfield.value.clear();
    } else {
      showSnackBar(context: context, content: "No discount found");
    }

    Navigator.of(context).pop();
  }

  /// ========================= Confirm Subscription ======================

  confirmSubscription(
      {required BuildContext context,
      required String packageId,
      required int price,
      required bool coupon,
      required String paymentIntentId,
      required String serviceId}) async {
    generalController.showPopUpLoader(context: context);

    var body = {
      "packageId": packageId,
      "serviceId": serviceId,
      "price": price,
      "coupon": coupon,
      "paymentIntentId": "paymentIntentId"
    };
    var response = await apiClient.patch(
        url: ApiUrl.confirmSubscription.addBaseUrl, body: body);

    if (response.statusCode == 200) {
      showSnackBar(
          context: context,
          content: response.body["message"],
          backgroundColor: AppColors.grayColor);
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pop();
      checkApi(response: response);
    }
  }

  /// ============================ My Subscription ========================
  Rx<MyPackageModel> myPackageModel = MyPackageModel().obs;
  getMySubscription({BuildContext? context}) async {
    mySubscriptionLoadingMethod(Status.loading);

    var response =
        await apiClient.get(url: ApiUrl.getMySubscription.addBaseUrl);

    if (response.statusCode == 200) {
      myPackageModel.value = MyPackageModel.fromJson(response.body);
      subscriptionLoadingMethod(Status.completed);
    } else {
      checkApi(response: response, context: context);
      if (response.statusCode == 503) {
        subscriptionLoadingMethod(Status.internetError);
      } else if (response.statusCode == 404) {
        subscriptionLoadingMethod(Status.noDataFound);
      } else {
        subscriptionLoadingMethod(Status.error);
      }
    }
  }

  @override
  void onInit() {
    getMySubscription();
    getSubscriptionPackages();
    super.onInit();
  }
}
