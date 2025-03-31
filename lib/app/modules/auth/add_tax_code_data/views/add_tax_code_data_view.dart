import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/common_text_field.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_styles.dart';
import '../controllers/add_tax_code_data_controller.dart';

class AddTaxCodeDataView extends GetView<AddTaxCodeDataController> {
  const AddTaxCodeDataView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600; // Detect if the device is a tablet

    double textSize = isTablet ? 30.0 : 18.0; // Adjust font size
    double paddingSize = isTablet ? 40.0 : 20.0; // Adjust padding
    double fieldWidth = isTablet ? screenWidth * 0.7 : screenWidth * 0.9; // Adjust form width
    double appBarTextSize = isTablet ? 30.0 : 18.0; // Adjust AppBar text size
    double buttonHeight = isTablet ? 70 : 40; // Adjust button height

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
          "Tax Code",
          style: AppTextStyles.bold(fontSize: appBarTextSize, fontColor: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.blueColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.whiteColor),
          onPressed: () => Get.back(),
        ),
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: fieldWidth, // Adjust width dynamically
            padding: EdgeInsets.all(paddingSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CommonTextFieldWithTitle(
                        label: "Name",
                        hint: "eg. Sales Tax",
                        controller: controller.taxNameController,
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: CommonTextFieldWithTitle(
                        label: "Rate(%)",
                        hint: "10%",
                        controller: controller.taxRateController,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: paddingSize / 2),
                CommonTextField(
                  label: "Description",
                  controller: controller.descriptionController,
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        color: AppColors.blueColor,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: SafeArea(
          child: InkWell(
            onTap: () {
              Get.back(result: "${controller.taxNameController.text.trim()}%${controller.taxRateController.text}");
            },
            child: SizedBox(
              width: double.infinity,
              height: buttonHeight,
              child: Center(
                child: Text(
                  "SAVE",
                  style: AppTextStyles.bold(fontSize: textSize, fontColor: AppColors.whiteColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
