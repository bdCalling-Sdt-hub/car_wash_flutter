import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PackageStatus extends StatelessWidget {
  const PackageStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.sp),
      color: AppColors.primaryColor.withOpacity(.1),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// ==================== Package Name ================
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: AppStrings.package),
              CustomText(
                text: "Standard",
                color: AppColors.greenColor,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),

          /// ==================== Total Package ================
          Column(
            children: [
              CustomText(text: AppStrings.total),
              CustomText(
                text: "4",
                color: AppColors.greenColor,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),

          /// ==================== Taken Service ================
          Column(
            children: [
              CustomText(text: AppStrings.taken),
              CustomText(
                text: "1",
                color: AppColors.greenColor,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),

          /// ==================== Remain Service ================
          Column(
            children: [
              CustomText(text: AppStrings.remains),
              CustomText(
                text: "3",
                color: AppColors.greenColor,
                fontWeight: FontWeight.w500,
              ),
            ],
          )
        ],
      ),
    );
  }
}
