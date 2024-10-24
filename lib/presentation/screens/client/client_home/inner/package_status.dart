import 'package:car_wash/core/routes/route_path.dart';
import 'package:car_wash/presentation/screens/client/subscription/controller/subscription_controller.dart';
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:car_wash/utils/app_const/app_const.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class PackageStatus extends StatelessWidget {
  PackageStatus({super.key});

  final SubscriptionController subscriptionController =
      Get.find<SubscriptionController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SizedBox(
        child: subscriptionController.mySubscriptionLoading.value ==
                Status.completed
            ? SubscriptionInfo(
                packageName: subscriptionController
                        .myPackageModel.value.data?.service?.serviceName ??
                    "",
                availableService: subscriptionController.myPackageModel.value
                        .data?.subscription?.availableService ??
                    0,
                totalService: subscriptionController.myPackageModel.value.data
                        ?.subscription?.totalService ??
                    0,
              )
            : GestureDetector(
                onTap: () {
                  context.pushNamed(RoutePath.subscriptionPackages);
                },
                child: Container(
                  padding: EdgeInsets.all(20.sp),
                  color: AppColors.primaryColor.withOpacity(.1),
                  child: CustomText(text: AppStrings.subscribeToGetStarted.tr),
                ),
              ),
      );
    });
  }
}

class SubscriptionInfo extends StatelessWidget {
  const SubscriptionInfo({
    super.key,
    required this.packageName,
    required this.totalService,
    required this.availableService,
  });

  final String packageName;
  final int totalService;
  final int availableService;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.sp),
      color: AppColors.primaryColor.withOpacity(.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// ==================== Package Name ================
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: AppStrings.package.tr),
                CustomText(
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  text: packageName,
                  color: AppColors.greenColor,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),

          /// ==================== Total Package ================
          Column(
            children: [
              CustomText(text: AppStrings.total.tr),
              CustomText(
                text: totalService.toString(),
                color: AppColors.greenColor,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),

          /// ==================== Taken Service ================
          Column(
            children: [
              CustomText(text: AppStrings.taken.tr),
              CustomText(
                text: (totalService - availableService).toString(),
                color: AppColors.greenColor,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),

          /// ==================== Remain Service ================
          Column(
            children: [
              CustomText(text: AppStrings.remains.tr),
              CustomText(
                text: availableService.toString(),
                color: AppColors.greenColor,
                fontWeight: FontWeight.w500,
              ),
            ],
          )
        ],
      ),
    );
  }
}
