import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jumla/app/resources/app_assets.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:jumla/app/resources/app_styles.dart';
import 'package:jumla/app/routes/app_pages.dart';

import '../controllers/company_info_note_controller.dart';

class CompanyInfoNoteView extends GetView<CompanyInfoNoteController> {
  const CompanyInfoNoteView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(AppAssets.logo, height: 30, width: 100),
          ],
        ),
        backgroundColor: AppColors.blueColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                "Please fill up some basic information about your company.",
                style: AppTextStyles.regular(fontSize: 18.0, fontColor: AppColors.blackColor),
              ),
              SizedBox(height: 10),
              Text(
                "You can change these information later on the Settings screen.",
                style: AppTextStyles.regular(fontSize: 18.0, fontColor: AppColors.blackColor),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.blueColor,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: GestureDetector(
          onTap: (){
Get.toNamed(Routes.ADD_COMPANY_NAME_ADDRESS);
          },
          child: SizedBox(
            width: double.infinity,
            height: 40,
            child: Center(
              child: Text(
                "NEXT",
                style: AppTextStyles.bold(fontSize: 18.0, fontColor: AppColors.whiteColor),
              ),
            ),
          ),
        ),
      ),

    );
  }
}
