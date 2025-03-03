import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/common/common_appbar.dart';
import 'package:jumla/app/modules/home/views/customers/controllers/customer_controller.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:jumla/app/resources/app_styles.dart';
import 'package:jumla/app/routes/app_pages.dart';

class CustomersView extends GetView<CustomerController> {
  CustomersView({super.key});

  final CustomerController customerController = Get.put(CustomerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar:
            CommonAppBar(title: "Customers", showBackButton: false, actions: [
          Icon(Icons.search, color: AppColors.whiteColor),
          SizedBox(width: 12),
          Icon(Icons.refresh_outlined, color: AppColors.whiteColor),
          SizedBox(width: 12),
          Icon(Icons.add, color: AppColors.whiteColor),
          SizedBox(width: 12),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: AppColors.whiteColor),
            padding: EdgeInsets.all(0.0),
            onSelected: (value) {
              // Get.back();
              // if (value == "Account") {
              //   controller.showAccountField.value = !controller.showAccountField.value;
              // }
            },
            iconColor: Colors.white70,
            itemBuilder: (context) => [
              PopupMenuItem(
                height: 30,

                //  padding: EdgeInsets.only(left: 10,right: 10,top: 4,bottom: 4),
                value: "import",
                child: Text(
                  "Import CSV",
                  style: AppTextStyles.regular(
                      fontSize: 20.0, fontColor: AppColors.blackColor),
                ),
              ),
              PopupMenuItem(
                height: 30,

                //  padding: EdgeInsets.only(left: 10,right: 10,top: 4,bottom: 4),
                value: "export",
                child: Text(
                  "Export CSV",
                  style: AppTextStyles.regular(
                      fontSize: 20.0, fontColor: AppColors.blackColor),
                ),
              ),
            ],
          ),
          SizedBox(width: 12),
        ]),
        body: Column(
          children: [
            Container(
              width: Get.width,
              color: AppColors.blackColor,
              child: Text(
                "To see more options.long-hold on one line.",
                style: AppTextStyles.medium(
                    fontSize: 12.0, fontColor: AppColors.whiteColor),
                textAlign: TextAlign.center,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8, bottom: 4, top: 4),
                child: Text(
                  "3 Records",
                  style: AppTextStyles.semiBold(
                      fontSize: 14.0, fontColor: AppColors.greyColor),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            Divider(color: AppColors.lightGrey, height: 1.0),
            Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.toNamed(Routes.CUSTOMER_DETAILS);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14.0, vertical: 8),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    index == 2 ? "DVD-R" : "Anonymous Customer",
                                    style: AppTextStyles.medium(
                                        fontSize: 18.0,
                                        fontColor: AppColors.blackColor),
                                  ),
                                  Text(
                                    index == 2 ? "Individual" : "Company",
                                    style: AppTextStyles.regular(
                                        fontSize: 14.0,
                                        fontColor: AppColors.darkGrey),
                                  )
                                ],
                              )),
                              Icon(Icons.keyboard_arrow_right)
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(color: AppColors.lightGrey, height: 1.0);
                    },
                    itemCount: 3)),
          ],
        ));
  }
}
