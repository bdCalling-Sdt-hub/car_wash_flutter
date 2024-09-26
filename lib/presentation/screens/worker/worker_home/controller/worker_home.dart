import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkerHomeController extends GetxController {
  Rx<TextEditingController> searchController = TextEditingController().obs;
  Rx<PageController> pagecontroller = PageController().obs;

  List<String> tapbarItems = [
    AppStrings.newOrder,
    AppStrings.spam,
    AppStrings.history,
  ];

  RxInt tappedIndex = 0.obs;
}
