import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/resources/app_colors.dart';
import '../../../../../common/common_appbar.dart';
import '../../../../../resources/app_styles.dart';
import '../../../../../core/app_storage.dart';
import '../controllers/app_settings_controller.dart';

class DefaultTermsView extends GetView<AppSettingsController> {
  const DefaultTermsView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    double textSize = isTablet ? 30.0 : 18.0;
    double paddingSize = isTablet ? 40.0 : 20.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Default Terms",
        showBackButton: true,
        hideLogo: true,
      ),
      body: Center(
        child: Container(
          width: screenWidth,
          padding: EdgeInsets.all(paddingSize),
          child: Obx(
                () => ListView.separated(
              itemCount: controller.terms.length,
              separatorBuilder: (context, index) => Divider(color: Colors.grey, thickness: 0.5),
              itemBuilder: (context, index) {
                var term = controller.terms[index];
                return ListTile(
                  title: Text(
                    term["title"].toString(),
                    style: AppTextStyles.bold(fontSize: textSize, fontColor: Colors.black),
                  ),
                  subtitle: Text(
                    term["subtitle"].toString(),
                    style: AppTextStyles.regular(fontSize: textSize * 0.8, fontColor: Colors.grey),
                  ),
                  trailing: Text(
                    "> ${term["days"]} days",
                    style: AppTextStyles.bold(fontSize: textSize, fontColor: AppStorages.appColor.value),
                  ),
                  onTap: () => _showEditDialog(context, index),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  /// **Show Dialog for Editing Days**
  void _showEditDialog(BuildContext context, int index) {
    TextEditingController textController = TextEditingController();
    textController.text = controller.terms[index]["days"].toString();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Enter number of days",
            style: AppTextStyles.bold(fontSize: 20.0, fontColor: AppStorages.appColor.value),
          ),
          content: TextField(
            controller: textController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text("Cancel",style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.blackColor),),
            ),
            TextButton(
              onPressed: () {
                controller.updateDays(index, int.parse(textController.text));
                Get.back();
              },
              child: Text("OK",style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppStorages.appColor.value),),
            ),
          ],
        );
      },
    );
  }
}
