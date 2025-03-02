import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jumla/app/common/common_text_field.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:jumla/app/resources/app_styles.dart';

import '../../../../common/common_appbar.dart';
import '../../../../common/common_picker.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/add_currency_date_formats_controller.dart';

class AddCurrencyDateFormatsView
    extends GetView<AddCurrencyDateFormatsController> {
  const AddCurrencyDateFormatsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: 'Currency & date formats',showBackButton: true,),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Locale",
                style: AppTextStyles.regular(
                  fontSize: 16.0,
                  fontColor: AppColors.greyColor,
                ),
              ),
              SizedBox(height: 5),
              Container(width: Get.width, height: 1, color: Colors.black26),
              GestureDetector(
                onTap: () {
                  CommonPicker.showCountryPopup(context, (v) {
                    controller.localeController.value = v;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10, left: 20),
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 5,
                    bottom: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    border: Border.all(width: 1, color: AppColors.greyColor),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.greyColor.withOpacity(0.2), // Shadow color
                        blurRadius: 2, // Blur effect
                        spreadRadius: 1, // How much the shadow expands
                        offset: Offset(2, 2), // Shadow position (X, Y)
                      ),
                    ],
                  ),
                  child: Obx(()=>Text(
                    controller.localeController.value,
                    style: AppTextStyles.regular(
                      fontSize: 15.0,
                      fontColor: AppColors.blackColor,
                    ),
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  "Locale is used as the main basis for currency and date formats.",
                  style: AppTextStyles.regular(
                    fontSize: 14.0,
                    fontColor: AppColors.greyColor,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Date Formats",
                style: AppTextStyles.regular(
                  fontSize: 16.0,
                  fontColor: AppColors.greyColor,
                ),
              ),
              SizedBox(height: 5),
              Container(width: Get.width, height: 1, color: Colors.black26),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    SizedBox(width: 120, child: Text("Long date:",style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.greyColor),)),
                    Text(
                      DateFormat('MMMM d, y').format(DateTime.now()),
                      style: AppTextStyles.medium(
                        fontSize: 16.0,
                        fontColor: AppColors.greyColor,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    SizedBox(width: 120, child: Text("Medium date:",style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.greyColor),)),
                    Text(
                      DateFormat('MMM d, y').format(DateTime.now()),
                      style: AppTextStyles.medium(
                        fontSize: 16.0,
                        fontColor: AppColors.greyColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    SizedBox(width: 120, child: Text("Short date:",style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.greyColor),)),
                    Text(
                      DateFormat('M/d/yy').format(DateTime.now()),
                      style: AppTextStyles.medium(
                        fontSize: 16.0,
                        fontColor: AppColors.greyColor,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),
             Padding(
               padding: const EdgeInsets.only(left: 20),
               child: Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Text("Use this format:",style: AppTextStyles.semiBold(fontSize: 14.0, fontColor: AppColors.blackColor),),
                   GestureDetector(
                     onTap: () {
                       CommonPicker.selectDateFormatPopup(context, (v) {
                         controller.dateFormatController.value = v;
                       });
                     },
                     child:
                     Container(
                       margin: EdgeInsets.only( left: 20),
                       padding: EdgeInsets.only(
                         left: 10,
                         right: 10,
                         top: 5,
                         bottom: 5,
                       ),
                       decoration: BoxDecoration(
                         color: AppColors.whiteColor,
                         border: Border.all(width: 1, color: AppColors.greyColor),
                         boxShadow: [
                           BoxShadow(
                             color: AppColors.greyColor.withOpacity(0.2), // Shadow color
                             blurRadius: 2, // Blur effect
                             spreadRadius: 1, // How much the shadow expands
                             offset: Offset(2, 2), // Shadow position (X, Y)
                           ),
                         ],
                       ),
                       child: Obx(()=>Text(
                         controller.dateFormatController.value,
                         style: AppTextStyles.regular(
                           fontSize: 15.0,
                           fontColor: AppColors.blackColor,
                         )),
                       ),
                     ),
                   ),
                 ],
               ),
             ),
              SizedBox(height: 20),
              Text(
                "Currency (optional)",
                style: AppTextStyles.regular(
                  fontSize: 16.0,
                  fontColor: AppColors.greyColor,
                ),
              ),
              SizedBox(height: 5),
              Container(width: Get.width, height: 1, color: Colors.black26),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Currency format",
                  style: AppTextStyles.medium(
                    fontSize: 14.0,
                    fontColor: AppColors.blackColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5,top: 5),
                child: SizedBox(
                  width: 120,
                  height: 35,
                  child: CommonTextField(
                    label: "1,234.56",
                    controller: controller.currencyFormatController,
                    underlineColor: AppColors.greyColor,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20,top: 5),
                child: Text(
                  "The format used when showing currency amounts on the screens and printouts. By default, this is taken from the selected locale.",
                  style: AppTextStyles.medium(
                    fontSize: 14.0,
                    fontColor: AppColors.greyColor,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Currency symbol",
                  style: AppTextStyles.medium(
                    fontSize: 14.0,
                    fontColor: AppColors.blackColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5,top: 5),
                child: SizedBox(
                  width: 60,
                  height: 35,
                  child: CommonTextField(
                    label: "  ",
                    controller: controller.currencySymbolController,
                    underlineColor: AppColors.blackColor,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "The currency symbol taken from the locale. Override if necessary.\n\nNote: By default, currency symbol is NOT shown on the printouts. Please insert the {COMPANY.CURRENCY} tag on print templates to show the value entered here on the printouts.",
                  style: AppTextStyles.regular(
                    fontSize: 14.0,
                    fontColor: AppColors.greyColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.blueColor,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: InkWell(
                onTap: () {
Get.toNamed(Routes.ADD_TAX_SETUP);
                },

                child: Text(
                  "NEXT",
                  style: AppTextStyles.bold(
                    fontSize: 16.0,
                    fontColor: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Flexible(
              child: InkWell(
                onTap: () {
                Get.back();
                },

                child: Text(
                  "BACK",
                  style: AppTextStyles.bold(
                    fontSize: 16.0,
                    fontColor: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
