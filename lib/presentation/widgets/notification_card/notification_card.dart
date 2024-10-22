import 'package:car_wash/core/custom_assets/assets.gen.dart';
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.createdAt,
      required this.isRead});
  final String title;
  final String subTitle;
  final String createdAt;
  final bool isRead;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isRead ? null : AppColors.whiteColor,
      margin: EdgeInsets.only(bottom: 20.r),
      padding: EdgeInsets.all(20.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ///===================== Icon =====================

          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              //color: AppColors.greenColor,
            ),
            padding: EdgeInsets.all(2.r),
            child: Assets.icons.notificationGreen.svg(),
          ),
          Gap(10.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ===================== Title =====================

                CustomText(
                  text: title,
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  textAlign: TextAlign.left,
                  text: subTitle,
                  maxLines: 4,
                ),
              ],
            ),
          ),

          ///===================== Created At Time =====================
          CustomText(text: createdAt),
        ],
      ),
    );
  }
}
