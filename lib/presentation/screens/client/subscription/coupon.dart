import 'package:car_wash/presentation/widgets/custom_button/custom_button.dart';
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/presentation/widgets/custom_text_field/custom_text_field.dart';
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:car_wash/utils/dimensions/dimensions.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CouponScreen extends StatelessWidget {
  const CouponScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.couponCode,
          fontSize: Dimensions.getFontSizeExtraLarge(context),
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            CustomText(
                textAlign: TextAlign.start,
                maxLines: 2,
                top: 24.h,
                bottom: 24.h,
                text: AppStrings.ifYouUseOurCouponCode(
                    price: "\$22", percentage: "5%")),

            /// =========================== Text Editing Field ==========================

            CustomTextField(
              hintText: AppStrings.applyCouponCode,
              fillColor: AppColors.primaryColor.withOpacity(0.3),
            ),

            const Expanded(child: SizedBox()),

            ...[
              CustomText(
                text: "Total Price: \$20",
                fontWeight: FontWeight.w600,
                fontSize: Dimensions.getFontSizeLarge(context),
              ),
              IconButton(
                onPressed: () {},
                icon: const CustomText(text: AppStrings.dontHaveACouponCode),
              ),
              CustomButton(
                onTap: () {},
                title: AppStrings.apply,
              ),
              Gap(24.h)
            ]
          ],
        ),
      ),
    );
  }
}
