import 'package:car_wash/core/custom_assets/assets.gen.dart';
import 'package:car_wash/global/error_screen/error_screen.dart';
import 'package:car_wash/global/no_internet/no_internet.dart';
import 'package:car_wash/helper/date_time_converter/date_time_converter.dart';
import 'package:car_wash/presentation/screens/worker/worker_home/controller/worker_home.dart';
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/presentation/widgets/service_card/service_card.dart';
import 'package:car_wash/utils/app_const/app_const.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SpamScreen extends StatelessWidget {
  SpamScreen({super.key});

  final WorkerHomeController workerHomeController =
      Get.find<WorkerHomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (workerHomeController.spamLoading.value) {
        case Status.loading:
          return Assets.lottie.screenLoadingAni.lottie(
            height: 100,
            width: 100,
            fit: BoxFit.contain,
          );

        case Status.internetError:
          return NoInternetScreen(
            onTap: () {
              workerHomeController.getSpamList(context: context);
            },
          );
        case Status.error:
          return GeneralErrorScreen(
            onTap: () {
              workerHomeController.getSpamList(context: context);
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
          var data = workerHomeController.spamModel.value;
          return ServiceCard(
            userLocation: LatLng(data.jobLocation?.coordinates?[1] ?? 0.0,
                data.jobLocation?.coordinates?[0] ?? 0.0),
            showButtons: false,
            showDescription: true,
            googleMap: true,
            date: DateConverter.estimatedDate(
                data.bookedDateTime ?? DateTime.now()),
            time:
                DateConverter.hourMinit(data.bookedDateTime ?? DateTime.now()),
            location: data.address ?? "",
            number: data.clientPhoneNumber ?? "",
            description: data.jobDescription ?? "",
            onTapCancle: () {},
            onTapStart: () {
              workerHomeController.startWork(
                  context: context, jobId: data.id ?? "");
            },
          );
      }
    });
  }
}
