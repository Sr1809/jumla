import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/modules/home/views/customers/controllers/customer_controller.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:jumla/app/resources/app_styles.dart';

class CustomersView extends GetView<CustomerController> {
  CustomersView({super.key});
  final CustomerController customerController = Get.put(CustomerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              color: AppColors.blueColor,
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      "Customer",
                      style: AppTextStyles.medium(
                          fontSize: 20.0, fontColor: AppColors.whiteColor),
                    )),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search),
                        Icon(Icons.refresh_outlined),
                        Icon(Icons.add),
                        Icon(Icons.more_vert)
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: AppColors.blackColor,
              child: Text(
                "To see more options.long-hold on one line.",
                style: AppTextStyles.regular(
                    fontSize: 12.0, fontColor: AppColors.blackColor),
              ),
            )
          ],
        ));
  }
}
