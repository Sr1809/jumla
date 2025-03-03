import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:jumla/app/resources/app_styles.dart';

import '../../../../common/common_appbar.dart';
import '../../../../common/common_text_field.dart';
import '../controllers/manage_data_controller.dart';

class BackupDatabaseView extends GetView<ManageDataController>{
  const BackupDatabaseView({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Backup Database",
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
            Text(
              "You're about to backup the database on this device.",
              style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor),
            ),
            SizedBox(height: 20),
            Obx(() => _customCheckbox("Save to Sdcard", controller.saveToSdCard, isDisabled: true)),
            SizedBox(height: 10),
            Obx(() => _customCheckbox("Save to Dropbox", controller.saveToDropbox)),
            SizedBox(height: 10),
            Obx(() => _customCheckbox("Send to Email", controller.sendToEmail)),
            SizedBox(height: 20),
            CommonTextField(
              label: "Optional name for backup",
              controller: controller.optionalController,
              isPassword: false,underlineColor: AppColors.blackColor,
            ),

            SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle backup action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.withOpacity(0.4),
                    elevation:0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                ),
                child: Text("Backup Now", style: AppTextStyles.bold(fontSize: 16.0, fontColor: AppColors.blackColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customCheckbox(String label, RxBool value, {bool isDisabled = false}) {
    return GestureDetector(
      onTap: isDisabled ? null : () => value.value = !value.value,
      child: Padding(
        padding:  EdgeInsets.only(left: Get.width*0.28),
        child: Row(

          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: isDisabled ? AppColors.whiteColor : AppColors.whiteColor,
                border: Border.all(color: AppColors.blackColor, width: 2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: value.value ? Center(child: Icon(Icons.check, color: AppColors.blueColor, size: 18)) : null,
            ),
            SizedBox(width: 10),
            Text(
              label,
              style: AppTextStyles.regular(fontSize: 14.0, fontColor: isDisabled ? AppColors.greyColor : AppColors.blackColor),
            ),
          ],
        ),
      ),
    );
  }
}
