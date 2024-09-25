import 'package:car_wash/core/custom_assets/assets.gen.dart';
import 'package:car_wash/core/routes/route_path.dart';
import 'package:car_wash/presentation/screens/auth/controller/auth_controller.dart';
import 'package:car_wash/presentation/widgets/custom_button/custom_button.dart';
import 'package:car_wash/presentation/widgets/custom_text_field/custom_text_field.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/utils/dimensions/dimensions.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ForgotPass extends StatelessWidget {
  ForgotPass({super.key});
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.forgot,
          fontWeight: FontWeight.w500,
          fontSize: Dimensions.getButtonFontSize(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Center(
          child: Column(
            children: [
              /// ======================== TOP =======================
              Gap(44.h),
              Assets.images.forget.image(),
              CustomText(
                top: 16.h,
                bottom: 10.h,
                fontWeight: FontWeight.w500,
                text: AppStrings.forgotPassword,
                fontSize: Dimensions.getFontSizeExtraLarge(context),
              ),
              CustomText(
                top: 16.h,
                bottom: 10.h,
                maxLines: 4,
                text: AppStrings.dontWorryItOccurs,
              ),
              Gap(24.h),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  bottom: 8.h,
                  text: AppStrings.email,
                  fontWeight: FontWeight.w500,
                ),
              ),

              /// ======================== Email Controller =======================
              CustomTextField(
                textEditingController: authController.emailController.value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppStrings.enterValidEmail;
                  } else if (!AppStrings.emailRegexp
                      .hasMatch(authController.emailController.value.text)) {
                    return AppStrings.enterValidEmail;
                  } else {
                    return null;
                  }
                },
              ),
              Gap(64.h),

              ///======================== Send OTP Button ======================

              CustomButton(
                onTap: () {
                  context.pushNamed(RoutePath.varification);
                },
                title: AppStrings.sendCode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
