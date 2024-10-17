import 'package:car_wash/core/routes/route_path.dart';
import 'package:car_wash/presentation/screens/client/subscription/controller/subscription_controller.dart';
import 'package:car_wash/presentation/screens/client/subscription/model/subscription_packages_model.dart';
import 'package:car_wash/presentation/widgets/custom_button/custom_button.dart';
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:car_wash/utils/dimensions/dimensions.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class PackageCard extends StatelessWidget {
  PackageCard({
    super.key,
    this.serviceID = "",
    this.price = "",
    required this.title,
    required this.description,
    required this.serviceList,
    required this.color,
    required this.packageId, // Add package ID
    this.showBuyButton = true,
  });

  final String serviceID;
  final String price;

  final String title;
  final Color color;
  final String packageId; // The unique ID of the package
  final bool showBuyButton;
  final String description;
  final List<Service> serviceList;

  final SubscriptionController subscriptionController =
      Get.find<SubscriptionController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: EdgeInsets.all(20.r),
        margin: EdgeInsets.only(bottom: 20.h),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(8.r)),
        child: Column(
          children: [
            // Package Price
            CustomText(
              fontSize: Dimensions.getButtonFontSizeLarge(context),
              text: price.isNotEmpty
                  ? price
                  : subscriptionController.selectedPackageId.value == serviceID
                      ? "¥${subscriptionController.selectedMoney}"
                      : "¥00",
              fontWeight: FontWeight.w600,
            ),

            // Package Title
            CustomText(
              fontSize: Dimensions.getFontSizeLarge(context),
              text: title,
              fontWeight: FontWeight.w600,
              bottom: 10.h,
            ),

            // Package Description
            CustomText(
              maxLines: 2,
              text: description,
              fontWeight: FontWeight.w500,
              bottom: 10.h,
            ),

            // Service List with Checkbox
            ...List.generate(
              serviceList.length,
              (index) {
                var service = serviceList[index];

                bool isSelected =
                    subscriptionController.selectedService.value == service &&
                        subscriptionController.selectedPackageId.value ==
                            packageId;
                return Row(
                  children: [
                    Checkbox(
                      activeColor: AppColors.primaryColor,
                      value: isSelected,
                      onChanged: (value) {
                        // When a service is selected, update the controller
                        if (value ?? false) {
                          subscriptionController.selectService(
                              service, packageId);

                          subscriptionController.selectedMoney.refresh();
                        }
                      },
                    ),
                    CustomText(text: service.serviceName ?? "")
                  ],
                );
              },
            ),

            // Buy Now Button
            if (showBuyButton &&
                subscriptionController.selectedPackageId.value == serviceID)
              CustomButton(
                marginVerticel: 10.h,
                fillColor: AppColors.whiteColor,
                onTap: () {
                  context.pushNamed(RoutePath.coupon,
                      extra: subscriptionController.selectedMoney.value);
                },
                title: AppStrings.buyNow,
              )
          ],
        ),
      );
    });
  }
}
