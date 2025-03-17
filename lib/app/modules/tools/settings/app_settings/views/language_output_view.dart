import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/resources/app_colors.dart';
import '../../../../../common/common_appbar.dart';
import '../../../../../core/app_storage.dart';
import '../../../../../resources/app_styles.dart';

class LanguageOutputController extends GetxController {
  RxString selectedLanguage = 'English'.obs;
  RxString selectedResetOption = 'Do not reset anything'.obs;
}

class LanguageOutputScreen extends StatelessWidget {
  final LanguageOutputController controller = Get.put(LanguageOutputController());

  @override
  Widget build(BuildContext context) {
    double paddingSize = MediaQuery.of(context).size.width > 600 ? 40.0 : 20.0;
    double titleFontSize = MediaQuery.of(context).size.width > 600 ? 25.0 : 16.0;
    double subtitleFontSize = MediaQuery.of(context).size.width > 600 ? 22.0 : 13.0;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Language Output",
        showBackButton: true,
        hideLogo: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingSize, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "By default, emails, SMS, and printouts are generated in English. To use another language, select it from the list below.",
              style: AppTextStyles.regular(fontSize: subtitleFontSize, fontColor: Colors.grey),
            ),
            SizedBox(height: 20),
            Obx(() => ListTile(
              title: Text(
                "${controller.selectedLanguage.value}",
                style: AppTextStyles.regular(fontSize: titleFontSize, fontColor: Colors.black),
              ),
              subtitle: Text(
                "Select the language to use for print output",
                style: AppTextStyles.regular(fontSize: subtitleFontSize, fontColor: Colors.grey),
              ),
              onTap: () => _showLanguagePopup(context),
            )),
            Divider(),
            ListTile(
              title: Text(
                "Reset templates",
                style: AppTextStyles.regular(fontSize: titleFontSize, fontColor: Colors.black),
              ),
              subtitle: Text(
                "Select which templates should be reset to support this language",
                style: AppTextStyles.regular(fontSize: subtitleFontSize, fontColor: Colors.grey),
              ),
              onTap: () => _showResetTemplatesPopup(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguagePopup(BuildContext context) {



    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select a language", style: AppTextStyles.bold(fontSize: 22.0, fontColor: AppStorages.appColor.value)),
          backgroundColor: AppColors.whiteColor,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children:[
              _buildLanguageOption("English"),
              _buildLanguageOption("French"),
              _buildLanguageOption("Italian"),
              _buildLanguageOption("German"),
              _buildLanguageOption("Portuguese"),
              _buildLanguageOption("Spanish"),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(String language) {
    return Obx(() => RadioListTile(
      title: Text(language, style: AppTextStyles.regular(fontSize: 18.0, fontColor: Colors.black)),
      value: language,
      groupValue: controller.selectedLanguage.value,
      activeColor: AppStorages.appColor.value,
      onChanged: (value) {
        controller.selectedLanguage.value = value as String;
        Get.back();
      },
    ));
  }

  void _showResetTemplatesPopup(BuildContext context) {



    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Reset templates", style: AppTextStyles.bold(fontSize: 22.0, fontColor: AppStorages.appColor.value)),
          backgroundColor: AppColors.whiteColor,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children:[
              _buildResetOption("Email and SMS templates"),
              _buildResetOption("Sale total labels"),
              _buildResetOption("Sale columns"),
              _buildResetOption("Statement template"),
              _buildResetOption("Reset all of above"),
              _buildResetOption("Do not reset anything"),
            ],
          ),
        );
      },
    );
  }

  Widget _buildResetOption(String option) {
    return Obx(() => RadioListTile(
      title: Text(option, style: AppTextStyles.regular(fontSize: 18.0, fontColor: Colors.black)),
      value: option,
      groupValue: controller.selectedResetOption.value,
      activeColor: AppStorages.appColor.value,
      onChanged: (value)
      {
        controller.selectedResetOption.value = value as String;
        Get.back();
      },
    ));
  }
}