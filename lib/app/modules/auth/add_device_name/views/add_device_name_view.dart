import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/common_appbar.dart';
import '../../../../common/common_button.dart';
import '../../../../common/common_text_field.dart';
import '../../../../core/app_storage.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_styles.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/add_device_name_controller.dart';

class AddDeviceNameView extends GetView<AddDeviceNameController> {
  const AddDeviceNameView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600; // Detect if the device is a tablet

    double textSize = isTablet ? 28.0 : 18.0; // Adjust font size
    double paddingSize = isTablet ? 40.0 : 20.0; // Adjust padding
    double fieldWidth = isTablet ? screenWidth * 0.7 : screenWidth ; // Adjust form width
    double appBarTextSize = isTablet ? 30.0 : 18.0; // Adjust AppBar text size
    double buttonHeight = isTablet ? 70 : 30; // Adjust button height

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: 'Device Info', showBackButton: true),

      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: fieldWidth, // Adjust width dynamically
            padding: EdgeInsets.all(paddingSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextFieldWithTitle(
                  label: "Device name",
                  hint: "eg. MYNAME-VIVO 1933",
                  controller: controller.deviceNameController,
                ),
                SizedBox(height: paddingSize / 2),

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
                              fontSize: textSize,
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
        ),
      ),

      bottomNavigationBar: Get.arguments =="setting"?CommonSaveAndNextButton(): Container(
        color: AppColors.blueColor,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavButton("NEXT", Routes.HOME, textSize, buttonHeight),
            SizedBox(width: 10),
            _buildNavButton("BACK", null, textSize, buttonHeight),
          ],
        ),
      ),
    );
  }

  /// **Navigation Button (NEXT / BACK)**
  Widget _buildNavButton(String text, String? route, double textSize, double buttonHeight) {
    return Flexible(
      child: InkWell(
        onTap: route != null ? () => Get.toNamed(route) : Get.back,
        child: SizedBox(
          width: double.infinity,
          height: buttonHeight,
          child: Center(
            child: Text(
              text,
              style: AppTextStyles.bold(fontSize: textSize, fontColor: AppColors.whiteColor),
            ),
          ),
        ),
      ),
    );
  }
}
