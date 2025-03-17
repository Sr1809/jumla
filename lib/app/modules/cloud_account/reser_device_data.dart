import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/app_storage.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_styles.dart';
import '../../common/common_appbar.dart';

class ResetDeviceDataController extends GetxController {
  var isResetting = false.obs;
  var isDownloading = false.obs;

  /// **Reset Device Data**
  void resetDeviceData() async {
    isResetting.value = true;
    await Future.delayed(Duration(seconds: 3)); // Simulate process
    isResetting.value = false;

    Get.snackbar(
      "Reset Completed",
      "Device data has been reset successfully!",
      backgroundColor: Get.theme.primaryColor,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  /// **Download Files**
  void downloadFiles() async {
    isDownloading.value = true;
    await Future.delayed(Duration(seconds: 3)); // Simulate process
    isDownloading.value = false;

    Get.snackbar(
      "Download Completed",
      "Latest company logos & print templates downloaded successfully!",
      backgroundColor: Get.theme.primaryColor,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}




class ResetDeviceDataView extends GetView<ResetDeviceDataController> {
  const ResetDeviceDataView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    double paddingSize = isTablet ? 40.0 : 20.0;
    double titleFontSize = isTablet ? 26.0 : 20.0;
    double textFontSize = isTablet ? 18.0 : 14.0;
    double buttonHeight = isTablet ? 70.0 : 50.0;
    double iconSize = isTablet ? 30.0 : 24.0;
    var controller = Get.put(ResetDeviceDataController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: "Reset Device Data", showBackButton: true),
      body: Padding(
        padding: EdgeInsets.all(paddingSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// **Header Title**
            Text(
              "Reset Device Data",
              style: AppTextStyles.bold(
                fontSize: titleFontSize,
                fontColor: AppStorages.appColor.value,
              ),
            ),
            SizedBox(height: 5),

            /// **Description Text**
            Text(
              "Overwrite data on this device with the latest from your online company. Do this to get a fresh copy of data to work on. This may take a while to finish.",
              style: AppTextStyles.regular(fontSize: textFontSize, fontColor: Colors.black),
            ),
            SizedBox(height: 10),
            Text(
              "NOTE: All unsynced changes on this device will be lost.",
              style: AppTextStyles.bold(fontSize: textFontSize, fontColor: Colors.red),
            ),
            SizedBox(height: 30),

            /// **Reset Button with Loading Indicator**
            Obx(() => ElevatedButton.icon(
              onPressed: controller.isResetting.value ? null : controller.resetDeviceData,
              icon: controller.isResetting.value
                  ? SizedBox(width: iconSize, height: iconSize, child: CircularProgressIndicator(color: Colors.white))
                  : Icon(Icons.download, size: iconSize, color: Colors.white),
              label: Text(
                controller.isResetting.value ? "Resetting..." : "Reset device data",
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
            SizedBox(height: 40),

            /// **Download Files Section**
            Text(
              "Download Files",
              style: AppTextStyles.bold(
                fontSize: titleFontSize,
                fontColor: AppStorages.appColor.value,
              ),
            ),
            SizedBox(height: 5),

            /// **Download Description**
            Text(
              "Download the latest company logos and print templates from the server.",
              style: AppTextStyles.regular(fontSize: textFontSize, fontColor: Colors.black),
            ),
            SizedBox(height: 30),

            /// **Download Button**
            Obx(() => ElevatedButton.icon(
              onPressed: controller.isDownloading.value ? null : controller.downloadFiles,
              icon: controller.isDownloading.value
                  ? SizedBox(width: iconSize, height: iconSize, child: CircularProgressIndicator(color: Colors.white))
                  : Icon(Icons.insert_drive_file, size: iconSize, color: Colors.white),
              label: Text(
                controller.isDownloading.value ? "Downloading..." : "Download files",
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

