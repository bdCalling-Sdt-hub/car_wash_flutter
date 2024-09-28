import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/presentation/widgets/package_card/package_card.dart';
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:car_wash/utils/dimensions/dimensions.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubscriptionPackages extends StatelessWidget {
  const SubscriptionPackages({super.key});

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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: const Column(
          children: [
            PackageCard(
                price: "¥120",
                title: "Stander Wash ",
                description: "(4 times per month, expiring after a month)",
                serviceList: [
                  "Exterior small car",
                  "Exterior medium car",
                  "Exterior big car",
                  "Interior and exterior small car",
                  "Interior and exterior medium car",
                ],
                color: AppColors.shootColor),
            Gap(20),
            PackageCard(
                price: "¥120",
                title: "Stander Wash ",
                description: "(4 times per month, expiring after a month)",
                serviceList: [
                  "Exterior small car",
                  "Exterior medium car",
                  "Exterior big car",
                  "Interior and exterior small car",
                  "Interior and exterior medium car",
                ],
                color: AppColors.greenColor),
            Gap(20),
            PackageCard(
                price: "¥120",
                title: "Stander Wash ",
                description: "(4 times per month, expiring after a month)",
                serviceList: [
                  "Exterior small car",
                  "Exterior medium car",
                  "Exterior big car",
                  "Interior and exterior small car",
                  "Interior and exterior medium car",
                ],
                color: AppColors.primaryColor),
          ],
        ),
      ),
    );
  }
}
