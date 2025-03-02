import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common/common_appbar.dart';
import '../../../../common/common_text_field.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_styles.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/add_device_name_controller.dart';

class AddDeviceNameView extends GetView<AddDeviceNameController> {
  const AddDeviceNameView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Device Info',showBackButton: true,),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonTextFieldWithTitle(
              label: "Device name",
              hint: "eg. MYNAME-VIVO 1933",
              controller: controller.deviceNameController,
            ),
            SizedBox(height: 10),
            Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                                    children: [
                    GestureDetector(
                      onTap: () => controller.isAppendDeviceName.value = !controller.isAppendDeviceName.value,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          border: Border.all(color: AppColors.blackColor, width: 1),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: controller.isAppendDeviceName.value
                            ? Icon(Icons.check, color: AppColors.blueColor, size: 18)
                            : null,
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: Text(
                        "Append device name on data exports",
                        style: AppTextStyles.regular(
                          fontSize: 16.0,
                          fontColor: AppColors.blackColor,
                        ),
                      ),
                    ),
                                    ],
                                  ),
                  ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.blueColor,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: InkWell(
                onTap: () {
                  Get.toNamed(Routes.HOME);
                },

                child: Text(
                  "NEXT",
                  style: AppTextStyles.bold(
                    fontSize: 16.0,
                    fontColor: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Flexible(
              child: InkWell(
                onTap: () {
                  Get.back();
                },

                child: Text(
                  "BACK",
                  style: AppTextStyles.bold(
                    fontSize: 16.0,
                    fontColor: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
