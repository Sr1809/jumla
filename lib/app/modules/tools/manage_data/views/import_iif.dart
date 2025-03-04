import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/common/common_button.dart';

import '../../../../common/common_appbar.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_styles.dart';
import '../controllers/manage_data_controller.dart';

class QuickbooksImportScreen extends StatelessWidget {
  final ManageDataController controller = Get.put(ManageDataController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Quickbooks Import",
        showBackButton: true,
        hideLogo: true,

      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "This will import contents of an IIF file into your MobileBiz data. Non-existing records will be created and existing records will be updated.",
              style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor),
            ),
            SizedBox(height: 20),
            CommonElevatedButton(
              text: "IIF file",
              onPressed: () {
                showCSVFileLocationPopup(context,controller.selectedFileLocation);
              },
              backgroundColor: AppColors.buttonColor,textColor: AppColors.blackColor,fontSize: 12,
            ),
          ],
        ),
      ),
      bottomNavigationBar: CommonFullWidthButton(
        text: "DONE",

        onTap: () => Get.back(),
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

}
