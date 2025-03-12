import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/resources/app_colors.dart';
import '../../../../common/common_appbar.dart';
import '../../../../common/common_button.dart';
import '../../../../resources/app_styles.dart';
import '../../../../core/app_storage.dart';

class RestoreDatabaseScreen extends StatelessWidget {
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
      appBar: CommonAppBar(
        title: "Restore Database",
        showBackButton: true,
      ),
      body: Center(
        child: Container(
          width: containerWidth, // ✅ Responsive width
          padding: EdgeInsets.all(paddingSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// **Restore From Section**
              Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: AppStorages.appColor.value,
                  borderRadius: BorderRadius.circular(8.0)
                ),
                child: Text(
                  "Restore from",
                  style: AppTextStyles.regular(fontSize: textSize, fontColor: AppColors.whiteColor),
                ),
              ),
              SizedBox(height: paddingSize / 2),

              /// **Divider**
              Divider(),
              SizedBox(height: paddingSize / 4),

              /// **Restore Instructions**
              Text(
                "A backup file is needed to restore a database. If you previously did a backup, you may find this file on your sdcard or Dropbox folders.",
                style: AppTextStyles.regular(fontSize: textSize * 0.8, fontColor: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),

      /// **Cancel Button**
      bottomNavigationBar: CommonFullWidthButton(
        text: "CANCEL",
        onTap: () => Get.back(),
        textColor: Colors.white,
      ),
    );
  }
}
