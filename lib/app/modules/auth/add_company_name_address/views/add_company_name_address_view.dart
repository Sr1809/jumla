import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/resources/app_assets.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:jumla/app/resources/app_styles.dart';
import 'package:jumla/app/routes/app_pages.dart';

import '../../../../common/common_text_field.dart';
import '../controllers/add_company_name_address_controller.dart';

class AddCompanyNameAddressView
    extends GetView<AddCompanyNameAddressController> {
  const AddCompanyNameAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600; // Detect if the device is a tablet

    double textSize = isTablet ? 30.0 : 18.0; // Adjust font size for tablets
    double paddingSize = isTablet ? 40.0 : 0.0; // Increased padding for tablets
    double fieldWidth = isTablet ? screenWidth * 0.7 : screenWidth; // Adjusted input field width

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(AppAssets.logo, height: isTablet ? 50 : 30, width: isTablet ? 150 : 100),
            SizedBox(width: 10),
            Text(
              "Company name & address",
              style: AppTextStyles.bold(
                  fontSize: textSize,
                  fontColor: AppColors.whiteColor
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.blueColor,
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: fieldWidth, // Adjust width dynamically
            padding: EdgeInsets.all(paddingSize),
            child: ListView(
            //  crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: paddingSize),
                CommonTextFieldWithTitle(
                  label: "Company name",
                  controller: controller.companyNameController,
                ),
                CommonTextFieldWithTitle(
                  label: "Address",
                  controller: controller.addressController,
                ),
                CommonTextFieldWithTitle(
                  label: "Contact number",
                  controller: controller.contactNumberController,
                ),
                CommonTextFieldWithTitle(
                  label: "Email",
                  controller: controller.emailController,
                ),
                CommonTextFieldWithTitle(
                  label: "Website",
                  controller: controller.websiteController,
                  hint: "http://mycompany.com",
                ),
                CommonTextFieldWithTitle(
                  label: "Slogan",
                  controller: controller.sloganController,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.blueColor,
        padding: EdgeInsets.symmetric(horizontal: paddingSize, vertical: 10),
        child: SafeArea(
          child: InkWell(
            onTap: () {
              Get.toNamed(Routes.ADD_CURRENCY_DATE_FORMATS);
            },
            child: SizedBox(
              width: double.infinity,
              height: isTablet ? 70 : 30, // Bigger button height for tablets
              child: Center(
                child: Text(
                  "NEXT",
                  style: AppTextStyles.bold(
                    fontSize: textSize,
                    fontColor: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
