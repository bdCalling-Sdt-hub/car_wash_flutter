import 'package:car_wash/global/error_screen/error_screen.dart';
import 'package:car_wash/global/no_internet/no_internet.dart';
import 'package:car_wash/helper/date_time_converter/date_time_converter.dart';
import 'package:car_wash/presentation/screens/client/subscription/controller/subscription_controller.dart';
import 'package:car_wash/presentation/widgets/custom_loader/custom_loader.dart';
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/presentation/widgets/package_card/package_card.dart';
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:car_wash/utils/app_const/app_const.dart';
import 'package:car_wash/utils/dimensions/dimensions.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ClientSubscription extends StatelessWidget {
  ClientSubscription({super.key});

  final SubscriptionController subscriptionController =
      Get.find<SubscriptionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.subscription.tr,
          fontSize: Dimensions.getFontSizeExtraLarge(context),
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Obx(() {
        switch (subscriptionController.subscriptionLoading.value) {
          case Status.loading:
            return const CustomLoader();
          case Status.internetError:
            return NoInternetScreen(
              onTap: () {
                subscriptionController.getSubscriptionPackages(
                    context: context);
              },
            );
          case Status.error:
            return GeneralErrorScreen(
              onTap: () {
                subscriptionController.getSubscriptionPackages(
                    context: context);
              },
            );
          case Status.noDataFound:
            return  Center(
              child: CustomText(text: AppStrings.noDataFound.tr),
            );
          case Status.completed:
            var data = subscriptionController.myPackageModel.value.data;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// ===================== Subscription Buying Date ====================

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(text: AppStrings.subsCriptionBuying),
                          CustomText(
                              text: DateConverter.estimatedDate(data
                                      ?.subscription?.createdAt ??
                                  DateTime.now())), // Replace with actual date
                        ],
                      ),

                      /// ==================== Subscription Ending Date ===================

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(text: AppStrings.subsCriptionEnding),
                          CustomText(
                              text: DateConverter.estimatedDate(data
                                      ?.subscription?.expiryTime ??
                                  DateTime.now())), // Replace with actual date
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  /// Package Text
                  CustomText(
                    text: AppStrings.package.tr,
                    fontSize: Dimensions.getButtonFontSizeLarge(context),
                    bottom: 24.h,
                  ),

                  /// ======================== Package Card ======================

                  PackageCard(
                    packageId: data?.package?.id ?? "",
                    price: "",
                    showBuyButton: false,
                    serviceID: data?.subscription?.serviceId ?? "",
                    title: data?.package?.packageTitle ?? "",
                    description: data?.package?.packageDescription ?? "",
                    serviceList: data?.package?.services ?? [],
                    color: AppColors.greenColor,
                  ),

                  /// ============= Service Text =============

                  CustomText(
                    text: AppStrings.service.tr,
                    fontSize: Dimensions.getButtonFontSizeLarge(context),
                    bottom: 24.h,
                  ),

                  /// ======================== Service Card ======================
                  PackageCard(
                    packageId: data?.service?.id ?? "",
                    price: "¥${data?.service?.price}",
                    showBuyButton: false,
                    serviceID: data?.subscription?.serviceId ?? "",
                    title: data?.service?.serviceName ?? "",
                    description: "",
                    serviceList: data?.package?.services ?? [],
                    color: AppColors.greenColor,
                  ),
                ],
              ),
            );
        }
      }),
    );
  }
}
