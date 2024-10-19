import 'package:car_wash/global/error_screen/error_screen.dart';
import 'package:car_wash/global/no_internet/no_internet.dart';
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
          text: AppStrings.subscription,
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
            return const Center(
              child: CustomText(text: AppStrings.noDataFound),
            );
          case Status.completed:
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// Subscription Buying Date
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: AppStrings.subsCriptionBuying),
                          CustomText(
                              text: "05-02-2024"), // Replace with actual date
                        ],
                      ),

                      /// Subscription Ending Date
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: AppStrings.subsCriptionEnding),
                          CustomText(
                              text: "05-12-2024"), // Replace with actual date
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  /// Package Text
                  CustomText(
                    text: AppStrings.package,
                    fontSize: Dimensions.getButtonFontSizeLarge(context),
                    bottom: 24.h,
                  ),

                  /// Package Card
                  PackageCard(
                    packageId: "", // Provide a valid packageId
                    showBuyButton: false,
                    serviceID: "¥120",
                    title: "Standard Wash",
                    description: "(4 times per month, expiring after a month)",
                    serviceList: const [], // Provide actual service list
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
