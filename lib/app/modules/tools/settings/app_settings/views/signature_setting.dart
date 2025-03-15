import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/resources/app_colors.dart';
import '../../../../../common/common_appbar.dart';
import '../../../../../core/app_storage.dart';
import '../../../../../resources/app_styles.dart';

class SignatureSettingsController extends GetxController {
  RxBool enableSignatures = true.obs;
  RxString signatureSize = "30".obs;
  RxString signatureText = "I agree to all information presented on this transaction.".obs;

  void showSignatureSizeDialog(BuildContext context) {
    TextEditingController textController = TextEditingController(text: signatureSize.value);

    Get.defaultDialog(
      title: "Scale the signature size",
      backgroundColor: AppColors.whiteColor,
      titleStyle: AppTextStyles.bold(fontSize: 20.0, fontColor: Colors.black),
      contentPadding: EdgeInsets.all(10),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Enter a percentage number. The captured signature is scaled to this size. Recommended values: for phones, use 30 and for tablets use 10.",
            style: AppTextStyles.regular(fontSize: 14.0, fontColor: Colors.black),
          ),
          SizedBox(height: 10),
          TextField(
            controller: textController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      confirm: TextButton(
        onPressed: () {
          signatureSize.value = textController.text;
          Get.back();
        },
        child: Text("OK", style: AppTextStyles.bold(fontSize: 16.0, fontColor: Colors.blue)),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: Text("Cancel", style: AppTextStyles.bold(fontSize: 16.0, fontColor: Colors.red)),
      ),
    );
  }

  void showSignatureTextDialog(BuildContext context) {
    TextEditingController textController = TextEditingController(text: signatureText.value);

    Get.defaultDialog(
      title: "Signature text",
      contentPadding: EdgeInsets.all(10),
      backgroundColor: AppColors.whiteColor,
      titleStyle: AppTextStyles.bold(fontSize: 20.0, fontColor: Colors.black),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "The text below is displayed near the signature.",
            style: AppTextStyles.regular(fontSize: 14.0, fontColor: Colors.black),
          ),
          SizedBox(height: 10),
          TextField(
            controller: textController,
            maxLines: 3,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      confirm: TextButton(
        onPressed: () {
          signatureText.value = textController.text;
          Get.back();
        },
        child: Text("OK", style: AppTextStyles.bold(fontSize: 16.0, fontColor: Colors.blue)),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: Text("Cancel", style: AppTextStyles.bold(fontSize: 16.0, fontColor: Colors.red)),
      ),
    );
  }
}

class SignatureSettingsScreen extends StatelessWidget {
  final SignatureSettingsController controller = Get.put(SignatureSettingsController());

  @override
  Widget build(BuildContext context) {
    double paddingSize = MediaQuery.of(context).size.width > 600 ? 40.0 : 20.0;
    double titleFontSize = MediaQuery.of(context).size.width > 600 ? 25.0 : 16.0;
    double subtitleFontSize = MediaQuery.of(context).size.width > 600 ? 22.0 : 13.0;
    double checkboxSize = MediaQuery.of(context).size.width > 600 ? 40 : 24;
    double checkboxIconSize = MediaQuery.of(context).size.width > 600 ? 30 : 20;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Signature Settings",
        showBackButton: true,
        hideLogo: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingSize, vertical: 10),
        child: Column(
          children: [
             ListTile(
              title: Text(
                "Enable signatures",
                style: AppTextStyles.regular(fontSize: titleFontSize, fontColor: Colors.black),
              ),
              subtitle: Text(
                "Capture signatures on transactions",
                style: AppTextStyles.regular(fontSize: subtitleFontSize, fontColor: Colors.grey),
              ),
              trailing: Obx(()=>GestureDetector(
                onTap: () => controller.enableSignatures.value = !controller.enableSignatures.value,
                child: Container(
                  width: checkboxSize,
                  height: checkboxSize,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: controller.enableSignatures.value
                      ? Center(
                    child: Icon(Icons.check, color: AppStorages.appColor.value, size: checkboxIconSize),
                  )
                      : null,
                ),
              ),
            )),
            Divider(),
            ListTile(
              title: Text(
                "Signature size",
                style: AppTextStyles.regular(fontSize: titleFontSize, fontColor: Colors.black),
              ),
              subtitle:  Text(
                "The captured signature is scaled to this size. Recommended values: for phones, use 30 and for tablets use 10.",
                style: AppTextStyles.regular(fontSize: subtitleFontSize, fontColor: Colors.grey),
              ),
              onTap: () => controller.showSignatureSizeDialog(context),
            ),
            Divider(),
            ListTile(
              title: Text(
                "Signature text",
                style: AppTextStyles.regular(fontSize: titleFontSize, fontColor: Colors.black),
              ),
              subtitle:  Text(
                "Enter text to describe why you are requesting a signature.",
                style: AppTextStyles.regular(fontSize: subtitleFontSize, fontColor: Colors.grey),
              ),
              onTap: () => controller.showSignatureTextDialog(context),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
