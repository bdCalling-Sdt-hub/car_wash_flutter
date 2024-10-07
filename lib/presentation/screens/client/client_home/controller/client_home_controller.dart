import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientHomeController extends GetxController {
  Rx<TextEditingController> searchController = TextEditingController().obs;
  Rx<PageController> pagecontroller = PageController().obs;

  Rx<TextEditingController> dateController = TextEditingController().obs;
  Rx<TextEditingController> timeController = TextEditingController().obs;

  Rx<TextEditingController> descriptionController = TextEditingController().obs;
  //Rx<TextEditingController> searchController = TextEditingController().obs;

  List<String> tapbarItems = [
    AppStrings.upcomingDate,
    AppStrings.current,
    AppStrings.completed,
  ];

  RxInt tappedIndex = 0.obs;

  /// ====================== Req Service =====================
}
