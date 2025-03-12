import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/resources/app_assets.dart';

import '../../../common/common_appbar.dart';
import '../../../resources/app_styles.dart';
import '../controllers/dropbox_controller.dart';
import '../../../core/app_storage.dart';

class DropboxView extends GetView<DropboxController> {
  const DropboxView({super.key});

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
      appBar: CommonAppBar(title: "Dropbox Setup"),
      body: Center(
        child: Container(
          width: containerWidth, // ✅ Adjusts width dynamically
          padding: EdgeInsets.all(paddingSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// **Dropbox Connection Section**
              Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Connected to Dropbox",
                    style: AppTextStyles.bold(fontSize: textSize, fontColor: AppStorages.appColor.value),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: controller.isConnected.value
                        ? () => controller.isConnected.value = false
                        : null,
                    icon: Image.asset(AppAssets.dropbox, height: 28, width: 28, color: Colors.white),
                    label: Text(
                      "Disconnect from Dropbox",
                      style: AppTextStyles.regular(fontSize: textSize * 0.8, fontColor: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppStorages.appColor.value,
                      disabledForegroundColor: Colors.grey,
                      disabledBackgroundColor: Colors.grey.withOpacity(0.6),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ],
              )),

              /// **Divider**
              Container(
                margin: EdgeInsets.only(top: paddingSize),
                width: double.infinity,
                height: 2,
                color: AppStorages.appColor.value,
              ),

              /// **Dropbox Information Section**
              SizedBox(height: paddingSize),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                    title: "Dropbox is a convenient way to pass MobileBiz data from one device (or PC) to another.",
                    textSize: textSize,
                  ),
                  _buildSection(
                    title: "Backup and Restore",
                    textSize: textSize,
                    isTitle: true,
                  ),
                  _buildSection(
                    title: "Data backups are stored to Dropbox. These backups are restored back from Dropbox when necessary.",
                    textSize: textSize * 0.8,
                  ),
                  _buildSection(
                    title: "Import and Export",
                    textSize: textSize,
                    isTitle: true,
                  ),
                  _buildSection(
                    title: "Export sales, items, and customers from this device to Dropbox. Edit items/customers on your PC, then import them back using Dropbox.",
                    textSize: textSize * 0.8,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// **Reusable Section Widget**
  Widget _buildSection({required String title, required double textSize, bool isTitle = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        style: isTitle
            ? AppTextStyles.bold(fontSize: textSize, fontColor: AppStorages.appColor.value)
            : AppTextStyles.regular(fontSize: textSize, fontColor: Colors.black),
      ),
    );
  }
}
