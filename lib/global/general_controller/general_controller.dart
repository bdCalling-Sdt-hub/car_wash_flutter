import 'package:car_wash/core/custom_assets/assets.gen.dart';
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
      // Convert to 12-hour format
      final hours = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
      final minutes = time.minute.toString().padLeft(2, '0');
      final period = time.period == DayPeriod.am ? "AM" : "PM";

      String formattedTime = "$hours:$minutes $period";

      // Update the observable variable with the formatted time
      return pickedTime.value = formattedTime;
    }

    // Return an empty string if no time is selected
    return "";
  }

  /// =========================== Pop Up Loader ===========================
  showPopUpLoader({required BuildContext context}) {
    return showDialog(
        barrierDismissible: true,
        barrierColor: Colors.transparent,
        context: context,
        builder: (context) {
          return SizedBox(
            height: 70,
            child: AlertDialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              content: Assets.lottie.screenLoadingAni.lottie(
                height: 100,
                width: 100,
                fit: BoxFit.contain,
              ),
            ),
          );
        });
  }
}
