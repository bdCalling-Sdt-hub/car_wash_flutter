import 'package:car_wash/core/custom_assets/assets.gen.dart';
import 'package:car_wash/global/error_screen/error_screen.dart';
import 'package:car_wash/global/general_controller/general_controller.dart';
import 'package:car_wash/global/no_internet/no_internet.dart';
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/utils/app_const/app_const.dart';
import 'package:car_wash/utils/dimensions/dimensions.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class PrivacyScreen extends StatelessWidget {
  PrivacyScreen({super.key});

  final GeneralController generalController = Get.find<GeneralController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.privacyPolicy,
          fontSize: Dimensions.getFontSizeLarge(context),
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Obx(
        () {
          switch (generalController.privacyLoading.value) {
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
                  generalController.getPrivacy(context: context);
                },
              );

            case Status.noDataFound:
              return Center(
                child: CustomText(
                  text: AppStrings.noDataFound.tr,
                  top: 40,
                ),
              );

            case Status.completed:
              return HtmlWidget(generalController.privacy.value);
          }
        },
      ),
    );
  }
}
