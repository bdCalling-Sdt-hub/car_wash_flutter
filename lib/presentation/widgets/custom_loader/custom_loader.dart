import 'package:car_wash/core/custom_assets/assets.gen.dart';
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key, this.isAnimationLoader = true});

  final bool isAnimationLoader;

  @override
  Widget build(BuildContext context) {
    return isAnimationLoader
        ? Center(
            child: Assets.lottie.screenLoadingAni.lottie(
              height: 100,
              width: 100,
              fit: BoxFit.contain,
            ),
          )
        : const Center(
            child: SpinKitCircle(
              color: AppColors.primaryColor,
              size: 60.0,
            ),
          );
  }
}
