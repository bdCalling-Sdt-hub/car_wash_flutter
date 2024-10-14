import 'dart:async';

import 'package:car_wash/global/general_controller/general_controller.dart';
import 'package:car_wash/helper/extension/base_extension.dart';
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
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

// ignore: must_be_immutable
class RequestService extends StatelessWidget {
  RequestService({super.key});

  final GeneralController generalController = Get.find<GeneralController>();
  final ReqServiceController reqServiceController =
      Get.find<ReqServiceController>();

  FloatingSearchBarController floatingSearchBarController =
      FloatingSearchBarController();

  Widget buildFloatingSearchBar({required BuildContext context}) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Obx(() {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: reqServiceController.isSearchFocused.value ? 0 : 20),
        child: FloatingSearchBar(
          controller: floatingSearchBarController, // Set the controller
          onFocusChanged: (isFocused) {
            reqServiceController.places.clear();
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

            if (searchQuery.isNotEmpty) {
              reqServiceController.fetchPlaceDetails(searchQuery: searchQuery);
            }
          },

          transition: CircularFloatingSearchBarTransition(),
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
                        reqServiceController.locationController.value.text =
                            reqServiceController.places[index].description ??
                                "";
                        reqServiceController.sourceLocation.value = LatLng(
                            reqServiceController.places[index].lat,
                            reqServiceController.places[index].lng);

                        reqServiceController.sourceLocation.refresh();
                        // Close the search bar when a result is tapped
                        reqServiceController.changeCameraPosition();
                        floatingSearchBarController.close();

                        debugPrint(
                            "Selected Location ----------->>>> ${reqServiceController.places[index].description}");
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
                                        .places[index].description ??
                                    "",
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            });
          },
        ),
      );
    });
  }

  //LatLng sourceLocation = const LatLng(23.7599042, 90.410031);
  //LatLng currentLocation = const LatLng(23.7699042, 90.400931);

  final formKey = GlobalKey<FormState>();

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
        return PopScope(
          canPop: !reqServiceController.isSearchFocused.value,
          onPopInvokedWithResult: (didPop, result) {
            if (reqServiceController.mapController.value.isCompleted) {
              reqServiceController.mapController.value = Completer();
              reqServiceController.mapController.value.future
                  .then((controller) => controller.dispose());
            }

            if (reqServiceController.isSearchFocused.value) {
              reqServiceController.isSearchFocused.value = false;
            } else {
              navigator?.pop();
            }
          },
          child: Obx(() {
            return reqServiceController.isSearchFocused.value
                ? Stack(
                    fit: StackFit.expand,
                    clipBehavior: Clip.none,
                    children: [
                      ////// ==================== Map View =======================

                      Obx(() {
                        return GoogleMap(
                          onMapCreated: (controller) {
                            reqServiceController.mapController.value
                                .complete(controller);
                          },
                          zoomGesturesEnabled: true,
                          zoomControlsEnabled: true,
                          myLocationEnabled: true,
                          markers: {
                            Marker(
                              markerId: const MarkerId("_sourceLocation"),
                              icon: BitmapDescriptor.defaultMarker,
                              position:
                                  reqServiceController.sourceLocation.value,
                            ),
                          },
                          initialCameraPosition:
                              reqServiceController.cameraPosition.value,
                        );
                      }),

                      buildFloatingSearchBar(context: context),

                      // Positioned(
                      //     right: 30,
                      //     bottom: 30,
                      //     child: FloatingActionButton(onPressed: () {}))
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          if (!reqServiceController.isSearchFocused.value)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                20.heightWidth,
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text: AppStrings.date,
                                            bottom: 8.h,
                                          ),

                                          ///=========================== Date ===========================
                                          CustomTextField(
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return AppStrings
                                                    .fieldCantNotBeEmpty;
                                              }

                                              return null;
                                            },
                                            textEditingController:
                                                reqServiceController
                                                    .dateController.value,
                                            readOnly: true,
                                            onTap: () async {
                                              reqServiceController
                                                      .dateController
                                                      .value
                                                      .text =
                                                  await generalController
                                                      .pickDate(context);
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: AppStrings.time,
                                          bottom: 8.h,
                                        ),

                                        ///=========================== Time ===========================
                                        CustomTextField(
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return AppStrings
                                                  .fieldCantNotBeEmpty;
                                            }

                                            return null;
                                          },
                                          textEditingController:
                                              reqServiceController
                                                  .timeController.value,
                                          readOnly: true,
                                          onTap: () async {
                                            reqServiceController
                                                    .timeController.value.text =
                                                await generalController
                                                    .pickTime(context);
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
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return AppStrings.fieldCantNotBeEmpty;
                                    }

                                    return null;
                                  },
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

                          ///=========================== Location ===========================
                          CustomTextField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return AppStrings.fieldCantNotBeEmpty;
                              }

                              return null;
                            },
                            onTap: () {
                              reqServiceController.isSearchFocused.value = true;
                            },
                            textEditingController:
                                reqServiceController.locationController.value,
                            fillColor: AppColors.whiteColor,
                          ),

                          /// ==================== Req Button =====================

                          if (reqServiceController
                              .locationController.value.text.isNotEmpty)
                            CustomButton(
                              marginVerticel: 40.h,
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  reqServiceController.sendServiceRequest(
                                      context: context);
                                }
                              },
                              title: AppStrings.request,
                            )
                        ],
                      ),
                    ),
                  );
          }),
        );
      }),
    );
  }
}
