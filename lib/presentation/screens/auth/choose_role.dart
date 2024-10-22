import 'package:car_wash/core/custom_assets/assets.gen.dart';
import 'package:car_wash/core/routes/route_path.dart';
import 'package:car_wash/presentation/screens/auth/controller/auth_controller.dart';
import 'package:car_wash/presentation/widgets/custom_button/custom_button.dart';
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ChooseRole extends StatelessWidget {
  ChooseRole({super.key});

  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greenColor,
      ),
      body: Scaffold(
        backgroundColor: AppColors.greenColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Assets.images.chooseRole.image(),

              /// =================== Client Sign In Button ======================

              CustomButton(
                onTap: () {
                  authController.isClient.value = true;
                  context.pushNamed(RoutePath.login);
                },
                title: AppStrings.signInAsClient.tr,
              ),

              /// =================== Worker Sign In Button ======================

              CustomButton(
                marginVerticel: 20,
                onTap: () {
                  authController.isClient.value = false;
                  context.pushNamed(RoutePath.login);
                },
                title: AppStrings.signInAsWorker.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
