import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/resources/app_colors.dart';

import '../../../../../common/common_appbar.dart';
import '../../../../../core/app_storage.dart';

class ProjectSettingsController extends GetxController {
  RxBool useProjects = true.obs;
}

class ProjectSettingsScreen extends StatelessWidget {
  final ProjectSettingsController controller = Get.put(ProjectSettingsController());

  @override
  Widget build(BuildContext context) {
    double textSize = MediaQuery.of(context).size.width > 600 ? 30.0 : 18.0;
    double paddingSize = MediaQuery.of(context).size.width > 600 ? 40.0 : 20.0;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Project Settings",
        showBackButton: true,
        hideLogo: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(paddingSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Use projects', style: TextStyle(fontSize: textSize, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text('If checked, projects can be entered on sales transactions',
                style: TextStyle(fontSize: textSize * 0.8, color: Colors.grey)),
            SizedBox(height: 20),
            Obx(
                  () => CheckboxListTile(
                value: controller.useProjects.value,
                onChanged: (val) {
                  controller.useProjects.value = val!;
                },
                activeColor: AppStorages.appColor.value,
                controlAffinity: ListTileControlAffinity.trailing,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
