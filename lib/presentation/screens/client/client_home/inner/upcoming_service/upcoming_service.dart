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

class UpcomingServiceScreen extends StatelessWidget {
  UpcomingServiceScreen({super.key});

  final ClientHomeController clientHomeController =
      Get.find<ClientHomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (clientHomeController.upComingLoading.value) {
        case Status.loading:
          return Assets.lottie.screenLoadingAni.lottie(
            height: 100,
            width: 100,
            fit: BoxFit.contain,
          );

        /// TODO FIX NO INTERNET AND GENERAL ERROR SCREEN
        case Status.internetError:
          return NoInternetScreen(
            onTap: () {
              //  clientHomeController.getUpComingService(context: context);
            },
          );
        case Status.error:
          return GeneralErrorScreen(
            onTap: () {
              clientHomeController.getUpComingService(context: context);
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
          return Column(
            children: List.generate(
              clientHomeController.upcomingModel.value.upcoming?.length ?? 0,
              (index) {
                return SingleServiceCard(
                  date: DateConverter.estimatedDate(clientHomeController
                          .upcomingModel
                          .value
                          .upcoming?[index]
                          .bookedDateTime ??
                      DateTime.now()),
                  time: DateConverter.hourMinit(clientHomeController
                          .upcomingModel
                          .value
                          .upcoming?[index]
                          .bookedDateTime ??
                      DateTime.now()),
                  onTapCancel: () {},
                );
              },
            ),
          );
      }
    });
 
 
 
  }
}
