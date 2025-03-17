import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/common_appbar.dart';
import '../../core/app_storage.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_styles.dart';


class SyncOptionsController extends GetxController {
  var syncOnStartup = false.obs;
  var syncAutomatically = true.obs;

  void toggleSyncOnStartup() => syncOnStartup.value = !syncOnStartup.value;
  void toggleSyncAutomatically() => syncAutomatically.value = !syncAutomatically.value;

  void saveSettings() {
    Get.snackbar(
      "Settings Saved",
      "Your sync preferences have been updated.",
      backgroundColor: Get.theme.primaryColor,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}


class SyncOptionsView extends GetView<SyncOptionsController> {
  const SyncOptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    double paddingSize = isTablet ? 40.0 : 20.0;
    double titleFontSize = isTablet ? 26.0 : 20.0;
    double textFontSize = isTablet ? 18.0 : 16.0;
    double iconSize = isTablet ? 30.0 : 24.0;
    double checkboxSize = isTablet ? 32.0 : 24.0;
    var controller = Get.put(SyncOptionsController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: "Sync Options",
        showBackButton: true,
       actions: [
         IconButton(onPressed: ()=>controller.saveSettings, icon: Icon(Icons.save,color: AppColors.whiteColor,))
       ],
      ),
      body: Padding(
        padding: EdgeInsets.all(paddingSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// **Sync on Startup**
            Obx(() => _customCheckbox(
              "Sync on startup",
              controller.syncOnStartup,
              isTablet,
              isDisabled: true, // This option is disabled
            )),
            SizedBox(height: 10),

            /// **Sync Automatically**
            Obx(() => _customCheckbox(
              "Sync automatically",
              controller.syncAutomatically,
              isTablet,
            )),
          ],
        ),
      ),
    );
  }

  /// **Custom Checkbox Widget**
  Widget _customCheckbox(String label, RxBool value, bool isTablet, {bool isDisabled = false}) {
    return GestureDetector(
      onTap: isDisabled ? null : () => value.value = !value.value,
      child: Row(
        children: [
          Container(
            width: isTablet ? 32 : 24,
            height: isTablet ? 32 : 24,
            decoration: BoxDecoration(
              color: isDisabled ? Colors.grey.shade300 : Colors.white,
              border: Border.all(color: isDisabled ? Colors.grey : AppColors.blackColor, width: 2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: value.value
                ? Icon(Icons.check, color: AppStorages.appColor.value, size: isTablet ? 22 : 18)
                : null,
          ),
          SizedBox(width: 10),
          Text(
            label,
            style: AppTextStyles.bold(
              fontSize: isTablet ? 20.0 : 16.0,
              fontColor: isDisabled ? Colors.grey : AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }
}