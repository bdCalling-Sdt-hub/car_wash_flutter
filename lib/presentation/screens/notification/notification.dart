import 'package:car_wash/core/custom_assets/assets.gen.dart';
import 'package:car_wash/global/error_screen/error_screen.dart';
import 'package:car_wash/global/general_controller/general_controller.dart';
import 'package:car_wash/global/no_internet/no_internet.dart';
import 'package:car_wash/helper/date_time_converter/date_time_converter.dart';
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/presentation/widgets/notification_card/notification_card.dart';
import 'package:car_wash/utils/app_const/app_const.dart';
import 'package:car_wash/utils/dimensions/dimensions.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final GeneralController generalController = Get.find<GeneralController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: AppStrings.notification,
            fontSize: Dimensions.getFontSizeExtraLarge(context),
            fontWeight: FontWeight.w500,
          ),
        ),
        body: Obx(() {
          switch (generalController.notificationLoading.value) {
            case Status.loading:
              return Assets.lottie.screenLoadingAni.lottie(
                height: 100,
                width: 100,
                fit: BoxFit.contain,
              );

            case Status.internetError:
              return NoInternetScreen(
                onTap: () {
                  generalController.getNotification(context: context);
                },
              );
            case Status.error:
              return GeneralErrorScreen(
                onTap: () {
                  generalController.getNotification(context: context);
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  /// ========================== Read All Button =======================

                  IconButton(
                      onPressed: () {
                        generalController.readAllNotification(context: context);
                      },
                      icon:  CustomText(text: AppStrings.readAll.tr)),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        generalController.notificationList.length,
                        (index) {
                          var data = generalController.notificationList[index];
                          return NotificationCard(
                              isRead: data.isRead ?? false,
                              title: data.title ?? "",
                              subTitle: data.message ?? "",
                              createdAt: DateConverter.formatTimeAgo(
                                  data.createdAt ??
                                      "2024-10-21T08:51:35.025Z"));
                        },
                      ),
                    ),
                  ))
                ],
              );
          }
        }));
  }
}
