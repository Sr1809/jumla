import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/common_appbar.dart';
import '../../../../common/common_button.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_styles.dart';


class RestoreDatabaseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(
        title: "Restore Database",
        showBackButton: true,

      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Container(
              margin: EdgeInsets.only( left: 20),
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
                top: 5,
                bottom: 5,
              ),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                border: Border.all(width: 1, color: AppColors.greyColor),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.greyColor.withOpacity(0.2), // Shadow color
                    blurRadius: 2, // Blur effect
                    spreadRadius: 1, // How much the shadow expands
                    offset: Offset(2, 2), // Shadow position (X, Y)
                  ),
                ],
              ),
              child: Text(
                  "Restore from",
                  style: AppTextStyles.regular(
                    fontSize: 16.0,
                    fontColor: AppColors.blackColor,
                  ),
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 10),
            Text(
              "A backup file is needed to restore a database. If you previously did a backup, you may find this file on your sdcard or Dropbox folders.",
              style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.blackColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: CommonFullWidthButton(text: "CANCEL",onTap: (){Get.back();},textColor: AppColors.whiteColor,),
    );
  }
}
