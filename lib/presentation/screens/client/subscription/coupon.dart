import 'package:car_wash/helper/extension/base_extension.dart';
import 'package:car_wash/presentation/screens/client/subscription/controller/subscription_controller.dart';
import 'package:car_wash/presentation/widgets/custom_button/custom_button.dart';
import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/presentation/widgets/custom_text_field/custom_text_field.dart';
import 'package:car_wash/scret_key.dart';
import 'package:car_wash/utils/app_colors/app_colors.dart';
import 'package:car_wash/utils/dimensions/dimensions.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pay/pay.dart';

class CouponScreen extends StatelessWidget {
  CouponScreen({super.key, required this.price});

  final int price;
  final SubscriptionController subscriptionController =
      Get.find<SubscriptionController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.couponCode,
          fontSize: Dimensions.getFontSizeExtraLarge(context),
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Obx(() {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              /// =========================== Text Editing Field ==========================
              24.heightWidth,
              CustomTextField(
                textEditingController:
                    subscriptionController.couponCodeTextfield.value,
                textInputAction: TextInputAction.done,
                hintText: AppStrings.enterYourCouponCode,
                fillColor: AppColors.primaryColor.withOpacity(0.3),
              ),
              20.heightWidth,

              /// ========================== Apply Coupon =======================

              IconButton(
                onPressed: () {
                  subscriptionController.applyCouponCode(context: context);
                },
                icon: const CustomText(text: AppStrings.applyCouponCodeAndPay),
              ),

              if (subscriptionController.discount.value != 0) ...[
                CustomText(
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    top: 24.h,
                    bottom: 24.h,
                    text:
                        "You will get ${subscriptionController.discount}% discount with this coupon"),

                /// ========================== Remove Coupon =======================

                IconButton(
                    onPressed: () {
                      subscriptionController.discount.value = 0;
                      subscriptionController.discount.refresh();
                    },
                    icon: const CustomText(
                      text: "Remove Coupon",
                      fontWeight: FontWeight.w500,
                    ))
              ],

              const Expanded(child: SizedBox()),

              ...[
                CustomText(
                  bottom: 20.h,
                  text: subscriptionController.discount.value == 0
                      ? "Total Price: \$$price"
                      : "Total Price: \$$price after discount \$${subscriptionController.calculateDiscountedPrice(amount: price, discountPercentage: subscriptionController.discount.value)}",
                  fontWeight: FontWeight.w600,
                  fontSize: Dimensions.getFontSizeDefault(context),
                ),

                // CustomButton(
                //   onTap: () {
                //     subscriptionController.applePay(
                //         context: context,
                //         finalPrice: subscriptionController.discount.value == 0
                //             ? price.toString()
                //             : subscriptionController
                //                 .calculateDiscountedPrice(
                //                     amount: price,
                //                     discountPercentage:
                //                         subscriptionController.discount.value)
                //                 .toString());
                //   },
                //   title: subscriptionController.discount.value == 0
                //       ? "${AppStrings.confirmPayment} \$$price"
                //       : "${AppStrings.confirmPayment} \$${subscriptionController.calculateDiscountedPrice(amount: price, discountPercentage: subscriptionController.discount.value)}",
                // ),

                ApplePayButton(
                  paymentConfiguration:
                      PaymentConfiguration.fromJsonString(defaultApplePay),
                  paymentItems: [
                    PaymentItem(
                      label: 'Total',
                      amount: subscriptionController.discount.value == 0
                          ? price.toString()
                          : subscriptionController
                              .calculateDiscountedPrice(
                                  amount: price,
                                  discountPercentage:
                                      subscriptionController.discount.value)
                              .toString(),
                      status: PaymentItemStatus.final_price,
                    )
                  ],
                  style: ApplePayButtonStyle.black,
                  type: ApplePayButtonType.buy,
                  margin: const EdgeInsets.only(top: 15.0),
                  onPaymentResult: (result) {},
                  loadingIndicator: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                24.heightWidth
              ]
            ],
          ),
        );
      }),
    );
  }
}
