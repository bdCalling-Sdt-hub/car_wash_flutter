import 'package:car_wash/dependency_injection/path.dart';
import 'package:car_wash/global/general_controller/general_controller.dart';
import 'package:car_wash/helper/extension/base_extension.dart';
import 'package:car_wash/helper/tost_message/show_snackbar.dart';
import 'package:car_wash/presentation/screens/client/subscription/model/subscription_packages_model.dart';
import 'package:car_wash/scret_key.dart';
import 'package:car_wash/service/api_service.dart';
import 'package:car_wash/service/api_url.dart';
import 'package:car_wash/service/check_api.dart';
import 'package:car_wash/utils/app_const/app_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay/pay.dart';

class SubscriptionController extends GetxController {
  ApiClient apiClient = serviceLocator();

  GeneralController generalController = Get.find<GeneralController>();

  final subscriptionLoading = Status.loading.obs;
  void subscriptionLoadingMethod(Status value) =>
      subscriptionLoading.value = value;

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

  // This will clear the previous selection if the user selects a service from a different package
  void selectService(Service service, String packageId) {
    if (selectedPackageId.value != packageId) {
      // If a new package is selected, clear the previous service selection
      selectedService.value = null;
    }
    selectedService.value = service;
    selectedPackageId.value = packageId;
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

  /// ========================= Apple Pay ======================

  applePay({required String finalPrice, required BuildContext context}) async {
    var paymentItems = [
      PaymentItem(
        label: 'Total',
        amount: finalPrice,
        status: PaymentItemStatus.final_price,
      )
    ];

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: ApplePayButton(
            paymentConfiguration:
                PaymentConfiguration.fromJsonString(defaultApplePay),
            paymentItems: [
              PaymentItem(
                label: 'Total',
                amount: finalPrice,
                status: PaymentItemStatus.final_price,
              )
            ],
            style: ApplePayButtonStyle.black,
            type: ApplePayButtonType.buy,
            margin: const EdgeInsets.only(top: 15.0),
            onPaymentResult: (result) {},
            loadingIndicator: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  @override
  void onInit() {
    getSubscriptionPackages();
    super.onInit();
  }
}
