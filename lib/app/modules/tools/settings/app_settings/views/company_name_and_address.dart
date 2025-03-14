import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/common_appbar.dart';
import '../../../../../common/common_text_field.dart';
import '../../../../../resources/app_styles.dart';
import '../../../../../core/app_storage.dart';
import '../controllers/app_settings_controller.dart';
import 'company_custom_field_view.dart';

class CompanyInfoView extends GetView<AppSettingsController> {
  const CompanyInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    double textSize = isTablet ? 30.0 : 18.0;
    double paddingSize = isTablet ? 40.0 : 20.0;
    double containerWidth = screenWidth * (isTablet ? 0.7 : 0.9);
    double buttonHeight = isTablet ? 70 : 40;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Company name & address",
        showBackButton: true,
        hideLogo: true,
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: containerWidth, // ✅ Responsive width
          padding: EdgeInsets.all(paddingSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// **Company Name**
              CommonTextFieldWithTitle(
                controller: controller.companyNameController,
                label: 'Company Name',
                hint: "Enter company name",
              ),

              /// **Address**
              CommonTextFieldWithTitle(
                controller: controller.addressController,
                label: 'Address',
                hint: "Enter address",
              ),

              /// **Contact Number**
              CommonTextFieldWithTitle(
                controller: controller.contactNumberController,
                label: 'Contact Number',
                hint: "Enter contact number",

              ),

              /// **Email**
              CommonTextFieldWithTitle(
                controller: controller.emailController,
                label: 'Email',
                hint: "Enter email",
              ),

              /// **Website**
              CommonTextFieldWithTitle(
                controller: controller.websiteController,
                label: 'Website',
                hint: "Enter website URL",
              ),

              /// **Slogan**
              CommonTextFieldWithTitle(
                controller: controller.sloganController,
                label: 'Slogan',
                hint: "Enter company slogan",
              ),

              SizedBox(height: 20),

              /// **Custom Fields Section**
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  color: AppStorages.appColor.value.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("CUSTOM FIELDS",
                        style: AppTextStyles.bold(fontSize: textSize * 0.8, fontColor: Colors.black)),
                    ElevatedButton(
                      onPressed: ()=>Get.to(()=>CompanyCustomFieldsView()), // TODO: Implement Add/Edit functionality
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppStorages.appColor.value,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      ),
                      child: Text("Add / Edit",
                          style: AppTextStyles.bold(fontSize: textSize * 0.7, fontColor: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      /// **Bottom Navigation**
      bottomNavigationBar: Container(
        height: buttonHeight,
        padding: EdgeInsets.symmetric(horizontal: paddingSize),
        decoration: BoxDecoration(
          color: AppStorages.appColor.value,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.save, color: Colors.white, size: textSize),
              onPressed: () {
                // TODO: Implement Save functionality
              },
            ),
            Text("TAGS", style: AppTextStyles.bold(fontSize: textSize, fontColor: Colors.white)),
            IconButton(
              icon: Icon(Icons.close, color: Colors.white, size: textSize),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }
}
