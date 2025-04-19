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
    var controller = Get.put(AppSettingsController());

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
          width: containerWidth,
          padding: EdgeInsets.all(paddingSize),
          child: Form(
            key: controller.formKey,
            child: ListView(
              children: [
                CommonTextFieldWithTitle(
                  controller: controller.companyNameController,
                  label: 'Company Name',
                  hint: "Enter company name",
                  validator: (value) => value == null || value.isEmpty ? 'Company name is required' : null,
                ),

                CommonTextFieldWithTitle(
                  controller: controller.addressController,
                  label: 'Address',
                  hint: "Enter address",
                  validator: (value) => value == null || value.isEmpty ? 'Address is required' : null,
                ),

                CommonTextFieldWithTitle(
                  controller: controller.contactNumberController,
                  label: 'Contact Number',
                  hint: "Enter contact number",
                  keyboardType: TextInputType.phone,
                  validator: (value) => value == null || value.isEmpty ? 'Contact number is required' : null,
                ),

                CommonTextFieldWithTitle(
                  controller: controller.emailController,
                  label: 'Email',
                  hint: "Enter email",
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Email is required';
                    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+\$');
                    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
                    return null;
                  },
                ),

                CommonTextFieldWithTitle(
                  controller: controller.websiteController,
                  label: 'Website',
                  hint: "Enter website URL",
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'Website is required';
                    final urlRegex = RegExp(
                        r'^(https?:\/\/)?'
                        r'((([a-zA-Z0-9\-_.]+)\.)+[a-zA-Z]{2,})'
                        r'(\:\d+)?(\/[-a-zA-Z0-9@:%_\+.~#?&//=]*)?'
                        r'(\?[;&a-zA-Z0-9%_\+.~#?&//=]*)?'
                        r'(\#[-a-zA-Z0-9@:%_\+.~#?&//=]*)?\$'
                    );
                    if (!urlRegex.hasMatch(value)) return 'Enter a valid website URL';
                    return null;
                  },
                ),

                CommonTextFieldWithTitle(
                  controller: controller.sloganController,
                  label: 'Slogan',
                  hint: "Enter company slogan",
                  validator: (value) => value == null || value.isEmpty ? 'Slogan is required' : null,
                ),

                SizedBox(height: 20),

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
                        onPressed: ()=>Get.to(()=>CompanyCustomFieldsView()),
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
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: paddingSize),
        decoration: BoxDecoration(
          color: AppStorages.appColor.value,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.save, color: Colors.white),
                onPressed: () {
                  if (controller.formKey.currentState!.validate()) {
                    // TODO: Implement Save functionality
                    print("Form is valid");
                  }
                },
              ),
              Text("TAGS", style: AppTextStyles.bold(fontSize: textSize, fontColor: Colors.white)),
              IconButton(
                icon: Icon(Icons.close, color: Colors.white,),
                onPressed: () => Get.back(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
