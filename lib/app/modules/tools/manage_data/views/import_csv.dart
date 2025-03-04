
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/common_appbar.dart';
import '../../../../common/common_button.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_styles.dart';
import '../controllers/manage_data_controller.dart';

class ImportCSVScreen extends StatelessWidget {
  final ManageDataController controller = Get.put(ManageDataController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Import CSV",
        showBackButton: true,
        hideLogo: true,
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: AppColors.whiteColor),
            onPressed: () => Get.back(),
          ),
        ],
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
                   "Record to import",
                   style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor),
                 ),
                 SizedBox(height: 10),
                 GestureDetector(
                   onTap: () => showRecordSelectionPopup(context, controller.selectedRecordForImport),
                   child: Container(

                     padding: EdgeInsets.all(10),
                     decoration: BoxDecoration(
                       border: Border.all(color: AppColors.blackColor),
                       borderRadius: BorderRadius.circular(5),
                       color: AppColors.whiteColor,
                     ),
                     child: Obx(() => Text(
                       controller.selectedRecordForImport.value,
                       style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor),
                     )),
                   ),
                 ),
               ],
             ),
           ),
            SizedBox(height: 20),
            Row(
              children: [
                InkWell(
                  onTap: (){
                    showCSVFileLocationPopup(context, controller.selectedFileLocation);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.blackColor),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Obx(()=>Text(controller.selectedFileLocation.value, style: AppTextStyles.bold(fontSize: 16.0, fontColor: AppColors.blackColor))),
                  ),
                ),
                SizedBox(width: 10),
                Text("Required", style: AppTextStyles.regular(fontSize: 16.0, fontColor: Colors.red)),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CommonElevatedButton(text: "Import One", onPressed: () {},backgroundColor: Colors.white38,textColor: AppColors.blackColor,fontSize: 12,),
                CommonElevatedButton(text: "Import All", onPressed: () {},backgroundColor: Colors.white38,textColor: AppColors.blackColor,fontSize: 12,),
                CommonElevatedButton(text: "Cancel", onPressed: () => Get.back(),backgroundColor: AppColors.buttonColor,textColor: AppColors.blackColor,fontSize: 12,),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "To import custom fields, simply include the custom field Label as columns on the data file.\n\nFor example, you have a custom item field called Item Weight.\n\nIf your data file includes an ITEM WEIGHT header, its value is imported into the Item Weight field of the item record.",
              style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.blackColor),
            ),
          ],
        ),
      ),
    );
  }
}

void showRecordSelectionPopup(BuildContext context, RxString selectedRecord) {
  List<String> records = ["Import items", "Import customers"];

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
void showCSVFileLocationPopup(BuildContext context, RxString selectedFileLocation) {
  List<String> locations = ["Sdcard", "Dropbox"];

  Get.dialog(
    AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select data file location",
            style: AppTextStyles.bold(fontSize: 18.0, fontColor: AppColors.blueColor),
          ),
          SizedBox(height: 5),
          Divider(color: AppColors.blueColor, thickness: 2),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: locations.map((location) {
          return ListTile(
            title: Text(location, style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor)),
            onTap: () {
              selectedFileLocation.value = location;
              Get.back();
            },
          );
        }).toList(),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text("Cancel", style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor)),
        ),
      ],
    ),
  );
}
