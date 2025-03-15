import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/resources/app_colors.dart';

import '../../../../../common/common_appbar.dart';
import '../../../../../core/app_storage.dart';
import '../../../../../resources/app_styles.dart';

class ProjectSettingsController extends GetxController {
  RxBool useProjects = true.obs;
}

class ProjectSettingsScreen extends StatelessWidget {
  final ProjectSettingsController controller = Get.put(ProjectSettingsController());
  @override
  Widget build(BuildContext context) {
    double paddingSize = MediaQuery.of(context).size.width > 600 ? 40.0 : 20.0;
    double checkboxSize = MediaQuery.of(context).size.width > 600 ? 40 : 24;
    double titleFontSize = MediaQuery.of(context).size.width > 600  ? 25.0 : 16.0;
    double subtitleFontSize = MediaQuery.of(context).size.width > 600  ? 22.0 : 13.0;
    double checkboxIconSize = MediaQuery.of(context).size.width > 600   ? 30 : 20;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Project Settings",
        showBackButton: true,
        hideLogo: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingSize, vertical: 10),
        child:  Obx(() => ListTile(
          title: Text(
            "Use projects",
            style: AppTextStyles.regular(fontSize: titleFontSize, fontColor: Colors.black),
          ),
          subtitle: Text(
            "If checked, projects can be entered on sales transactions",
            style: AppTextStyles.regular(fontSize: subtitleFontSize, fontColor: Colors.grey),
          ),
          trailing: GestureDetector(
            onTap: () => controller.useProjects.value = !controller.useProjects.value,
            child: Container(
              width: checkboxSize,
              height: checkboxSize,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: controller.useProjects.value
                  ? Center(
                child: Icon(Icons.check, color: AppStorages.appColor.value, size: checkboxIconSize),
              )
                  : null,
            ),
          ),
        )),
      ),
    );
  }
}