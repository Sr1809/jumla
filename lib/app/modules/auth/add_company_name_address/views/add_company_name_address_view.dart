import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/resources/app_assets.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:jumla/app/resources/app_styles.dart';
import 'package:jumla/app/routes/app_pages.dart';

import '../../../../common/common_text_field.dart';
import '../controllers/add_company_name_address_controller.dart';

class AddCompanyNameAddressView extends GetView<AddCompanyNameAddressController> {
  const AddCompanyNameAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    double textSize = isTablet ? 30.0 : 18.0;
    double paddingSize = isTablet ? 40.0 : 0.0;
    double fieldWidth = isTablet ? screenWidth * 0.7 : screenWidth;

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
            width: fieldWidth,
            padding: EdgeInsets.all(paddingSize),
            child: Form(
              key: controller.formKey,
              child: ListView(
                children: [
                  SizedBox(height: paddingSize),
                  CommonTextFieldWithTitle(
                    label: "Company name",
                    controller: controller.companyNameController,
                    validator: (value) => value == null || value.isEmpty ? 'Company name is required' : null,
                  ),
                  CommonTextFieldWithTitle(
                    label: "Address",
                    controller: controller.addressController,
                    validator: (value) => value == null || value.isEmpty ? 'Address is required' : null,
                  ),
                  CommonTextFieldWithTitle(
                    label: "Contact number",
                    controller: controller.contactNumberController,
                    validator: (value) => value == null || value.isEmpty ? 'Contact number is required' : null,
                    keyboardType: TextInputType.phone,
                  ),
                  CommonTextFieldWithTitle(
                    label: "Email",
                    controller: controller.emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  CommonTextFieldWithTitle(
                    label: "Website",
                    controller: controller.websiteController,
                    hint: "http://mycompany.com",
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Website is required';

                      final urlRegex = RegExp(
                        r'^(https?:\/\/)?'
                        r'((([a-zA-Z0-9\-_]+\.)+[a-zA-Z]{2,})|'
                        r'localhost|'
                        r'(\d{1,3}\.){3}\d{1,3})'
                        r'(\:\d+)?(\/[-a-zA-Z0-9@:%_\+.~#?&//=]*)?$',
                      );

                      if (!urlRegex.hasMatch(value)) {
                        return 'Enter a valid website URL';
                      }
                      return null;
                    },                  ),
                  CommonTextFieldWithTitle(
                    label: "Slogan",
                    controller: controller.sloganController,
                    validator: (value) => value == null || value.isEmpty ? 'Slogan is required' : null,
                  ),
                ],
              ),
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
              if (controller.formKey.currentState!.validate()) {
                Get.toNamed(Routes.ADD_CURRENCY_DATE_FORMATS);
              }
            },
            child: SizedBox(
              width: double.infinity,
              height: isTablet ? 70 : 30,
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
