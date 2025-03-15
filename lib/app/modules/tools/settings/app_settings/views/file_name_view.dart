import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/resources/app_colors.dart';
import '../../../../../common/common_appbar.dart';
import '../../../../../core/app_storage.dart';
import '../../../../../resources/app_styles.dart';

class FileNamesController extends GetxController {
  RxBool enableCustomFilenames = false.obs;
  RxString salesFilename = "".obs;
  RxString paymentsFilename = "".obs;
}

class FileNamesScreen extends StatelessWidget {
  final FileNamesController controller = Get.put(FileNamesController());

  @override
  Widget build(BuildContext context) {
    double paddingSize = MediaQuery.of(context).size.width > 600 ? 40.0 : 20.0;
    double titleFontSize = MediaQuery.of(context).size.width > 600 ? 25.0 : 16.0;
    double subtitleFontSize = MediaQuery.of(context).size.width > 600 ? 22.0 : 13.0;
    double checkboxSize = MediaQuery.of(context).size.width > 600 ? 40 : 24;
    double checkboxIconSize = MediaQuery.of(context).size.width > 600 ? 30 : 20;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "File Names",
        showBackButton: true,
        hideLogo: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingSize, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCheckboxWithTitle(),
            SizedBox(height: 20),
            _buildTextField("File name for sales", controller.salesFilename, isEnabled: controller.enableCustomFilenames),
            SizedBox(height: 10),
            _buildTextField("File name for payments", controller.paymentsFilename, isEnabled: controller.enableCustomFilenames),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxWithTitle() {
    return Obx(() => GestureDetector(
      onTap: () => controller.enableCustomFilenames.value = !controller.enableCustomFilenames.value,
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: controller.enableCustomFilenames.value
                ? Center(
              child: Icon(Icons.check, color: AppStorages.appColor.value, size: 20),
            )
                : null,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Enable custom filenames",
                  style: AppTextStyles.bold(fontSize: 18.0, fontColor: Colors.black),
                ),
                SizedBox(height: 4),
                Text(
                  "If checked, sale and payment filenames can be overridden by filling up the next two options below.",
                  style: AppTextStyles.regular(fontSize: 14.0, fontColor: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildTextField(String title, RxString value, {required RxBool isEnabled}) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.bold(
            fontSize: 16.0,
            fontColor: isEnabled.value ? Colors.black : Colors.grey,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "File name format used when generating ${title.toLowerCase()} on sdcard. MobileBiz tags can be used here.",
          style: AppTextStyles.regular(
            fontSize: 14.0,
            fontColor: Colors.grey,
          ),
        ),
        SizedBox(height: 8),
        TextField(
          enabled: isEnabled.value,
          onChanged: (text) => value.value = text,
          decoration: InputDecoration(
            filled: true,
            fillColor: isEnabled.value ? Colors.white : Colors.grey.shade300,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ],
    ));
  }
}
