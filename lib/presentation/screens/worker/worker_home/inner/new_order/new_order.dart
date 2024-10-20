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

class NewOrderScreen extends StatelessWidget {
  NewOrderScreen({super.key});

  final WorkerHomeController workerHomeController =
      Get.find<WorkerHomeController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (workerHomeController.newOrderLoading.value) {
        case Status.loading:
          return Assets.lottie.screenLoadingAni.lottie(
            height: 100,
            width: 100,
            fit: BoxFit.contain,
          );

        case Status.internetError:
          return NoInternetScreen(
            onTap: () {
              workerHomeController.getNewOrder(context: context);
            },
          );
        case Status.error:
          return GeneralErrorScreen(
            onTap: () {
              workerHomeController.getNewOrder(context: context);
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
          return Expanded(
            child: Column(
              children: List.generate(
                workerHomeController.newOrderList.length,
                (index) {
                  var data = workerHomeController.newOrderList[index];
                  return ServiceCard(
                    date: DateConverter.estimatedDate(
                        data.bookedDateTime ?? DateTime.now()),
                    time: DateConverter.hourMinit(
                        data.bookedDateTime ?? DateTime.now()),
                    location: data.address ?? "",

                    /// TODO Change Number
                    number: "011 2562 1569 66",

                    /// TODO Change Description
                    description:
                        "It is a long established fact that a reader will be distracted by the readable",
                    onTapCancle: () {},
                    onTapStart: () {
                      debugPrint("JobID --------------->>>>>>>> ${data.id}");
                      workerHomeController.acceptWork(
                          context: context, jobId: data.id ?? "");
                    },
                  );
                },
              ),
            ),
          );
      }
    });
  }
}
