import 'package:car_wash/core/custom_assets/assets.gen.dart';
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(child: Assets.images.splashLogo.image()),
    );
  }
}
