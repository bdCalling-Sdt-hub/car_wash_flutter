import 'dart:io';

import 'package:car_wash/core/custom_assets/assets.gen.dart';
import 'package:car_wash/global/error_screen/error_screen.dart';
import 'package:car_wash/global/general_controller/general_controller.dart';
import 'package:car_wash/global/no_internet/no_internet.dart';
import 'package:car_wash/helper/date_time_converter/date_time_converter.dart';
import 'package:car_wash/presentation/screens/worker/worker_home/controller/worker_home.dart';
import 'package:car_wash/presentation/widgets/custom_button/custom_button.dart';
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:car_wash/utils/app_const/app_const.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class WorkEndScreen extends StatelessWidget {
  WorkEndScreen({
    super.key,
  });

  final WorkerHomeController workerHomeController =
      Get.find<WorkerHomeController>();

  final GeneralController generalController = Get.find<GeneralController>();

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
          return  Center(
            child: CustomText(
              text: AppStrings.noDataFound.tr,
              top: 40,
            ),
          );

        case Status.completed:
          var data = workerHomeController.spamModel.value;
          return Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  ///=========================== Time Schedule Design ================================
                  Container(
                    padding: EdgeInsets.all(20.r),
                    color: AppColors.greenColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                             CustomText(
                              text: AppStrings.startTime.tr,
                              fontWeight: FontWeight.w500,
                            ),

                            ///========================= Start Time =======================
                            CustomText(
                                text: DateConverter.hourMinit(
                                    data.startDateTime ?? DateTime.now())),
                          ],
                        ),
                        Assets.icons.clock.svg(),
                        Column(
                          children: [
                             CustomText(
                              text: AppStrings.endTime.tr,
                              fontWeight: FontWeight.w500,
                            ),

                            ///========================= End Time =======================
                            CustomText(
                                text: workerHomeController.endTime.value),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Gap(20.h),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       CustomText(
                        text: AppStrings.beforeCleaning.tr,
                        bottom: 10,
                      ),
                      //================ Before Cleaning Image=================

                      GestureDetector(
                        onTap: () {
                          generalController.selectImage().then((value) {
                            if (value.isNotEmpty) {
                              workerHomeController.afterCleaningImgPath.value =
                                  value;
                            }
                          });
                        },
                        child: Container(
                          height: 200.h,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: AppColors.blackLightColor,
                          )),
                          child:
                              workerHomeController.afterCleaningImgPath.isEmpty
                                  ? Icon(
                                      Icons.image,
                                      size: 60.r,
                                    )
                                  : Image.file(
                                      fit: BoxFit.cover,
                                      File(workerHomeController
                                          .afterCleaningImgPath.value)),
                        ),
                      )
                    ],
                  ),

                  Gap(20.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       CustomText(
                        text: AppStrings.afterCleaning.tr,
                        bottom: 10,
                      ),

                      //================ After Cleaning Image=================

                      GestureDetector(
                        onTap: () {
                          generalController.selectImage().then((value) {
                            if (value.isNotEmpty) {
                              workerHomeController.beforeCleaningImgPath.value =
                                  value;
                            }
                          });
                        },
                        child: Container(
                          height: 200.h,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: AppColors.blackLightColor,
                          )),
                          child:
                              workerHomeController.beforeCleaningImgPath.isEmpty
                                  ? Icon(
                                      Icons.image,
                                      size: 60.r,
                                    )
                                  : Image.file(
                                      fit: BoxFit.cover,
                                      File(workerHomeController
                                          .beforeCleaningImgPath.value)),
                        ),
                      )

                      // CustomNetworkImage(
                      //     imageUrl: AppConstants.carClean,
                      //     height: 200.h,
                      //     width: double.maxFinite)
                    ],
                  ),

                  //=========================== End Work ==========================
                  workerHomeController.isworkEnd.value
                      ? Align(
                          alignment: Alignment.center,
                          child: Assets.lottie.loading.lottie(
                              width: context.width / 6, fit: BoxFit.cover),
                        )
                      : CustomButton(
                          marginVerticel: 24.h,
                          onTap: () {
                            workerHomeController.endWork(
                                jobId: data.id ?? "", context: context);
                          },
                          title: AppStrings.endWork.tr,
                        )
                ],
              ),
            ),
          );
      }
    });
  }
}
