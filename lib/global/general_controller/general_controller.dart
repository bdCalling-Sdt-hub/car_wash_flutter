import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:get/get.dart';

class GeneralController extends GetxController {
  RxBool isEnglish = true.obs;

  List<String> languages = [
    AppStrings.english,
    AppStrings.arabic,
  ];
}
