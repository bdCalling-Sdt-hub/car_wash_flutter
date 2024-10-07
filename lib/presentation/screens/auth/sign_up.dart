import 'package:car_wash/core/custom_assets/assets.gen.dart';
import 'package:car_wash/helper/extension/base_extension.dart';
import 'package:car_wash/presentation/widgets/custom_button/custom_button.dart';
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/presentation/widgets/custom_text_field/custom_text_field.dart';
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:car_wash/utils/dimensions/dimensions.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'controller/auth_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.signUp,
          fontWeight: FontWeight.w500,
          fontSize: Dimensions.getFontSizeExtraLarge(context),
        ),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(10.h),

              // Align(
              //   alignment: Alignment.center,
              //   child: CustomText(
              //     text: AppStrings.chooseARole,
              //     bottom: 16.h,
              //     fontWeight: FontWeight.w500,
              //     fontSize: Dimensions.getFontSizeExtraLarge(context),
              //   ),
              // ),

              ///================= Choose Role ==================
              Row(
                children: [
                  ///===================== Client ===================
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      authController.isClient.value =
                          !authController.isClient.value;

                      debugPrint(
                          "Role ======>>>>>>> ${authController.isClient}");
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 44.h,
                      color: authController.isClient.value
                          ? AppColors.primaryColor
                          : AppColors.grayColor,
                      child: const CustomText(text: AppStrings.client),
                    ),
                  )),

                  ///===================== Worker ===================

                  Expanded(
                      child: InkWell(
                    onTap: () {
                      authController.isClient.value =
                          !authController.isClient.value;

                      debugPrint(
                          "Role ======>>>>>>> ${authController.isClient}");
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 44.h,
                      color: !authController.isClient.value
                          ? AppColors.primaryColor
                          : AppColors.grayColor,
                      child: const CustomText(text: AppStrings.worker),
                    ),
                  ))
                ],
              ),

              // Gap(24.h),
              14.heightWidth,

              CustomText(
                text: AppStrings.name,
                bottom: 8.h,
              ),

              ///===================== Name  ======================
              CustomTextField(
                textEditingController: authController.nameController.value,
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
              14.heightWidth,

              CustomText(
                text: AppStrings.email,
                bottom: 8.h,
              ),

              ///===================== Email  ======================
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

              14.heightWidth,

              CustomText(
                text: AppStrings.phnNumber,
                bottom: 8.h,
              ),

              ///===================== Phone Number  ======================
              CustomTextField(
                textEditingController: authController.phoneController.value,
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

              CustomText(
                top: 16.h,
                text: AppStrings.password,
                bottom: 8.h,
              ),

              ///======================== Password Field =======================

              CustomTextField(
                isDense: true,
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

              CustomText(
                top: 16.h,
                text: AppStrings.confirmPassword,
                bottom: 8.h,
              ),

              ///======================== Confirm Password Field =======================

              CustomTextField(
                isDense: true,
                textEditingController: authController.confirmController.value,
                isPassword: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return AppStrings.fieldCantNotBeEmpty;
                  } else if (value !=
                      authController.passController.value.text) {
                    return "Password should match";
                  }
                  return null;
                },
              ),
              14.heightWidth,

              Row(
                children: [
                  ///======================== Agreement Check =======================

                  Checkbox(
                      value: authController.isAgree.value,
                      onChanged: (value) {
                        authController.isAgree.value = value ?? false;
                      }),

                  Expanded(
                    child: RichText(
                      maxLines: 2,
                      text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                            text: AppStrings.byRegistering,
                            style: TextStyle(
                              color: AppColors.blackLightColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: " ${AppStrings.termsOfUse}",
                            style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                /// TODO Navigate to Terms and Condition
                                // Get.toNamed(AppRoute.termsAndConditionScreen);
                              },
                          ),
                          const TextSpan(
                            text: " and ",
                            style: TextStyle(
                              color: AppColors.blackLightColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(
                            text: "${AppStrings.privacyPolicy}.",
                            style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                /// TODO Navigate to Privacy Policy
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Gap(16.h),

              ///======================== Sign Up Submit Button =======================
              authController.signUpLoading.value
                  ? Align(
                      alignment: Alignment.center,
                      child: Assets.lottie.loading
                          .lottie(width: context.width / 6, fit: BoxFit.cover),
                    )
                  : CustomButton(
                      onTap: () {
                        // context.pushNamed(RoutePath.varification);
                        authController.signup(context: context);
                      },
                      title: AppStrings.signUp,
                    ),

              Align(
                alignment: Alignment.center,
                child: TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const CustomText(
                        text:
                            "${AppStrings.alreadyHaveaAccount} ${AppStrings.login}")),
              ),
            ],
          ),
        );
      }),
    );
  }
}
