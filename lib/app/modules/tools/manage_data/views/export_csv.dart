import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/resources/app_colors.dart';
import '../../../../common/common_appbar.dart';
import '../../../../common/common_button.dart';
import '../../../../resources/app_styles.dart';
import '../../../../core/app_storage.dart';
import '../controllers/manage_data_controller.dart';

class ExportCSVScreen extends GetView<ManageDataController> {
  const ExportCSVScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ManageDataController());

    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    double textSize = isTablet ? 30.0 : 18.0;
    double paddingSize = isTablet ? 40.0 : 20.0;
    double buttonHeight = isTablet ? 70 : 40;
    double containerWidth =   screenWidth ;
    double checkboxAlignment = isTablet ? screenWidth * 0.50 : screenWidth * 0.28;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: "Export CSV",
        showBackButton: true,
      ),
      body: Center(
        child: Container(
          width: containerWidth, // ✅ Responsive width
          padding: EdgeInsets.all(paddingSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// **Record to Export Section**
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Record to export",
                      style: AppTextStyles.regular(fontSize: textSize, fontColor: AppColors.blackColor),
                    ),
                    SizedBox(height: 10),
                    GestureDetector(
                      onTap: () => showRecordSelectionPopup(context, controller.selectedRecord),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppStorages.appColor.value,
                        ),
                        child: Obx(() => Text(
                          controller.selectedRecord.value,
                          style: AppTextStyles.regular(fontSize: textSize * 0.8, fontColor: AppColors.whiteColor),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: paddingSize / 2),

              /// **Checkboxes**
              Obx(() => _customCheckbox("Save to Sdcard", controller.saveToSdCard,isTablet, alignment: checkboxAlignment)),
              SizedBox(height: 10),
              Obx(() => _customCheckbox("Send to Email", controller.sendToEmail,isTablet, alignment: checkboxAlignment)),
            ],
          ),
        ),
      ),

      /// **Bottom Buttons**
      bottomNavigationBar: Container(
        color: AppStorages.appColor.value,
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: CommonFullWidthButton(
                  text: "EXPORT",

                  onTap: () => Get.back(),
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
        ),
      ),
    );
  }

  /// **Custom Checkbox**
  Widget _customCheckbox(String label, RxBool value,isTablet, {required double alignment}) {
    return GestureDetector(
      onTap: () => value.value = !value.value,
      child: Row(
        children: [
          Container(
            width: isTablet?40:24,
            height: isTablet?40:24,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: value.value
                ? Center(child: Icon(Icons.check, color: AppStorages.appColor.value, size: isTablet?30:20))
                : null,
          ),
          SizedBox(width: 10),
          Text(
            label,
            style: AppTextStyles.regular(fontSize: 16.0, fontColor: Colors.black),
          ),
        ],
      ),
    );
  }
}

/// **Popup for Record Selection**
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
