import 'package:car_wash/core/custom_assets/assets.gen.dart';
import 'package:car_wash/core/routes/route_path.dart';
import 'package:car_wash/helper/network_image/network_image.dart';
import 'package:car_wash/presentation/screens/profile/profile_controller/profile_controller.dart';
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar(
      {super.key,
      required this.image,
      required this.name,
      required this.location,
      required this.onTapMenu,
      required this.onTapNotification,
      required this.profileController});

  final String image;
  final String name;
  final String location;
  final VoidCallback onTapMenu;
  final VoidCallback onTapNotification;
  final ProfileController profileController;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.whiteColor,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              /// ================== Profile Image ===================
              GestureDetector(
                onTap: () {
                  // profileController.getProfile();
                  context.pushNamed(RoutePath.profile);
                },
                child: CustomNetworkImage(
                    boxShape: BoxShape.circle,
                    imageUrl: image,
                    height: 50.r,
                    width: 50.r),
              ),

              Gap(10.w),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ======================= User Name =======================
                  CustomText(text: name),
                  Row(
                    children: [
                      Assets.icons.location.svg(),

                      /// ======================= User Location =======================
                      CustomText(text: location),
                    ],
                  )
                ],
              ),
            ],
          ),
          Row(
            children: [
              /// ================== Menu Button ==================

              IconButton(onPressed: onTapMenu, icon: Assets.icons.menu.svg()),

              /// ================== Notification Button ==================

              IconButton(
                  onPressed: onTapNotification,
                  icon: Assets.icons.notification.svg())
            ],
          )
        ],
      ),
    );
  }
}
