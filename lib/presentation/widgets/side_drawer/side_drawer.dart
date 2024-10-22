import 'package:car_wash/core/custom_assets/assets.gen.dart';
import 'package:car_wash/core/routes/route_path.dart';
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/utils/dimensions/dimensions.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer(
      {super.key,
      required this.onTapProfile,
      required this.onTapOrderHistory,
      required this.onTapSubscription,
      this.showSubscription = false});
  final VoidCallback onTapProfile;
  final VoidCallback onTapOrderHistory;
  final VoidCallback onTapSubscription;
  final bool showSubscription;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ///========================== Logo ========================

          Container(
            color: AppColors.primaryColor,
            padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
            width: double.maxFinite,
            height: 150.h,
            child: Assets.images.splashLogo.image(),
          ),
          Gap(8.h),

          //======================= Profile ==========================
          IconButton(
              onPressed: onTapProfile,
              icon: Row(
                children: [
                  Assets.icons.profile.svg(),
                  CustomText(
                    text: AppStrings.profile.tr,
                    left: 20.w,
                    fontSize: Dimensions.getFontSizeLarge(context),
                  )
                ],
              )),
          const Divider(),

          //========================== Oder History ==========================
          IconButton(
              onPressed: onTapOrderHistory,
              icon: Row(
                children: [
                  Assets.icons.history.svg(),
                  CustomText(
                    text: AppStrings.orderHistory.tr,
                    left: 20.w,
                    fontSize: Dimensions.getFontSizeLarge(context),
                  )
                ],
              )),
          const Divider(),

          //======================= My Subscription ==========================

          if (showSubscription) ...[
            IconButton(
                onPressed: () {
                  context.pushNamed(RoutePath.mySubscription);
                },
                icon: Row(
                  children: [
                    Assets.icons.subscription.svg(),
                    CustomText(
                      text: AppStrings.mySubscription.tr,
                      left: 20.w,
                      fontSize: Dimensions.getFontSizeLarge(context),
                    )
                  ],
                )),
            const Divider(),

            //======================= Subscription Packages ==========================

            IconButton(
                onPressed: () {
                  context.pushNamed(RoutePath.subscriptionPackages);
                },
                icon: Row(
                  children: [
                    Assets.icons.subscription.svg(),
                    CustomText(
                      text: AppStrings.subscriptionPackages.tr,
                      left: 20.w,
                      fontSize: Dimensions.getFontSizeLarge(context),
                    )
                  ],
                )),
            const Divider(),
          ],

          //========================== Language ==========================
          IconButton(
              onPressed: () {
                context.pushNamed(RoutePath.language);
              },
              icon: Row(
                children: [
                  const Icon(Icons.language_sharp),
                  CustomText(
                    text: AppStrings.language.tr,
                    left: 20.w,
                    fontSize: Dimensions.getFontSizeLarge(context),
                  )
                ],
              )),
          const Divider(),

          const Expanded(child: SizedBox()),

          ///========================= Log Out Button =========================

          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      context.pushReplacementNamed(RoutePath.chooseRole);
                    },
                    icon: Row(
                      children: [
                        Assets.icons.logout.svg(),
                        CustomText(
                          text: AppStrings.logOut.tr,
                          left: 20.w,
                          fontSize: Dimensions.getFontSizeLarge(context),
                        )
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
