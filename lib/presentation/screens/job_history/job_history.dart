import 'package:car_wash/core/custom_assets/assets.gen.dart';
import 'package:car_wash/global/error_screen/error_screen.dart';
import 'package:car_wash/global/general_controller/general_controller.dart';
import 'package:car_wash/global/no_internet/no_internet.dart';
import 'package:car_wash/helper/date_time_converter/date_time_converter.dart';
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/presentation/widgets/service_card/service_card.dart';
import 'package:car_wash/utils/app_const/app_const.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobHistoryScreen extends StatelessWidget {
  JobHistoryScreen({super.key});

  final GeneralController generalController = Get.find<GeneralController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (generalController.historyLoading.value) {
        case Status.loading:
          return Assets.lottie.screenLoadingAni.lottie(
            height: 100,
            width: 100,
            fit: BoxFit.contain,
          );

        case Status.internetError:
          return NoInternetScreen(
            onTap: () {
              generalController.jobHistory();
            },
          );
        case Status.error:
          return GeneralErrorScreen(
            onTap: () {
              generalController.jobHistory();
            },
          );

        case Status.noDataFound:
          return Center(
            child: CustomText(
              text: AppStrings.noDataFound.tr,
              top: 40,
            ),
          );

        case Status.completed:
          return Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  generalController.jobList.length,
                  (index) {
                    var data = generalController.jobList[index];
                    return ServiceCard(
                      workingTime: "${data.jobDuration ?? ""} min",
                      afterCleaningImg: data.carImageAfter ?? "",
                      beforeCleaningImg: data.carImageBefore ?? "",
                      isHistory: true,
                      showButtons: false,
                      showDescription: false,
                      showCarImage: true,
                      date: DateConverter.estimatedDate(
                          data.bookedDateTime ?? DateTime.now()),
                      time: DateConverter.hourMinit(
                          data.bookedDateTime ?? DateTime.now()),
                      location: data.address ?? "",
                      number: "",
                      description: "",
                      onTapCancle: () {},
                      onTapStart: () {},
                    );
                  },
                ),
              ),
            ),
          );
      }
    });
  }
}
