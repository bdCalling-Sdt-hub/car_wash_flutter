import 'package:car_wash/core/routes/route_path.dart';
import 'package:car_wash/presentation/screens/worker/worker_home/controller/worker_home.dart';
import 'package:car_wash/presentation/screens/worker/worker_home/inner/work_start.dart';
import 'package:car_wash/presentation/widgets/custom_appbar/custom_appbar.dart';
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/presentation/widgets/custom_text_field/custom_text_field.dart';
import 'package:car_wash/presentation/widgets/service_card/service_card.dart';
import 'package:car_wash/presentation/widgets/side_drawer/side_drawer.dart';
import 'package:car_wash/utils/app_const/app_const.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class WorkerHome extends StatelessWidget {
  WorkerHome({super.key});

  final WorkerHomeController workerHomeController =
      Get.find<WorkerHomeController>();

  final scafoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(
        onTapOrderHistory: () {
          context.pushNamed(RoutePath.orderHistory);
        },
        onTapProfile: () {
          context.pushNamed(RoutePath.workerProfile);
        },
        onTapSubscription: () {
          // context.pushNamed(RoutePath.orderHistory);
        },
      ),
      key: scafoldKey,
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Obx(() {
        return Column(
          children: [
            ///==================== App Bar =====================

            CustomAppbar(
                image: AppConstants.onlineImage,
                name: "Fatma",
                location: "Soudi Arab",
                onTapMenu: () {
                  scafoldKey.currentState?.openDrawer();
                },
                onTapNotification: () {
                  context.pushNamed(RoutePath.workerNotification);
                }),

            /// =================== Rest of the Body ===================
            Gap(20.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  /// ======================== Search Bar ========================

                  CustomTextField(
                    hintText: AppStrings.searchhere,
                    textEditingController:
                        workerHomeController.searchController.value,
                    prefixIcon: const Icon(Icons.search),
                    fillColor: AppColors.whiteColor,
                  ),
                  Gap(8.h),

                  ///=============================== Tap Bar ===========================

                  Row(
                    children: List.generate(
                      growable: false,
                      workerHomeController.tapbarItems.length,
                      (index) {
                        return Expanded(
                          child: Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  workerHomeController.tappedIndex.value =
                                      index;
                                },
                                icon: CustomText(
                                    fontWeight: workerHomeController
                                                .tappedIndex.value ==
                                            index
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                    text: workerHomeController
                                        .tapbarItems[index]),
                              ),
                              Container(
                                height: 4.h,
                                color: workerHomeController.tappedIndex.value ==
                                        index
                                    ? AppColors.greenColor
                                    : AppColors.grayColor,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Gap(16.h),
                ],
              ),
            ),

            ///============================= Request Status ===========================

            Obx(() {
              switch (workerHomeController.tappedIndex.value) {
                case 0:
                  return ServiceCard(
                    date: "04-12-2024",
                    time: "10 : 00 AM",
                    location: "09 Arnulfo Crossing, Botsfordborough",
                    number: "011 2562 1569 66",
                    description:
                        "It is a long established fact that a reader will be distracted by the readable",
                    onTapCancle: () {},
                    onTapStart: () {},
                  );

                case 1:
                  // return ServiceCard(
                  //   showButtons: false,
                  //   showDescription: false,
                  //   googleMap: true,
                  //   date: "04-12-2024",
                  //   time: "10 : 00 AM",
                  //   location: "09 Arnulfo Crossing, Botsfordborough",
                  //   number: "011 2562 1569 66",
                  //   description:
                  //       "It is a long established fact that a reader will be distracted by the readable",
                  //   onTapCancle: () {},
                  //   onTapStart: () {},
                  // );

                  return WorkStartScreen(
                      startTime: "10:00AM",
                      endTime: "11:00AM",
                      beforeCleaningImg: AppConstants.carDarty,
                      afterCleaningImg: AppConstants.carClean);

                case 2:
                  return ServiceCard(
                    showButtons: false,
                    showCarImage: true,
                    date: "04-12-2024",
                    time: "10 : 00 AM",
                    location: "09 Arnulfo Crossing, Botsfordborough",
                    number: "011 2562 1569 66",
                    description:
                        "It is a long established fact that a reader will be distracted by the readable",
                    onTapCancle: () {},
                    onTapStart: () {},
                  );

                default:
                  return const SizedBox();
              }
            })
          ],
        );
      }),
    );
  }
}
