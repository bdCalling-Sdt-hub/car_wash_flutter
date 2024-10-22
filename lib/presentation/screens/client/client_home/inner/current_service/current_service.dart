import 'package:car_wash/core/custom_assets/assets.gen.dart';
import 'package:car_wash/global/error_screen/error_screen.dart';
import 'package:car_wash/global/no_internet/no_internet.dart';
import 'package:car_wash/helper/date_time_converter/date_time_converter.dart';
import 'package:car_wash/presentation/screens/client/client_home/controller/client_home_controller.dart';
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/presentation/widgets/service_card/service_card.dart';
import 'package:car_wash/utils/app_const/app_const.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentService extends StatelessWidget {
  CurrentService({super.key});

  final ClientHomeController clientHomeController =
      Get.find<ClientHomeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (clientHomeController.currentServiceLoading.value) {
        case Status.loading:
          return Assets.lottie.screenLoadingAni.lottie(
            height: 100,
            width: 100,
            fit: BoxFit.contain,
          );

        case Status.internetError:
          return NoInternetScreen(
            onTap: () {
              clientHomeController.getCurrentServiceList();
            },
          );
        case Status.error:
          return GeneralErrorScreen(
            onTap: () {
              clientHomeController.getCurrentServiceList();
            },
          );

        case Status.noDataFound:
          return const Center(
            child: CustomText(
              text: AppStrings.noDataFound,
              top: 40,
            ),
          );

        case Status.completed:
          var data = clientHomeController.currentServiceModel.value;
          return ServiceCard(
            showStartButton: false,
            showButtons: false,
            showCarImage: false,
            googleMap: true,
            userLocation: LatLng(
                data.assignedWorker?.location?.coordinates?[1] ?? 63.6847545,
                data.assignedWorker?.location?.coordinates?[0] ?? 63.6847545),
            date: DateConverter.estimatedDate(
                data.bookedDateTime ?? DateTime.now()),
            time:
                DateConverter.hourMinit(data.bookedDateTime ?? DateTime.now()),
            location: data.address ?? "",
            number: data.assignedWorker?.phoneNumber ?? "",

            /// TODO Description is missing
            description:
                "It is a long established fact that a reader will be distracted by the readable",
            onTapCancle: () {},
            onTapStart: () {},
          );
      }
    });
  }
}