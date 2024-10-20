import 'dart:io';

import 'package:car_wash/core/custom_assets/assets.gen.dart';
import 'package:car_wash/global/error_screen/error_screen.dart';
import 'package:car_wash/global/general_controller/general_controller.dart';
import 'package:car_wash/global/no_internet/no_internet.dart';
import 'package:car_wash/presentation/screens/profile/profile_controller/profile_controller.dart';
import 'package:car_wash/helper/network_image/network_image.dart';
import 'package:car_wash/presentation/widgets/custom_button/custom_button.dart';
import 'package:car_wash/presentation/widgets/custom_loader/custom_loader.dart';
import 'package:car_wash/presentation/widgets/custom_text_field/custom_text_field.dart';
import 'package:car_wash/service/api_url.dart';
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:car_wash/utils/app_const/app_const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/utils/dimensions/dimensions.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController profileController = Get.find<ProfileController>();
  final GeneralController generalController = Get.find<GeneralController>();

  @override
  Widget build(BuildContext context) {
    Widget customColum(
            {required String title,
            required bool readOnly,
            void Function()? onTap,
            required TextEditingController controller}) =>
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: title,
                bottom: 8.h,
              ),

              /// ======================== Text Editing Controller ========================

              CustomTextField(
                onTap: onTap,
                readOnly: readOnly,
                contentPadding: EdgeInsets.all(12.r),
                isDense: true,
                textEditingController: controller,
                // fillColor: AppColors.whiteColor,
              ),
            ],
          ),
        );
    return Scaffold(appBar: AppBar(
      title: Obx(() {
        return CustomText(
          text: !profileController.isUpdateProfile.value
              ? AppStrings.updateProfile
              : AppStrings.profile,
          fontSize: Dimensions.getFontSizeExtraLarge(context),
          fontWeight: FontWeight.w500,
        );
      }),
    ), body: Obx(() {
      switch (profileController.profileLoading.value) {
        case Status.loading:
          return const CustomLoader();
        case Status.internetError:
          return NoInternetScreen(
            onTap: () {
              profileController.getProfile(context: context);
            },
          );
        case Status.error:
          return GeneralErrorScreen(
            onTap: () {
              profileController.getProfile(context: context);
            },
          );

        case Status.noDataFound:
          return const Center(
            child: CustomText(text: AppStrings.noDataFound),
          );

        case Status.completed:
          var profileData = profileController.profileModel.value;
          return SingleChildScrollView(
            child: Container(
              height: !profileController.isUpdateProfile.value
                  ? context.height
                  : context.height / 1.1,
              width: double.maxFinite,
              color: AppColors.whiteColor,
              margin: EdgeInsets.all(20.r),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // ====================== Edit Button ======================
                      IconButton(
                          onPressed: () {
                            profileController.isUpdateProfile.value =
                                !profileController.isUpdateProfile.value;
                          },
                          icon: Assets.icons.edit.svg()),
                    ],
                  ),

                  /// ========================= Profile Image =======================

                  GestureDetector(
                    onTap: () async {
                      String selectedImage =
                          await generalController.selectImage();
                      profileController.imagePath.value = selectedImage;
                    },
                    child: profileController.imagePath.value.isEmpty
                        ? CustomNetworkImage(
                            boxShape: BoxShape.circle,
                            imageUrl:
                                "${ApiUrl.baseUrl}${profileData.profileImage}",
                            height: 80.sp,
                            width: 80.sp)
                        : Container(
                            height: 80.sp,
                            width: 80.sp,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(
                                      File(profileController.imagePath.value),
                                    ))),
                          ),
                  ),

                  /// ========================= Profile Name =======================

                  CustomText(
                    text: profileData.name ?? "",
                    top: 8.h,
                  ),

                  /// ========================= Profile Email =======================

                  CustomText(
                    text: profileData.email ?? "",
                    top: 8.h,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: const Divider(),
                  ),

                  /// ========================= Name Controller =======================
                  customColum(
                      readOnly: profileController.isUpdateProfile.value,
                      title: AppStrings.name,
                      controller: profileController.nameController.value),

                  /// ========================= Email Controller =======================
                  customColum(
                      readOnly: true,
                      title: AppStrings.email,
                      controller: profileController.emailController.value),

                  /// ========================= Contact Controller =======================
                  customColum(
                      readOnly: profileController.isUpdateProfile.value,
                      title: AppStrings.phnNumber,
                      controller: profileController.phoneController.value),

                  /// ========================= Date Of Birth Controller =======================
                  customColum(
                      onTap: () async {
                        if (!profileController.isUpdateProfile.value) {
                          generalController.pickDate(context).then((date) {
                            if (date.isNotEmpty) {
                              profileController.dOBController.value =
                                  TextEditingController(text: date);
                            }
                          });
                        }
                      },
                      readOnly: true,
                      title: AppStrings.dateOfBirth,
                      controller: profileController.dOBController.value),

                  // /// ========================= Address Controller =======================
                  customColum(
                      readOnly: profileController.isUpdateProfile.value,
                      title: AppStrings.location,
                      controller: profileController.addressController.value),

                  if (!profileController.isUpdateProfile.value)
                    profileController.updateProfileLoading.value
                        ? Align(
                            alignment: Alignment.center,
                            child: Assets.lottie.loading.lottie(
                                width: context.width / 6, fit: BoxFit.cover),
                          )
                        : CustomButton(
                            onTap: () {
                              profileController.updateProfile(context: context);
                            },
                            marginHorizontal: 20.w,
                            marginVerticel: 20.h,
                            title: AppStrings.updateProfile,
                            textColor: AppColors.whiteColor,
                          )
                ],
              ),
            ),
          );
      }
    }));
  }
}
