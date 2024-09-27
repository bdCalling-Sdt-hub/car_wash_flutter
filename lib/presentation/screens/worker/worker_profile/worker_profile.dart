import 'package:car_wash/core/custom_assets/assets.gen.dart';
import 'package:car_wash/global/profile_controller/profile_controller.dart';
import 'package:car_wash/helper/network_image/network_image.dart';
import 'package:car_wash/presentation/widgets/custom_text_field/custom_text_field.dart';
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:car_wash/utils/app_const/app_const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/utils/dimensions/dimensions.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkerProfile extends StatelessWidget {
  WorkerProfile({super.key});

  final ProfileController profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    Widget customColum(
            {required String title,
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
                isDense: true,
                textEditingController: controller,
                // fillColor: AppColors.whiteColor,
              ),
            ],
          ),
        );
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.profile,
          fontSize: Dimensions.getFontSizeExtraLarge(context),
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: AppColors.whiteColor,
        margin: EdgeInsets.all(20.r),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // ====================== Edit Button ======================
                IconButton(onPressed: () {}, icon: Assets.icons.edit.svg()),
              ],
            ),

            /// ========================= Profile Image =======================

            CustomNetworkImage(
                boxShape: BoxShape.circle,
                imageUrl: AppConstants.onlineImage,
                height: 80.sp,
                width: 80.sp),

            /// ========================= Profile Name =======================

            CustomText(
              text: "Fatma Jannat",
              top: 8.h,
            ),

            /// ========================= Profile Email =======================

            CustomText(
              text: "fatmajannat@gmail.com",
              top: 8.h,
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: const Divider(),
            ),

            /// ========================= Name Controller =======================
            customColum(
                title: AppStrings.name,
                controller: profileController.nameController.value),

            /// ========================= Email Controller =======================
            customColum(
                title: AppStrings.email,
                controller: profileController.emailController.value),

            /// ========================= Contact Controller =======================
            customColum(
                title: AppStrings.contactNumber,
                controller: profileController.phoneController.value),

            /// ========================= Location Controller =======================
            customColum(
                title: AppStrings.location,
                controller: profileController.locationController.value),
          ],
        ),
      ),
    );
  }
}
