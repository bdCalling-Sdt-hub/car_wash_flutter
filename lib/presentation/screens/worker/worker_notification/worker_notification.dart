import 'package:car_wash/presentation/widgets/custom_text/custom_text.dart';
import 'package:car_wash/presentation/widgets/notification_card/notification_card.dart';
import 'package:car_wash/utils/dimensions/dimensions.dart';
import 'package:car_wash/utils/static_strings/static_strings.dart';
import 'package:flutter/material.dart';

class WorkerNotification extends StatelessWidget {
  const WorkerNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.notification,
          fontSize: Dimensions.getFontSizeExtraLarge(context),
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
              onPressed: () {},
              icon: const CustomText(text: AppStrings.readAll)),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: List.generate(
                10,
                (index) {
                  return const NotificationCard(
                      title: "New Order",
                      subTitle: "452 offered by a truck owner for your trip.",
                      createdAt: "4 hour ago ");
                },
              ),
            ),
          ))
        ],
      ),
    );
  }
}
