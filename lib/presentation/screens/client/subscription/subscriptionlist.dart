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

class SubscriptionPackages extends StatelessWidget {
  SubscriptionPackages({super.key});

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
              return ListView.builder(
                itemCount: subscriptionController.subscriptionList.length,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                itemBuilder: (context, index) {
                  var data = subscriptionController.subscriptionList[index];
                  return PackageCard(
                    serviceID: data.id ?? "",
                    title: data.packageTitle ?? "",
                    description: data.packageDescription ?? "",
                    serviceList: data.services ?? [],
                    color: AppColors.shootColor,
                    packageId: data.id ?? "", // Pass the unique package ID here
                  );
                },
              );
          }
        })

        // const Column(
        //   children: [
        //     PackageCard(
        //         price: "¥120",
        //         title: "Stander Wash ",
        //         description: "(4 times per month, expiring after a month)",
        //         serviceList: [
        //           "Exterior small car",
        //           "Exterior medium car",
        //           "Exterior big car",
        //           "Interior and exterior small car",
        //           "Interior and exterior medium car",
        //         ],
        //         color: AppColors.shootColor),
        //     Gap(20),
        //     PackageCard(
        //         price: "¥120",
        //         title: "Stander Wash ",
        //         description: "(4 times per month, expiring after a month)",
        //         serviceList: [
        //           "Exterior small car",
        //           "Exterior medium car",
        //           "Exterior big car",
        //           "Interior and exterior small car",
        //           "Interior and exterior medium car",
        //         ],
        //         color: AppColors.greenColor),
        //     Gap(20),
        //     PackageCard(
        //         price: "¥120",
        //         title: "Stander Wash ",
        //         description: "(4 times per month, expiring after a month)",
        //         serviceList: [
        //           "Exterior small car",
        //           "Exterior medium car",
        //           "Exterior big car",
        //           "Interior and exterior small car",
        //           "Interior and exterior medium car",
        //         ],
        //         color: AppColors.primaryColor),
        //   ],
        // ),

        );
  }
}
