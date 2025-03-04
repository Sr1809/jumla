import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_appbar.dart';
import '../../../../common/common_button.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_styles.dart';
import '../controllers/manage_data_controller.dart';

class ExportCSVScreen extends  GetView<ManageDataController>{
  const ExportCSVScreen({super.key});


  @override
  Widget build(BuildContext context) {
    Get.put(ManageDataController());
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        title: "Export CSV",
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           SizedBox(
             width: Get.width,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
               Text(
                 "Record to export",
                 style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor),
               ),
               SizedBox(height: 10),
               GestureDetector(
                 onTap: () => showRecordSelectionPopup(context, controller.selectedRecord),
                 child: Container(
                   // width: double.infinity,
                   padding: EdgeInsets.all(10),
                   decoration: BoxDecoration(
                     border: Border.all(color: AppColors.blackColor),
                     borderRadius: BorderRadius.circular(5),
                     color: AppColors.whiteColor,
                   ),
                   child: Obx(() => Text(
                     controller.selectedRecord.value,
                     style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor),
                   )),
                 ),
               ),
             ],),
           ),
            SizedBox(height: 20),
            Obx(() => _customCheckbox("Save to Sdcard", controller.saveToSdCard,)),
            SizedBox(height: 10,),
            Obx(() => _customCheckbox("Send to Email", controller.sendToEmail)),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: CommonFullWidthButton(
              text: "EXPORT",

              onTap: () {
                Get.back();
              },
            ),
          ),
          Expanded(
            child: CommonFullWidthButton(
              text: "CANCEL",

              onTap: () => Get.back(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _customCheckbox(String label, RxBool value, {bool isDisabled = false}) {
    return GestureDetector(
      onTap: isDisabled ? null : () => value.value = !value.value,
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isDisabled ? AppColors.greyColor : AppColors.whiteColor,
              border: Border.all(color: AppColors.blackColor, width: 2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: value.value ? Icon(Icons.check, color: AppColors.blueColor, size: 18) : null,
          ),
          SizedBox(width: 10),
          Text(
            label,
            style: AppTextStyles.regular(fontSize: 14.0, fontColor: isDisabled ? AppColors.greyColor : AppColors.blackColor),
          ),
        ],
      ),
    );
  }
}

void showRecordSelectionPopup(BuildContext context, RxString selectedRecord) {
  List<String> records = [
    "Customers",
    "Items",
    "Quotes",
    "Sales Orders",
    "Cash Sales",
    "Invoices",
    "Purchase Orders",
  ];

  Get.dialog(
    AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Choose one",
            style: AppTextStyles.bold(fontSize: 18.0, fontColor: AppColors.blueColor),
          ),
          SizedBox(height: 5),
          Divider(color: AppColors.blueColor, thickness: 2),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: records.map((record) {
          return Obx(() => RadioListTile<String>(
            title: Text(record, style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor)),
            value: record,
            groupValue: selectedRecord.value,
            activeColor: AppColors.blueColor,
            onChanged: (value) {
              selectedRecord.value = value!;
              Get.back();
            },
          ));
        }).toList(),
      ),
    ),
  );
}
