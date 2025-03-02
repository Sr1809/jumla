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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(AppAssets.logo, height: 20, width: 50),
            SizedBox(width: 10),
            Text(
              "Company name & address",
              style: AppTextStyles.bold(
                  fontSize: 18.0, fontColor: AppColors.whiteColor),
            ),
          ],
        ),
        backgroundColor: AppColors.blueColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextFieldWithTitle(
              label: "Company name",
              controller: controller.companyNameController),
          CommonTextFieldWithTitle(
              label: "Address", controller: controller.addressController),
          CommonTextFieldWithTitle(
              label: "Contact number",
              controller: controller.contactNumberController),
          CommonTextFieldWithTitle(
              label: "Email", controller: controller.emailController),
          CommonTextFieldWithTitle(
            label: "Website",
            controller: controller.websiteController,
            hint: "http://mycompany.com",
          ),
          CommonTextFieldWithTitle(
              label: "Slogan", controller: controller.sloganController),
        ],
      ),
      bottomNavigationBar: Container(
        color: AppColors.blueColor,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: GestureDetector(
          onTap: () {
            Get.toNamed(Routes.HOME);
          },
          child: SizedBox(
            width: double.infinity,
            height: 40,
            child: Center(
              child: Text(
                "NEXT",
                style: AppTextStyles.bold(
                    fontSize: 18.0, fontColor: AppColors.whiteColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
