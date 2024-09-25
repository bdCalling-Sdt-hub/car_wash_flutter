import 'package:car_wash/core/custom_assets/assets.gen.dart';
import 'package:car_wash/presentation/screens/auth/controller/auth_controller.dart';
import 'package:car_wash/presentation/widgets/custom_button/custom_button.dart';
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/presentation/widgets/custom_text_field/custom_text_field.dart';
import 'package:car_wash/utils/dimensions/dimensions.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});

  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: CustomText(
      //     text: AppStrings.login,
      //     fontWeight: FontWeight.w500,
      //     fontSize: Dimensions.getButtonFontSizeLarge(context),
      //   ),
      // ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///================== TOP ===================
              Gap(44.h),
              Center(
                child: Column(
                  children: [
                    SizedBox(height: Dimensions.getFontSizeOverLarge(context)),
                    Assets.images.login.image(),
                    CustomText(
                      text: AppStrings.login,
                      fontSize: Dimensions.getButtonFontSize(context),
                    ),
                  ],
                ),
              ),
              Gap(24.h),
              const CustomText(text: AppStrings.email),

              ///===================== Email Login ==========================
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

              Gap(16.h),

              const CustomText(text: AppStrings.password),

              ///===================== Password Login ==========================
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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      ///==================== Check Box ===================

                      Checkbox(
                        value: authController.rememberMe.value,
                        onChanged: (value) {
                          authController.rememberMe.value = value ?? false;
                        },
                      ),
                      CustomText(
                        text: AppStrings.rememberMe,
                        fontSize: Dimensions.getFontSizeSmall(context),
                      ),
                    ],
                  ),

                  ///==================== Forgot Password Button ===================

                  TextButton(
                      onPressed: () {},
                      child: CustomText(
                        text: AppStrings.forgotPassword,
                        fontSize: Dimensions.getFontSizeSmall(context),
                      )),
                ],
              ),

              /// ==================== Log In Button ===================
              Gap(44.h),
              CustomButton(onTap: () {}),
              Gap(16.h),

              Align(
                alignment: Alignment.center,
                child: TextButton(
                    onPressed: () {},
                    child: const CustomText(text: AppStrings.dontHaveAAccount)),
              )
            ],
          ),
        );
      }),
    );
  }
}
