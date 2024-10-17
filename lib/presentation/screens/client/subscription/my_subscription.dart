import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/presentation/widgets/package_card/package_card.dart';
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:car_wash/utils/dimensions/dimensions.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClientSubscription extends StatelessWidget {
  const ClientSubscription({super.key});

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// ==================== Subscription Buying Date ===================

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: AppStrings.subsCriptionBuying),
                    CustomText(text: "05-02-2024"),
                  ],
                ),

                /// ==================== Subscription Ending Date ===================

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: AppStrings.subsCriptionEnding),
                    CustomText(text: "05-12-2024"),
                  ],
                ),
              ],
            ),

            ///====================== Package Card =======================
            CustomText(
              top: 20.h,
              bottom: 24.h,
              text: AppStrings.package,
              fontSize: Dimensions.getButtonFontSizeLarge(context),
            ),
            PackageCard(
                packageId: "",
                showBuyButton: false,
                serviceID: "¥120",
                title: "Stander Wash ",
                description: "(4 times per month, expiring after a month)",
                serviceList: const [],
                color: AppColors.greenColor)
          ],
        ),
      ),
    );
  }
}
