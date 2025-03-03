import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jumla/app/resources/app_assets.dart';

import '../../../common/common_appbar.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_styles.dart';
import '../controllers/dropbox_controller.dart';

class DropboxView extends GetView<DropboxController> {
  const DropboxView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: "Dropbox Setup"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Connected to Dropbox",
                  style: AppTextStyles.bold(fontSize: 18.0, fontColor: AppColors.blueColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: controller.isConnected.value
                      ? () => controller.isConnected.value = false
                      : null,
                  icon: Image.asset(AppAssets.dropbox, height: 24, width: 24,color: AppColors.whiteColor,),
                  label: Text("Disconnect from Dropbox",style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.whiteColor),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blueColor,
                    disabledForegroundColor: AppColors.greyColor,
                    disabledBackgroundColor: AppColors.greyColor.withOpacity(0.6),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ],
            )),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: Get.width,height: 2,color: AppColors.blueColor,),
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               SizedBox(height: 20),
               Text(
                 "Dropbox is a convenient way to pass MobileBiz data from one device (or PC) to another.",
                 style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor),
               ),
               SizedBox(height: 10),
               Text(
                 "Backup and Restore",
                 style: AppTextStyles.bold(fontSize: 16.0, fontColor: AppColors.blueColor),
               ),
               Text(
                 "Data backups are stored to Dropbox. These backups are restored back from Dropbox when necessary.",
                 style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.blackColor),
               ),
               SizedBox(height: 10),
               Text(
                 "Import and Export",
                 style: AppTextStyles.bold(fontSize: 16.0, fontColor: AppColors.blueColor),
               ),
               Text(
                 "Export sales, items and customers from this device to Dropbox. Edit items/customers on your PC, then import them back using Dropbox.",
                 style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.blackColor),
               ),
             ],
           )
          ],
        ),
      ),
    );
  }
}

