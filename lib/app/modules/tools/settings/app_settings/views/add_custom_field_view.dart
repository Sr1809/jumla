import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/resources/app_colors.dart';
import '../../../../../common/common_appbar.dart';
import '../../../../../common/common_text_field.dart';
import '../../../../../resources/app_styles.dart';
import '../../../../../core/app_storage.dart';
import '../controllers/app_settings_controller.dart';

class AddCustomFieldView extends GetView<AppSettingsController> {
  const AddCustomFieldView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    double textSize = isTablet ? 28.0 : 16.0;
    double paddingSize = isTablet ? 40.0 : 20.0;
    double containerWidth = screenWidth;
    double checkboxSize = isTablet ? 40 : 24;
    double checkboxIconSize = isTablet ? 30 : 20;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Add Custom Field",
        showBackButton: true,
        hideLogo: true,
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: Colors.white),
            onPressed: () => controller.saveCustomField(),
          ),
          IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: Container(
        width: containerWidth,
        padding: EdgeInsets.all(paddingSize),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// **Apply To**
              Row(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Apply To",
                    style: AppTextStyles.bold(fontSize: textSize, fontColor: Colors.black),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => controller.applyToCompany.value = !controller.applyToCompany.value,
                    child: Container(
                      width: checkboxSize,
                      height: checkboxSize,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: controller.applyToCompany.value
                          ? Center(
                        child: Icon(Icons.check, color: AppStorages.appColor.value, size: checkboxIconSize),
                      )
                          : null,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Company",
                    style: AppTextStyles.regular(fontSize: textSize * 0.8, fontColor: Colors.black),
                  ),
                ],
              )),
              SizedBox(height: paddingSize / 2),

              /// **Name Field**
              CommonTextFieldWithTitle(
                controller: controller.nameController,
                label: "Name",
                hint: "Enter name",
              ),
              SizedBox(height: paddingSize / 2),

              /// **Input Type Dropdown**
              Center(
                child: Text(
                  "Input Type",
                  style: AppTextStyles.regular(fontSize: textSize, fontColor: Colors.black),
                ),
              ),
              SizedBox(height: paddingSize / 2),
              Obx(() => Center(
                child: GestureDetector(
                  onTap: () => showInputTypePopup(context,controller.selectedInputType),
                  child: Container(
                    width: Get.width/3,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                      color: AppStorages.appColor.value,
                    ),
                    child: Center(
                      child: Text(
                        controller.selectedInputType.value,
                        style: AppTextStyles.regular(fontSize: textSize * 0.8, fontColor: AppColors.whiteColor),
                      ),
                    ),
                  ),
                ),
              )),
              SizedBox(height: paddingSize / 2),

              /// **Default Value Field**
              CommonTextFieldWithTitle(
                controller: controller.defaultValueController,
                label: "Default Value (Optional)",
                hint: "Enter default value",
              ),
              SizedBox(height: paddingSize),
            ],
          ),
        ),
      ),
    );
  }



  void showInputTypePopup(BuildContext context, RxString selectedInputType) {
    List<String> inputTypes = [
      "Text",
      "Long text",
      "Number",
      "Decimal",
      "Currency",
      "Checkbox",
      "Date",
      "Time",
      "Email",
      "Phone no",
      "Barcode",
      "URL"
    ];

    Get.dialog(
      AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Type of input",
              style: AppTextStyles.bold(fontSize: 18.0, fontColor: AppStorages.appColor.value),
            ),
            SizedBox(height: 5),
            Divider(color: AppStorages.appColor.value, thickness: 2),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: inputTypes.map((type) {
            return Obx(() => RadioListTile<String>(
              title: Text(
                type,
                style: AppTextStyles.regular(fontSize: 16.0, fontColor: Colors.black),
              ),
              value: type,
              groupValue: selectedInputType.value,
              activeColor: AppStorages.appColor.value,
              onChanged: (value) {
                selectedInputType.value = value!;
                Get.back();
              },
            ));
          }).toList(),
        ),
      ),
    );
  }

}
