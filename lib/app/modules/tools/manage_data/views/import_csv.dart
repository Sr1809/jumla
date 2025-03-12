import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/common_appbar.dart';
import '../../../../common/common_button.dart';
import '../../../../resources/app_styles.dart';
import '../../../../core/app_storage.dart';
import '../controllers/manage_data_controller.dart';

class ImportCSVScreen extends StatelessWidget {
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
        title: "Import CSV",
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// **Record to Import Section**
              _buildSelectionSection(
                context,
                title: "Record to import",
                selectedValue: controller.selectedRecordForImport,
                onTap: () => showRecordSelectionPopup(context, controller.selectedRecordForImport),
                isTablet: isTablet,
              ),
              SizedBox(height: paddingSize / 2),

              /// **File Location Selection**
              Row(
                children: [
                  InkWell(
                    onTap: () => showRecordSelectionPopup(context, controller.selectedFileLocation),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: Obx(() => Text(
                        controller.selectedFileLocation.value,
                        style: AppTextStyles.bold(fontSize: textSize * 0.8, fontColor: Colors.black),
                      )),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Required",
                    style: AppTextStyles.regular(fontSize: textSize * 0.8, fontColor: Colors.red),
                  ),
                ],
              ),
              SizedBox(height: paddingSize / 2),

              /// **Buttons Section**
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildActionButton("Import One", AppStorages.appColor.value, Colors.white, isTablet),
                  _buildActionButton("Import All", AppStorages.appColor.value, Colors.white, isTablet),
                  _buildActionButton("Cancel",  Colors.white38, Colors.black, isTablet, () => Get.back()),
                ],
              ),
              SizedBox(height: paddingSize / 2),

              /// **Import Instructions**
              Text(
                "To import custom fields, simply include the custom field Label as columns on the data file.\n\nFor example, you have a custom item field called Item Weight.\n\nIf your data file includes an ITEM WEIGHT header, its value is imported into the Item Weight field of the item record.",
                style: AppTextStyles.regular(fontSize: textSize * 0.7, fontColor: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// **Reusable Selection Section**
  Widget _buildSelectionSection(BuildContext context,
      {required String title, required RxString selectedValue, required VoidCallback onTap, required bool isTablet}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppTextStyles.regular(fontSize: isTablet ? 24.0 : 16.0, fontColor: Colors.black),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: AppStorages.appColor.value,
            ),
            child: Obx(() => Text(
              selectedValue.value,
              style: AppTextStyles.regular(fontSize: isTablet ? 24.0 : 16.0, fontColor: Colors.white),
            )),
          ),
        ),
      ],
    );
  }

  /// **Reusable Action Button**
  Widget _buildActionButton(String text, Color bgColor, Color textColor, bool isTablet, [VoidCallback? onTap]) {
    return CommonElevatedButton(
      text: text,
      onPressed: onTap ?? () {},
      backgroundColor: bgColor,
      textColor: textColor,
      fontSize: isTablet ? 18.0 : 12.0,

    );
  }
}

/// **Popup for Record Selection**
void showRecordSelectionPopup(BuildContext context, RxString selectedRecord) {
  List<String> records = ["Import items", "Import customers"];

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
              "Choose one",
              style: AppTextStyles.bold(fontSize: textSize, fontColor: AppStorages.appColor.value),
            ),
            SizedBox(height: 5),
            Divider(color: AppStorages.appColor.value, thickness: 2),
            SizedBox(height: 10),

            /// **Radio Buttons**
            Column(
              children: records.map((record) {
                return Obx(() => RadioListTile<String>(
                  title: Text(
                    record,
                    style: AppTextStyles.regular(fontSize: textSize * 0.8, fontColor: Colors.black),
                  ),
                  value: record,
                  groupValue: selectedRecord.value,
                  activeColor: AppStorages.appColor.value,
                  onChanged: (value) {
                    selectedRecord.value = value!;
                    Get.back();
                  },
                ));
              }).toList(),
            ),
          ],
        ),
      ),
    ),
  );
}
