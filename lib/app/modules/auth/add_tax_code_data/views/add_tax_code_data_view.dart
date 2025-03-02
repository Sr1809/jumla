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
    return Scaffold(
      appBar: AppBar(
        title: Text("Tax Code", style: AppTextStyles.bold(fontSize: 18.0, fontColor: AppColors.whiteColor)),
        backgroundColor: AppColors.blueColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.whiteColor),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: AppColors.whiteColor),
            onPressed: () {
Get.back(result: "${controller.taxNameController.text.trim()}%${ controller.taxRateController.text}");
            },
          ),
          // IconButton(
          //   icon: Icon(Icons.delete, color: AppColors.whiteColor),
          //   onPressed: () {
          //     // Handle delete
          //   },
          // ),
          IconButton(
            icon: Icon(Icons.close, color: AppColors.whiteColor),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
                    controller: controller.taxRateController,

                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            CommonTextField(
              label: "Description",
              controller: controller.descriptionController,
              underlineColor: AppColors.greyColor,
            ),
          ],
        ),
      ),
    );
  }
}
