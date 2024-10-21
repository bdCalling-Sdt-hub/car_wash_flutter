import 'package:car_wash/helper/network_image/network_image.dart';
import 'package:car_wash/presentation/widgets/custom_button/custom_button.dart';
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:car_wash/utils/app_const/app_const.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard(
      {super.key,
      required this.date,
      required this.location,
      required this.number,
      required this.description,
      this.showButtons = true,
      required this.onTapCancle,
      required this.onTapStart,
      this.showStatus = false,
      this.showDescription = true,
      required this.time,
      this.googleMap = false,
      this.userLocation,
      this.showCarImage = false,
      this.showStartButton = true});

  final String date;
  final String time;
  final String location;
  final String number;
  final String description;
  final bool showButtons;
  final VoidCallback onTapCancle;
  final VoidCallback onTapStart;
  final bool showStatus;
  final bool showDescription;
  final bool googleMap;
  final bool showCarImage;
  final bool showStartButton;

  final LatLng? userLocation;

  @override
  Widget build(BuildContext context) {
    var container = Container(
      margin: EdgeInsets.only(bottom: 16.h, left: 20.w, right: 20.w),
      padding: EdgeInsets.all(20.r),
      color: AppColors.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: AppColors.greenColor.withOpacity(.2)),
                padding: EdgeInsets.all(8.r),
                child: const CustomText(text: AppStrings.carWashingService),
              ),

              //============================ Date Field for History ===========================

              if (showCarImage) CustomText(text: "${AppStrings.date} $date")
            ],
          ),
          Gap(16.h),
          showCarImage
              ? const CustomText(text: "${AppStrings.workingTime} 2 h 50 min")
              : Row(
                  children: [
                    const CustomText(text: AppStrings.date),

                    ///===================== Date ====================
                    Expanded(
                        child: CustomText(
                      text: date,
                      textAlign: TextAlign.left,
                    )),

                    CustomText(left: 20.w, text: AppStrings.time),

                    ///===================== Time ====================
                    Expanded(
                      child: CustomText(
                        textAlign: TextAlign.left,
                        text: time,
                      ),
                    ),
                  ],
                ),
          Gap(16.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///===================== Location ====================
              const CustomText(text: AppStrings.location), Gap(10.w),

              Expanded(
                  child: CustomText(
                textAlign: TextAlign.left,
                text: location,
                maxLines: 2,
              )),
            ],
          ),
          Gap(16.h),
          Row(
            children: [
              ///===================== Contact Number ====================
              const CustomText(text: AppStrings.contactNumber),

              Expanded(
                  child: CustomText(
                textAlign: TextAlign.left,
                text: number,
                maxLines: 2,
              )),
            ],
          ),

          if (showDescription == true) ...[
            Gap(16.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///===================== Description ====================
                const CustomText(text: AppStrings.description),

                Expanded(
                    child: CustomText(
                  textAlign: TextAlign.left,
                  text: description,
                  maxLines: 8,
                )),
              ],
            ),
          ],

          /// ======================= Buttons ======================

          if (showButtons == true)
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
              child: Row(
                children: [
                  /// ====================== Cancel Button =======================

                  Expanded(
                      child: CustomButton(
                    borderColor: AppColors.blackLightColor,
                    title: AppStrings.cancel,
                    onTap: onTapCancle,
                    fillColor: AppColors.whiteColor,
                  )),
                  SizedBox(
                    width: 10.w,
                  ),

                  /// ====================== Start Button =======================

                  Expanded(
                      child: CustomButton(
                          title: AppStrings.start, onTap: onTapStart)),
                ],
              ),
            ),

          ///======================= Car Image ========================
          if (showCarImage) ...[
            Gap(16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const CustomText(
                      text: AppStrings.beforeCleaning,
                      bottom: 10,
                    ),
                    //================ Before Cleaning Image=================

                    CustomNetworkImage(
                        imageUrl: AppConstants.carDarty,
                        height: 80.h,
                        width: 130.w)
                  ],
                ),
                Column(
                  children: [
                    const CustomText(
                      text: AppStrings.afterCleaning,
                      bottom: 10,
                    ),
                    //================ Before Cleaning Image=================

                    CustomNetworkImage(
                        imageUrl: AppConstants.carClean,
                        height: 80.h,
                        width: 130.w)
                  ],
                )
              ],
            )
          ]
        ],
      ),
    );

    return Expanded(
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: googleMap
              ? Column(
                  children: [
                    container,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          // Assets.images.mapImage.image(
                          //     width: double.maxFinite, fit: BoxFit.cover),

                          /// ======================= User Location =====================

                          SizedBox(
                            height: 500,
                            child: GoogleMap(
                              zoomGesturesEnabled: true,
                              zoomControlsEnabled: true,
                              myLocationEnabled: true,
                              markers: {
                                Marker(
                                  markerId: const MarkerId("_workLocation"),
                                  icon: BitmapDescriptor.defaultMarker,
                                  position: userLocation!,
                                ),
                              },
                              initialCameraPosition: CameraPosition(
                                  target: userLocation!, zoom: 13),
                            ),
                          ),
                          Gap(20.h),
                          if (showStartButton)
                            CustomButton(
                              onTap: onTapStart,
                              title: AppStrings.startWork,
                            ),
                          Gap(44.h)
                        ],
                      ),
                    )
                  ],
                )
              : container),
    );
  }
}

class SingleServiceCard extends StatelessWidget {
  const SingleServiceCard(
      {super.key,
      required this.date,
      required this.time,
      required this.onTapCancel});

  final String date;
  final String time;
  final VoidCallback onTapCancel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
      padding: EdgeInsets.all(10.r),
      color: AppColors.whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ///========================= Date =====================
          Column(
            children: [
              const CustomText(text: AppStrings.nextDate),
              CustomText(text: date),
            ],
          ),

          ///========================= Time =====================
          Column(
            children: [
              const CustomText(text: AppStrings.time),
              CustomText(text: time),
            ],
          ),

          InkWell(
            onTap: onTapCancel,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.redColor,
                  borderRadius: BorderRadius.circular(6.r)),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: const CustomText(
                text: AppStrings.cancel,
                color: AppColors.whiteColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
