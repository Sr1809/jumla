import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/core/app_storage.dart';
import 'package:jumla/app/resources/app_assets.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:jumla/app/resources/app_styles.dart';
import 'package:jumla/app/routes/app_pages.dart';
import '../controllers/company_info_note_controller.dart';

class CompanyInfoNoteView extends GetView<CompanyInfoNoteController> {
  const CompanyInfoNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600; // Detect if the device is a tablet

    double textSize = isTablet ? 30.0 : 18.0; // Adjust font size for tablets
    double paddingSize = isTablet ? 40.0 : 20.0; // Increased padding for tablets

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(AppAssets.logo, height: isTablet ? 50 : 30, width: isTablet ? 150 : 100),
          ],
        ),
        backgroundColor: AppStorages.appColor.value,
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            width: isTablet ? screenWidth * 0.7 : screenWidth, // Adjust width dynamically
            padding: EdgeInsets.all(paddingSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Please fill up some basic information about your company.",
                  style: AppTextStyles.regular(fontSize: textSize, fontColor: AppColors.blackColor),
                ),
                SizedBox(height: 10),
                Text(
                  "You can change these information later on the Settings screen.",
                  style: AppTextStyles.regular(fontSize: textSize, fontColor: AppColors.blackColor),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color:  AppStorages.appColor.value,
        padding: EdgeInsets.symmetric(horizontal: paddingSize, vertical: 10),
        child: InkWell(
          onTap: () {
            Get.toNamed(Routes.ADD_COMPANY_NAME_ADDRESS);
          },
          child: SizedBox(
            width: double.infinity,
            height: isTablet ? 70 : 30, // Slightly bigger button on tablets
            child: Center(
              child: Text(
                "NEXT",
                style: AppTextStyles.bold(fontSize: isTablet ? 30.0 : 18.0, fontColor: AppColors.whiteColor),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
