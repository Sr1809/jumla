import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/modules/tools/manage_data/views/restore_database.dart';

import '../../../../common/common_appbar.dart';
import '../../../../resources/app_styles.dart';
import '../controllers/manage_data_controller.dart';
import '../../../../core/app_storage.dart';
import 'backup_database_view.dart';
import 'export_csv.dart';
import 'import_csv.dart';
import 'import_iif.dart';

class ManageDataView extends GetView<ManageDataController> {
  const ManageDataView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    double textSize = isTablet ? 30.0 : 18.0;
    double paddingSize = isTablet ? 20.0 : 20.0;
    double containerWidth =  screenWidth ;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Manage data",
        showBackButton: false,
        actions: [
          InkWell(
            onTap: () => Get.back(),
            child: Icon(Icons.close, color: Colors.white),
          )
        ],
      ),
      body: Center(
        child: Container(
          width: containerWidth, // ✅ Responsive width
          padding: EdgeInsets.all(paddingSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection("DATABASE", textSize, [
                {"label": "Backup database", "onTap": () => Get.to(() => BackupDatabaseView())},
                {"label": "Restore database", "onTap": () => Get.to(() => RestoreDatabaseScreen())},
                {"label": "Delete all data", "onTap": () => showConfirmDeletePopup(context)},
              ]),
              SizedBox(height: paddingSize / 2),
              _buildSection("IMPORT/EXPORT", textSize, [
                {"label": "Export CSV", "onTap": () => Get.to(() => ExportCSVScreen())},
                {"label": "Import CSV", "onTap": () => Get.to(() => ImportCSVScreen())},
                {"label": "Import IIF (Quickbooks)", "onTap": () => Get.to(() => QuickbooksImportScreen())},
              ]),
            ],
          ),
        ),
      ),
    );
  }

  /// **Show Confirm Delete Popup (Responsive)**
  void showConfirmDeletePopup(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    double textSize = isTablet ? 30.0 : 18.0;
    double buttonHeight = isTablet ? 70 : 40;
    double dialogWidth = isTablet ? screenWidth * 0.5 : screenWidth * 0.8; // ✅ Adjust width dynamically

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        child: SizedBox(
          width: dialogWidth, // ✅ Responsive width
          child: Padding(
            padding: EdgeInsets.all(isTablet ? 40 : 20), // ✅ Adjust padding based on screen size
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// **Title & Divider**
                Text(
                  "Confirm",
                  style: AppTextStyles.bold(fontSize: textSize, fontColor: AppStorages.appColor.value),
                ),
                SizedBox(height: 5),
                Divider(color: AppStorages.appColor.value, thickness: 2),
                SizedBox(height: 10),

                /// **Message**
                Text(
                  "You are about to delete all data of Test on this device. Are you sure?",
                  style: AppTextStyles.regular(fontSize: textSize * 0.8, fontColor: Colors.black),
                ),
                SizedBox(height: 20),

                /// **Buttons**
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildPopupButton("No", textSize, Colors.grey, buttonHeight, () => Get.back()),
                    _buildPopupButton("Yes", textSize, AppStorages.appColor.value, buttonHeight, () => Get.back()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// **Popup Button**
  Widget _buildPopupButton(String text, double textSize, Color color, double buttonHeight, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        text,
        style: AppTextStyles.bold(fontSize: textSize * 0.8, fontColor: Colors.white),
      ),
    );
  }




  /// **Reusable Section**
  Widget _buildSection(String title, double textSize, List<Map<String, dynamic>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// **Title**
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            title,
            style: AppTextStyles.bold(fontSize: textSize, fontColor: AppStorages.appColor.value),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Divider(color: AppStorages.appColor.value, thickness: 2),
        ),

        /// **List Items**
        ...items.map((item) => ListTile(
          title: Text(
            item["label"],
            style: AppTextStyles.regular(fontSize: textSize * 0.8, fontColor: Colors.black),
          ),
          onTap: item["onTap"],
        )),
      ],
    );
  }
}
