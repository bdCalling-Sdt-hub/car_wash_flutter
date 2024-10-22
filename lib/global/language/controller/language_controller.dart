import 'package:car_wash/global/language/arabic/arabic.dart';
import 'package:car_wash/global/language/eng/eng.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "en_US": english,
        "ar_SA": arabic,
      };
}

class LanguageController extends GetxController {
  RxBool isEnglish = true.obs;
  // getLanguageType() async {
  //   isEnglish.value =
  //       await SharePrefsHelper.getBool(AppConstants.isEnglish) ?? true;

  //   debugPrint("Choosed Language===============>>>>>>>>>>>$isEnglish");

  //   if (isEnglish.value) {
  //     Get.updateLocale(const Locale("en", "US"));
  //   } else {
  //     Get.updateLocale(const Locale("fr", "CA"));
  //   }
  // }
}
