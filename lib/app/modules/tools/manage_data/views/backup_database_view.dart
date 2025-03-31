import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:jumla/app/resources/app_styles.dart';

import '../../../../common/common_appbar.dart';
import '../../../../common/common_text_field.dart';
import '../../../../core/app_storage.dart';
import '../controllers/manage_data_controller.dart';

class BackupDatabaseView extends GetView<ManageDataController> {
  const BackupDatabaseView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    double textSize = isTablet ? 30.0 : 18.0;
    double paddingSize = isTablet ? 40.0 : 20.0;
    double buttonHeight = isTablet ? 40 : 30;
    double containerWidth =  screenWidth ;
    double checkboxAlignment = isTablet ? screenWidth * 0.35 : screenWidth * 0.28;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Backup Database",
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
              /// **Backup Information**
              Text(
                "You're about to backup the database on this device.",
                style: AppTextStyles.regular(fontSize: textSize, fontColor: Colors.black),
              ),
              SizedBox(height: paddingSize / 2),

              /// **Checkboxes**
              Obx(() => _customCheckbox("Save to Sdcard", controller.saveToSdCard, isDisabled: true, alignment: checkboxAlignment)),
              SizedBox(height: 10),
              Obx(() => _customCheckbox("Save to Dropbox", controller.saveToDropbox, alignment: checkboxAlignment)),
              SizedBox(height: 10),
              Obx(() => _customCheckbox("Send to Email", controller.sendToEmail, alignment: checkboxAlignment)),
              SizedBox(height: paddingSize / 2),

              /// **Optional Backup Name**
              CommonTextField(
                label: "Optional name for backup",
                controller: controller.optionalController,
                isPassword: false,

              ),
              SizedBox(height: paddingSize / 2),

              /// **Backup Button**
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Handle backup action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStorages.appColor.value,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: buttonHeight / 2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text("Backup Now",
                      style: AppTextStyles.bold(fontSize: textSize * 0.8, fontColor: AppColors.whiteColor)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// **Custom Checkbox**
  Widget _customCheckbox(String label, RxBool value, {bool isDisabled = false, required double alignment}) {
    return GestureDetector(
      onTap: isDisabled ? null : () => value.value = !value.value,
      child: Padding(
        padding: EdgeInsets.only(left: alignment),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: value.value
                  ? Center(child: Icon(Icons.check, color: AppStorages.appColor.value, size: 20))
                  : null,
            ),
            SizedBox(width: 10),
            Text(
              label,
              style: AppTextStyles.regular(fontSize: 16.0, fontColor: isDisabled ? Colors.grey : Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
