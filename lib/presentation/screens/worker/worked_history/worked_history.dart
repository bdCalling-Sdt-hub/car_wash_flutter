import 'package:car_wash/presentation/screens/job_history/job_history.dart';
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/presentation/widgets/custom_text_field/custom_text_field.dart';
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:car_wash/utils/dimensions/dimensions.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WorkedHistory extends StatelessWidget {
  const WorkedHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.history.tr,
          fontSize: Dimensions.getFontSizeExtraLarge(context),
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Column(
        children: [
          /// ======================== Text Editing Controller ========================

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: CustomTextField(
              hintText: AppStrings.searchhere.tr,
              prefixIcon: const Icon(Icons.search),
              fillColor: AppColors.whiteColor,
              textEditingController: TextEditingController(),
              // fillColor: AppColors.whiteColor,
            ),
          ),

          JobHistoryScreen()
        ],
      ),
    );
  }
}
