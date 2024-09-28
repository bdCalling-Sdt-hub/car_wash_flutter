import 'package:car_wash/presentation/widgets/custom_button/custom_button.dart';
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:car_wash/utils/dimensions/dimensions.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PackageCard extends StatelessWidget {
  const PackageCard(
      {super.key,
      required this.price,
      required this.title,
      required this.description,
      required this.serviceList,
      required this.color,
       this.showBuyButton = true});

  final String price;
  final String title;
  final Color color;
  final bool showBuyButton;
  final String description;
  final List<String> serviceList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8.r)),
      child: Column(
        children: [
          /// ==================== Package Price ====================
          CustomText(
            fontSize: Dimensions.getButtonFontSizeLarge(context),
            text: price,
            fontWeight: FontWeight.w600,
          ),

          /// ==================== Package Title ====================

          CustomText(
            fontSize: Dimensions.getFontSizeLarge(context),
            text: title,
            fontWeight: FontWeight.w600,
            bottom: 10.h,
          ),

          /// ==================== Package Description ====================

          CustomText(
            maxLines: 2,
            text: description,
            fontWeight: FontWeight.w500,
            bottom: 10.h,
          ),

          /// ==================== Feature List ====================

          ...List.generate(
            serviceList.length,
            (index) {
              return Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (value) {},
                  ),
                  CustomText(text: serviceList[index])
                ],
              );
            },
          ),

         if(showBuyButton) CustomButton(
            marginVerticel: 10.h,
            fillColor: AppColors.whiteColor,
            onTap: () {},
            title: AppStrings.buyNow,
          )
        ],
      ),
    );
  }
}
