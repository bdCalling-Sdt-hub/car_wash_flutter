import 'package:car_wash/core/custom_assets/assets.gen.dart';
import 'package:car_wash/helper/network_image/network_image.dart';
import 'package:car_wash/presentation/widgets/custom_button/custom_button.dart';
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:car_wash/utils/app_const/app_const.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class WorkStartScreen extends StatelessWidget {
  const WorkStartScreen(
      {super.key,
      required this.startTime,
      required this.endTime,
      required this.beforeCleaningImg,
      required this.afterCleaningImg,
      this.onTap});

  final String startTime;
  final String endTime;
  final String beforeCleaningImg;
  final String afterCleaningImg;
  final void onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            ///=========================== Time Schedule Design ================================
            Container(
              padding: EdgeInsets.all(20.r),
              color: AppColors.greenColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const CustomText(
                        text: AppStrings.startTime,
                        fontWeight: FontWeight.w500,
                      ),

                      ///========================= Start Time =======================
                      CustomText(text: startTime),
                    ],
                  ),
                  Assets.icons.clock.svg(),
                  Column(
                    children: [
                      const CustomText(
                        text: AppStrings.endTime,
                        fontWeight: FontWeight.w500,
                      ),

                      ///========================= End Time =======================
                      CustomText(text: endTime),
                    ],
                  ),
                ],
              ),
            ),
            Gap(20.h),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: AppStrings.beforeCleaning,
                  bottom: 10,
                ),
                //================ Before Cleaning Image=================

                CustomNetworkImage(
                    imageUrl: AppConstants.carDarty,
                    height: 200.h,
                    width: double.maxFinite)
              ],
            ),

            Gap(20.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: AppStrings.afterCleaning,
                  bottom: 10,
                ),
                //================ Before Cleaning Image=================

                CustomNetworkImage(
                    imageUrl: AppConstants.carClean,
                    height: 200.h,
                    width: double.maxFinite)
              ],
            ),

            //=========================== Start End Time ==========================
            CustomButton(
              marginVerticel: 20.h,
              onTap: () {},
              title: AppStrings.endWork,
            )
          ],
        ),
      ),
    );
  }
}
