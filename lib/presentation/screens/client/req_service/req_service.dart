import 'package:car_wash/core/custom_assets/assets.gen.dart';
import 'package:car_wash/core/routes/route_path.dart';
import 'package:car_wash/global/general_controller/general_controller.dart';
import 'package:car_wash/presentation/screens/client/client_home/controller/client_home_controller.dart';
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

class RequestService extends StatelessWidget {
  RequestService({super.key});

  final GeneralController generalController = Get.find<GeneralController>();
  final ClientHomeController clientHomeController =
      Get.find<ClientHomeController>();
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
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                        readOnly: true,
                        onTap: () {
                          generalController.pickDate(context);
                        },
                        fillColor: AppColors.whiteColor,
                      ),
                    ],
                  ),
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
                      readOnly: true,
                      onTap: () {
                        generalController.pickTime(context);
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
            const CustomTextField(
              fillColor: AppColors.whiteColor,
            ),

            CustomText(
              top: 16.h,
              text: AppStrings.location,
              bottom: 8.h,
            ),

            ///=========================== Description ===========================
            const CustomTextField(
              fillColor: AppColors.whiteColor,
            ),

            CustomText(
              top: 16.h,
              text: AppStrings.mapView,
              bottom: 8.h,
            ),

            //// ==================== Map View =======================

            Assets.images.mapImage.image(
              fit: BoxFit.cover,
              width: double.maxFinite,
            ),

            CustomButton(
              marginVerticel: 20.h,
              onTap: () {
                context.pushNamed(RoutePath.subscriptionPackages);
              },
              title: AppStrings.request,
            )
          ],
        ),
      ),
    );
  }
}
