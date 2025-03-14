import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/common_appbar.dart';
import '../../../../../resources/app_styles.dart';
import '../../../../../core/app_storage.dart';
import '../controllers/app_settings_controller.dart';

class CompanyLogoScreen extends GetView<AppSettingsController> {
  const CompanyLogoScreen({super.key});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    double textSize = isTablet ? 30.0 : 18.0;
    double paddingSize = isTablet ? 40.0 : 20.0;
    double buttonHeight = isTablet ? 70 : 40;
    double buttonFontSize = isTablet ? 22.0 : 16.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Company Logo",
        showBackButton: true,
        hideLogo: true,
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: Colors.white),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(paddingSize),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => controller.logoPath.value.isNotEmpty
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  controller.logoPath.value,
                  width: isTablet ? 200 : 150,
                  height: isTablet ? 200 : 150,
                  fit: BoxFit.cover,
                ),
              )
                  : GestureDetector(
                onTap: () => _showLogoOptions(context),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: buttonHeight * 0.3, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[300],
                  ),
                  child: Text(
                    "Click to add logo",
                    style: AppTextStyles.bold(
                        fontSize: buttonFontSize, fontColor: Colors.black),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoOptions(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: Text(
          "Picture Options",
          style: AppTextStyles.bold(fontSize: 18.0, fontColor: Colors.blue),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildOption("View Full Picture", ),
            _buildOption("Take Picture", ),
            _buildOption("Get from Gallery",),
            _buildOption("Remove Logo",),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("Cancel",
                style: AppTextStyles.regular(fontSize: 16.0, fontColor: Colors.black)),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(String title, ) {
    return ListTile(
      title: Text(title, style: AppTextStyles.regular(fontSize: 16.0, fontColor: Colors.black)),
      onTap: () {
        Get.back();
      },
    );
  }
}
