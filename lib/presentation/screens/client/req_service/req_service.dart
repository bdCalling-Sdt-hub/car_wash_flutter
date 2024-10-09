import 'package:car_wash/core/custom_assets/assets.gen.dart';
import 'package:car_wash/core/routes/route_path.dart';
import 'package:car_wash/core/routes/routes.dart';
import 'package:car_wash/global/general_controller/general_controller.dart';
import 'package:car_wash/helper/extension/base_extension.dart';
import 'package:car_wash/presentation/screens/client/client_home/controller/client_home_controller.dart';
import 'package:car_wash/presentation/screens/client/req_service/req_service_controller/req_service_controller.dart';
import 'package:car_wash/presentation/widgets/custom_button/custom_button.dart';
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/presentation/widgets/custom_text_field/custom_text_field.dart';
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:car_wash/utils/dimensions/dimensions.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

class RequestService extends StatelessWidget {
  RequestService({super.key});

  final GeneralController generalController = Get.find<GeneralController>();
  final ReqServiceController reqServiceController =
      Get.find<ReqServiceController>();

  Widget buildFloatingSearchBar({required BuildContext context}) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Obx(() {
      return Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: reqServiceController.isSearchFocused.value ? 0 : 20),
          child: FloatingSearchBar(
            //  title: const Icon(Icons.location_pin),
            onFocusChanged: (isFocused) {
              reqServiceController.places.clear();
              reqServiceController.isSearchFocused.value = isFocused;
            },
            hint: 'Search...',
            scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
            transitionDuration: const Duration(milliseconds: 800),
            transitionCurve: Curves.easeInOut,
            physics: const BouncingScrollPhysics(),
            axisAlignment: isPortrait ? 0.0 : -1.0,
            openAxisAlignment: 0.0,
            width: isPortrait ? 600 : 500,
            backgroundColor: AppColors.whiteColor,
            backdropColor: AppColors.whiteColor,
            debounceDelay: const Duration(milliseconds: 500),
          
            onQueryChanged: (searchQuery) {
              reqServiceController.places.clear();
              reqServiceController.fetchPlaceDetails(searchQuery: searchQuery);
            },
            // Specify a custom transition to be used for
            // animating between opened and closed stated.
            transition: CircularFloatingSearchBarTransition(),
            actions: [
              // FloatingSearchBarAction(
              //   showIfOpened: false,
              //   child: CircularButton(
              //     icon: const Icon(Icons.place),
              //     onPressed: () {
              //       print("object");
              //     },
              //   ),
              // ),
              FloatingSearchBarAction.searchToClear(
                showIfClosed: false,
              ),
            ],
            builder: (context, transition) {
              return Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    reqServiceController.places.length,
                    (index) {
                      return GestureDetector(
                        onTap: () {
                          // print(reqServiceController.places[index].lat);
                          // print(reqServiceController.places[index].lng);
                        },
                        child: Container(
                          padding: EdgeInsets.all(16.r),
                          child: Row(
                            children: [
                              const Icon(Icons.location_pin),
                              Expanded(
                                child: CustomText(
                                    maxLines: 2,
                                    left: 10,
                                    textAlign: TextAlign.left,
                                    text: reqServiceController
                                        .places[index].description),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              });

              // ClipRRect(
              //   borderRadius: BorderRadius.circular(8),
              //   child: Material(
              //     color: Colors.white,
              //     elevation: 4.0,
              //     child: Column(
              //       mainAxisSize: MainAxisSize.min,
              //       children: Colors.accents.map((color) {
              //         return Container(height: 112, color: color);
              //       }).toList(),
              //     ),
              //   ),
              // );
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.reqService,
          fontSize: Dimensions.getFontSizeExtraLarge(context),
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Obx(() {
        return Column(
          children: [
            if (!reqServiceController.isSearchFocused.value)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.heightWidth,
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: AppStrings.date,
                                bottom: 8.h,
                              ),

                              ///=========================== Date ===========================
                              CustomTextField(
                                textEditingController:
                                    reqServiceController.dateController.value,
                                readOnly: true,
                                onTap: () async {
                                  reqServiceController
                                          .dateController.value.text =
                                      await generalController.pickDate(context);
                                },
                                fillColor: AppColors.whiteColor,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: AppStrings.time,
                              bottom: 8.h,
                            ),

                            ///=========================== Time ===========================
                            CustomTextField(
                              textEditingController:
                                  reqServiceController.timeController.value,
                              readOnly: true,
                              onTap: () async {
                                reqServiceController.timeController.value.text =
                                    await generalController.pickTime(context);
                              },
                              fillColor: AppColors.whiteColor,
                            ),
                          ],
                        ))
                      ],
                    ),

                    CustomText(
                      top: 16.h,
                      text: AppStrings.description,
                      bottom: 8.h,
                    ),

                    ///=========================== Description ===========================
                    CustomTextField(
                      textEditingController:
                          reqServiceController.descController.value,
                      contentPadding: EdgeInsets.all(20.r),
                      maxLines: 2,
                      fillColor: AppColors.whiteColor,
                    ),

                    CustomText(
                      top: 16.h,
                      text: AppStrings.location,
                      bottom: 8.h,
                    ),
                  ],
                ),
              ),

            ///=========================== Location ===========================
            // CustomTextField(
            //   textEditingController:
            //       reqServiceController.locationController.value,
            //   fillColor: AppColors.whiteColor,
            // ),

            buildFloatingSearchBar(context: context)

            // CustomText(
            //   top: 16.h,
            //   text: AppStrings.mapView,
            //   bottom: 8.h,
            // ),

            // //// ==================== Map View =======================

            // Assets.images.mapImage.image(
            //   fit: BoxFit.cover,
            //   width: double.maxFinite,
            // ),

            // /// ==================== Req Button =====================

            // CustomButton(
            //   marginVerticel: 20.h,
            //   onTap: () {
            //     context.pushNamed(RoutePath.subscriptionPackages);
            //   },
            //   title: AppStrings.request,
            // )
          ],
        );
      }),
    );
  }
}
