import 'package:car_wash/core/routes/route_path.dart';
import 'package:car_wash/presentation/screens/client/client_home/controller/client_home_controller.dart';
import 'package:car_wash/presentation/screens/client/client_home/inner/package_status.dart';
import 'package:car_wash/presentation/screens/client/client_home/inner/upcoming_service/upcoming_service.dart';
import 'package:car_wash/presentation/screens/profile/profile_controller/profile_controller.dart';
import 'package:car_wash/presentation/widgets/custom_appbar/custom_appbar.dart';
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/presentation/widgets/custom_text_field/custom_text_field.dart';
import 'package:car_wash/presentation/widgets/service_card/service_card.dart';
import 'package:car_wash/presentation/widgets/side_drawer/side_drawer.dart';
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:car_wash/utils/app_const/app_const.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClientHome extends StatelessWidget {
  ClientHome({super.key});
  final scafoldKey = GlobalKey<ScaffoldState>();

  final ClientHomeController clientHomeController =
      Get.find<ClientHomeController>();

  final ProfileController profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
          extendBody: true,
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          // floatingActionButton: FloatingActionButton(
          //   isExtended: true,

          //   onPressed: () {},
          //   child:
          // ),
          bottomNavigationBar: clientHomeController.tappedIndex.value == 0
              ? GestureDetector(
                  onTap: () {
                    context.pushNamed(RoutePath.reqService);
                  },
                  child: Container(
                    height: 60.h,
                    width: 70.w,
                    margin: EdgeInsets.only(bottom: 44.h, right: 20.w),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomText(
                          text: AppStrings.reqService,
                          right: 10,
                        ),
                        Icon(Icons.add)
                      ],
                    ),
                  ),
                )
              : null,
          drawer: SideDrawer(
            showSubscription: true,
            onTapOrderHistory: () {
              context.pushNamed(RoutePath.orderHistory);
            },
            onTapProfile: () {
              context.pushNamed(RoutePath.profile);
            },
            onTapSubscription: () {
              // context.pushNamed(RoutePath.orderHistory);
            },
          ),
          key: scafoldKey,
          appBar: AppBar(
            toolbarHeight: 0,
          ),
          body: Column(
            children: [
              ///==================== App Bar =====================

              CustomAppbar(
                  profileController: profileController,
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
                            clientHomeController.searchController.value,
                        prefixIcon: const Icon(Icons.search),
                        fillColor: AppColors.whiteColor,
                      ),
                      Gap(8.h),

                      /// ====================== Package Status =====================

                      const PackageStatus(),

                      ///=============================== Tap Bar ===========================

                      Row(
                        children: List.generate(
                          growable: false,
                          clientHomeController.tapbarItems.length,
                          (index) {
                            return Expanded(
                              child: Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      clientHomeController.tappedIndex.value =
                                          index;
                                    },
                                    icon: CustomText(
                                        fontWeight: clientHomeController
                                                    .tappedIndex.value ==
                                                index
                                            ? FontWeight.w600
                                            : FontWeight.w400,
                                        text: clientHomeController
                                            .tapbarItems[index]),
                                  ),
                                  Container(
                                    height: 4.h,
                                    color: clientHomeController
                                                .tappedIndex.value ==
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
                  )),

              ///============================= Request Status ===========================

              Obx(() {
                switch (clientHomeController.tappedIndex.value) {
                  case 0:
                    return UpcomingServiceScreen();

                  case 1:
                    return ServiceCard(
                      userLocation: const LatLng(435345, 435346),
                      showButtons: false,
                      showDescription: false,
                      showStartButton: false,
                      showCarImage: false,
                      googleMap: true,
                      date: "04-12-2024",
                      time: "10 : 00 AM",
                      location: "09 Arnulfo Crossing, Botsfordborough",
                      number: "011 2562 1569 66",
                      description:
                          "It is a long established fact that a reader will be distracted by the readable",
                      onTapCancle: () {},
                      onTapStart: () {},
                    );

                  case 2:
                    return ServiceCard(
                      showButtons: false,
                      showCarImage: false,
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
          ));
    });
  }
}
