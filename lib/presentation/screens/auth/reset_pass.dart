import 'package:car_wash/core/routes/route_path.dart';
import 'package:car_wash/presentation/screens/auth/controller/auth_controller.dart';
import 'package:car_wash/presentation/widgets/custom_button/custom_button.dart';
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/presentation/widgets/custom_text_field/custom_text_field.dart';
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:car_wash/utils/dimensions/dimensions.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ResetPass extends StatelessWidget {
  ResetPass({super.key});
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.password,
          fontWeight: FontWeight.w500,
          fontSize: Dimensions.getFontSizeExtraLarge(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(44.h),
            CustomText(
              text: AppStrings.password,
              bottom: 8.h,
            ),

            ///======================== Password Field =======================

            CustomTextField(
              textEditingController: authController.passController.value,
              isPassword: true,
              validator: (value) {
                if (value.isEmpty) {
                  return AppStrings.passWordMustBeAtLeast;
                } else if (value.length < 8 ||
                    !AppStrings.passRegexp.hasMatch(value)) {
                  return AppStrings.passwordLengthAndContain;
                } else {
                  return null;
                }
              },
            ),
            Gap(16.h),

            CustomText(
              text: AppStrings.confirmPassword,
              bottom: 8.h,
            ),

            ///======================== Confirm Password Field =======================

            CustomTextField(
              textEditingController: authController.confirmController.value,
              isPassword: true,
              validator: (value) {
                if (value.isEmpty) {
                  return AppStrings.fieldCantNotBeEmpty;
                } else if (value != authController.passController.value.text) {
                  return "Password should match";
                }
                return null;
              },
            ),
            Gap(66.h),

            ///======================== Submit Button =======================
            CustomButton(
              onTap: () {
                context.pushReplacementNamed(RoutePath.login);
              },
              title: AppStrings.submit,
            )
          ],
        ),
      ),
    );
  }
}
