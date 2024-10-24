import 'package:car_wash/global/language/controller/language_controller.dart';
import 'package:car_wash/helper/local_db/local_db.dart';
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/utils/app_const/app_const.dart';
import 'package:car_wash/utils/dimensions/dimensions.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChooseLanguage extends StatelessWidget {
  ChooseLanguage({super.key});

  final LanguageController languageController = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.chooseALanguage.tr,
          fontSize: Dimensions.getFontSizeExtraLarge(context),
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Obx(() {
        return Column(
          children: List.generate(languageController.languages.length, (index) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Radio<String>(
                    value: languageController.languages[index],
                    groupValue: languageController.isEnglish.value
                        ? languageController.selectedLanguage.value
                        : languageController.languages[1],
                    onChanged: (String? value) async {
                      languageController.selectedLanguage.value = value!;
                      if (index == 0) {
                        languageController.isEnglish.value = true;
                        Get.updateLocale(const Locale("en", "US"));
                        // SharePrefsHelper.setBool(AppConstants.isEnglish, true);

                        // dbHelper.saveValue(key: languageName, value: true);
                        SharePrefsHelper.setBool(AppConstants.language, true);
                      } else {
                        languageController.isEnglish.value = false;

                        Get.updateLocale(const Locale("ar", "SA"));
                        SharePrefsHelper.setBool(AppConstants.language, false);
                      }
                    },
                  ),
                  CustomText(text: languageController.languages[index]),
                  // SizedBox(
                  //   height: controller.height.value,
                  // )
                ],
              ),
            );
          }),
        );
      }),
    );
  }
}
