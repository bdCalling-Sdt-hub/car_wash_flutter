import 'package:car_wash/global/general_controller/general_controller.dart';
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/utils/dimensions/dimensions.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseLanguage extends StatelessWidget {
  ChooseLanguage({super.key});

  final GeneralController generalController = Get.find<GeneralController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.chooseALanguage,
          fontSize: Dimensions.getFontSizeExtraLarge(context),
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Obx(() {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 24.h),
          child: Column(
            children: [
              /// =================== English =================
              Row(
                children: [
                  Checkbox(
                    value: generalController.isEnglish.value,
                    onChanged: (value) {
                      generalController.isEnglish.value =
                          !generalController.isEnglish.value;
                    },
                  ),
                  CustomText(text: generalController.languages[0])
                ],
              ),

              /// =================== Arabic =================
              Row(
                children: [
                  Checkbox(
                    value: !generalController.isEnglish.value,
                    onChanged: (value) {
                      generalController.isEnglish.value =
                          !generalController.isEnglish.value;
                    },
                  ),
                  CustomText(text: generalController.languages[1])
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
