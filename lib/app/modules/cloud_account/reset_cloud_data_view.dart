import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/app_storage.dart';
import '../../resources/app_styles.dart';
import '../../common/common_appbar.dart';

class ResetCloudDataController extends GetxController {
  var isUploading = false.obs;

  /// **Upload Cloud Data**
  void uploadCloudData() async {
    isUploading.value = true;
    await Future.delayed(Duration(seconds: 3)); // Simulate upload process
    isUploading.value = false;

    Get.snackbar(
      "Upload Completed",
      "New company data has been uploaded successfully!",
      backgroundColor: Get.theme.primaryColor,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}




class ResetCloudDataView extends GetView<ResetCloudDataController> {
  const ResetCloudDataView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    double paddingSize = isTablet ? 40.0 : 20.0;
    double titleFontSize = isTablet ? 26.0 : 20.0;
    double textFontSize = isTablet ? 18.0 : 14.0;
    double buttonHeight = isTablet ? 70.0 : 50.0;
    double iconSize = isTablet ? 30.0 : 24.0;
var controller = Get.put(ResetCloudDataController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: "Reset Cloud Data", showBackButton: true),
      body: Padding(
        padding: EdgeInsets.all(paddingSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// **Header Title**
            Text(
              "Reset Cloud Data",
              style: AppTextStyles.bold(
                fontSize: titleFontSize,
                fontColor: AppStorages.appColor.value,
              ),
            ),
            SizedBox(height: 5),

            /// **Description Text**
            Text(
              "Overwrite your cloud data with the data currently on this device.",
              style: AppTextStyles.regular(fontSize: textFontSize, fontColor: Colors.black),
            ),
            SizedBox(height: 10),
            Text(
              "This is usually done if a backup file is restored into this device and you want it to be your new company data.",
              style: AppTextStyles.regular(fontSize: textFontSize, fontColor: Colors.black),
            ),
            SizedBox(height: 30),

            /// **Upload Button with Loading Indicator**
            Obx(() => ElevatedButton.icon(
              onPressed: controller.isUploading.value ? null : controller.uploadCloudData,
              icon: controller.isUploading.value
                  ? SizedBox(width: iconSize, height: iconSize, child: CircularProgressIndicator(color: Colors.white))
                  : Icon(Icons.cloud_upload, size: iconSize, color: Colors.white),
              label: Text(
                controller.isUploading.value ? "Uploading..." : "Upload new company data",
                style: AppTextStyles.bold(fontSize: textFontSize, fontColor: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppStorages.appColor.value,
                minimumSize: Size(double.infinity, buttonHeight),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
