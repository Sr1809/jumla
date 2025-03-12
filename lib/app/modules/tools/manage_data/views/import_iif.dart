import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/common/common_button.dart';

import '../../../../common/common_appbar.dart';
import '../../../../resources/app_styles.dart';
import '../../../../core/app_storage.dart';
import '../controllers/manage_data_controller.dart';

class QuickbooksImportScreen extends StatelessWidget {
  final ManageDataController controller = Get.put(ManageDataController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    double textSize = isTablet ? 30.0 : 18.0;
    double paddingSize = isTablet ? 40.0 : 20.0;
    double buttonHeight = isTablet ? 70 : 40;
    double containerWidth = isTablet ? screenWidth * 0.7 : screenWidth * 0.9;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "QuickBooks Import",
        showBackButton: true,
        hideLogo: true,
      ),
      body: Center(
        child: Container(
          width: containerWidth, // ✅ Responsive width
          padding: EdgeInsets.all(paddingSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// **Description**
              Text(
                "This will import contents of an IIF file into your MobileBiz data. Non-existing records will be created and existing records will be updated.",
                style: AppTextStyles.regular(fontSize: textSize, fontColor: Colors.black),
              ),
              SizedBox(height: paddingSize / 2),

              /// **IIF File Selection**
              Center(
                child: CommonElevatedButton(
                  text: "Select IIF File",
                  onPressed: () {
                    showCSVFileLocationPopup(context, controller.selectedFileLocation);
                  },
                  backgroundColor: AppStorages.appColor.value,
                  textColor: Colors.white,
                  fontSize: isTablet ? 18.0 : 14.0,
                ),
              ),
            ],
          ),
        ),
      ),

      /// **Done Button**
      bottomNavigationBar: CommonFullWidthButton(
        text: "DONE",
        onTap: () => Get.back(),
      ),
    );
  }

  /// **Show File Location Selection Popup**
  void showCSVFileLocationPopup(BuildContext context, RxString selectedFileLocation) {
    List<String> locations = ["Sdcard", "Dropbox"];

    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    double textSize = isTablet ? 30.0 : 18.0;

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(isTablet ? 40 : 20), // ✅ Adjust padding based on screen size
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// **Title & Divider**
              Text(
                "Select Data File Location",
                style: AppTextStyles.bold(fontSize: textSize, fontColor: AppStorages.appColor.value),
              ),
              SizedBox(height: 5),
              Divider(color: AppStorages.appColor.value, thickness: 2),
              SizedBox(height: 10),

              /// **File Location List**
              Column(
                children: locations.map((location) {
                  return ListTile(
                    title: Text(
                      location,
                      style: AppTextStyles.regular(fontSize: textSize * 0.8, fontColor: Colors.black),
                    ),
                    onTap: () {
                      selectedFileLocation.value = location;
                      Get.back();
                    },
                  );
                }).toList(),
              ),

              /// **Cancel Button**
              SizedBox(height: 10),
              Center(
                child: TextButton(
                  onPressed: () => Get.back(),
                  child: Text("Cancel", style: AppTextStyles.bold(fontSize: textSize * 0.8, fontColor: Colors.black)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
