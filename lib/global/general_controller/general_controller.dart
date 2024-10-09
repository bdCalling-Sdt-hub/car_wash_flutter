import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GeneralController extends GetxController {
  RxBool isEnglish = true.obs;

  List<String> languages = [
    AppStrings.english,
    AppStrings.arabic,
  ];

  /// ========================= Picked Date =======================

  RxString pickedDate = "".obs;

  Future<String> pickDate(BuildContext context) async {
    // Show Date Picker
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      // Format the date to "25 Aug 2024"
      String formattedDate = DateFormat('d MMM y').format(date);

      // debugPrint("Picked Date ----->>>>>> $pickedDate");
      return pickedDate.value = formattedDate;
    }

    return "";
  }

  RxString pickedTime = "".obs;

  /// ========================= Picked Tine =======================

  Future<String> pickTime(BuildContext context) async {
    // Show Time Picker
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      String formattedTime =
          "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";

      // Update the observable variable
      return pickedTime.value = formattedTime;
    }
    return "";
  }
}
