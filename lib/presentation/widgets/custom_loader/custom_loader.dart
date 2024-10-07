import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SpinKitCircle(
        color: AppColors.primaryColor,
        size: 60.0,
      ),
    );
  }
}
