import 'package:car_wash/core/custom_assets/assets.gen.dart';
import 'package:car_wash/core/routes/route_path.dart';
import 'package:car_wash/presentation/screens/auth/controller/auth_controller.dart';
import 'package:car_wash/presentation/widgets/custom_button/custom_button.dart';
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:car_wash/utils/app_const/app_const.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/utils/dimensions/dimensions.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VarificationScreen extends StatelessWidget {
  VarificationScreen({super.key, required this.screen});
  final AuthController authController = Get.find<AuthController>();
  final formKey = GlobalKey<FormState>();

  final Map<String, dynamic> screen;

  @override
  Widget build(BuildContext context) {
    // print("Screen Type ${screen[AppStrings.screen]}");
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          title: CustomText(
            text: AppStrings.verification,
            fontWeight: FontWeight.w500,
            fontSize: Dimensions.getFontSizeExtraLarge(context),
          ),
        ),
        body: Obx(() {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Center(
              child: Column(
                children: [
                  Gap(44.h),
                  CustomText(
                    bottom: 16.h,
                    text: AppStrings.enterVerificationCode,
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.getFontSizeExtraLarge(context),
                  ),

                  ///==================== PIN Put input Field =======================

                  PinCodeTextField(
                    key: formKey,
                    //controller: authController.otpController.value,
                    length: 6,
                    cursorColor: AppColors.primaryColor,
                    keyboardType: TextInputType.text,
                    enablePinAutofill: true,
                    appContext: (context),
                    onCompleted: (value) {
                      authController.otpController.value.text = value;
                    },
                    autoFocus: true,
                    textStyle: const TextStyle(
                        color: AppColors.whiteColor, fontSize: 24),
                    pinTheme: PinTheme(
                      disabledColor: Colors.transparent,
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 54.h,
                      fieldWidth: 44,
                      activeFillColor: AppColors.blackLightColor,
                      selectedFillColor: AppColors.grayColor,
                      inactiveFillColor: AppColors.whiteColor,
                      borderWidth: 0.5,
                      errorBorderColor: Colors.red,
                      activeBorderWidth: 0,
                      selectedColor: AppColors.grayColor,
                      inactiveColor: const Color(0xFFCCCCCC),
                      activeColor: AppColors.grayColor,
                    ),
                    enableActiveFill: true,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: AppStrings.didntRecieveAnyCode,
                        fontSize: Dimensions.getFontSizeSmall(context),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: CustomText(
                            text: AppStrings.resend,
                            fontSize: Dimensions.getFontSizeSmall(context),
                          ))
                    ],
                  ),

                  ///====================== Varify Button ======================
                  Gap(64.h),
                  authController.verifyLoading.value
                      ? Align(
                          alignment: Alignment.center,
                          child: Assets.lottie.loading.lottie(
                              width: context.width / 6, fit: BoxFit.cover),
                        )
                      : CustomButton(
                          onTap: () {
                            //context.pushNamed(RoutePath.resetPass);

                            if (screen[AppStrings.screen] == Screen.signUp) {
                              authController.signUpOtpVerify(context: context);
                            }
                          },
                          title: AppStrings.verify,
                        )
                ],
              ),
            ),
          );
        }));
  }
}
