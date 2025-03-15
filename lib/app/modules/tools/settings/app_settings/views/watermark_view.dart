import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/resources/app_colors.dart';
import '../../../../../common/common_appbar.dart';
import '../../../../../common/common_text_field.dart';
import '../../../../../core/app_storage.dart';
import '../../../../../resources/app_styles.dart';

class WatermarkSettingsController extends GetxController {
  RxString selectedDocument = "Quote".obs;
  RxBool showOnPdf = true.obs;
  Rx<TextEditingController> closedLostController =
      TextEditingController(text: "").obs;
  Rx<TextEditingController> proposalController =
      TextEditingController(text: "").obs;
  Rx<TextEditingController> negotiationController =
      TextEditingController(text: "").obs;
  Rx<TextEditingController> purchasingController =
      TextEditingController(text: "").obs;
  Rx<TextEditingController> closedWonController =
      TextEditingController(text: "").obs;
}

class WatermarkSettingsScreen extends StatelessWidget {
  final WatermarkSettingsController controller =
  Get.put(WatermarkSettingsController());

  @override
  Widget build(BuildContext context) {
    double paddingSize = MediaQuery.of(context).size.width > 600 ? 40.0 : 20.0;
    double titleFontSize =
    MediaQuery.of(context).size.width > 600 ? 25.0 : 16.0;
    double subtitleFontSize =
    MediaQuery.of(context).size.width > 600 ? 22.0 : 13.0;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Watermarks",
        showBackButton: true,
        hideLogo: true,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.save,color: AppColors.whiteColor,))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingSize, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => ListTile(
                title: Text(
                  "Apply to",
                  style: AppTextStyles.bold(
                      fontSize: titleFontSize,
                      fontColor: AppColors.blackColor),
                ),
                subtitle: DropdownButton<String>(
                  value: controller.selectedDocument.value,
                  isExpanded: true,
                  dropdownColor: AppColors.whiteColor,
                  icon: Icon(Icons.arrow_drop_down,
                      color: AppStorages.appColor.value),
                  style: AppTextStyles.regular(
                      fontSize: subtitleFontSize,
                      fontColor: AppColors.blackColor),
                  items: [
                    "Quote",
                    "Sales Order",
                    "Invoice",
                    "Cash Sale",
                    "Purchase Order"
                  ]
                      .map((item) => DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: AppTextStyles.regular(
                          fontSize: subtitleFontSize,
                          fontColor: AppColors.blackColor),
                    ),
                  ))
                      .toList(),
                  onChanged: (value) {
                    controller.selectedDocument.value = value!;
                  },
                ),
              )),
              SizedBox(height: 10),
              Text(
                "Watermark Text",
                style: AppTextStyles.bold(
                    fontSize: titleFontSize, fontColor: AppColors.blackColor),
              ),
              CommonTextFieldWithTitle(
                label: "Closed Lost",
                controller: controller.closedLostController.value,
                hint: "Enter text",
              ),
              CommonTextFieldWithTitle(
                label: "Proposal",
                controller: controller.proposalController.value,
                hint: "Enter text",
              ),
              CommonTextFieldWithTitle(
                label: "In Negotiation",
                controller: controller.negotiationController.value,
                hint: "Enter text",
              ),
              CommonTextFieldWithTitle(
                label: "Purchasing",
                controller: controller.purchasingController.value,
                hint: "Enter text",
              ),
              CommonTextFieldWithTitle(
                label: "Closed Won",
                controller: controller.closedWonController.value,
                hint: "Enter text",
              ),
              SizedBox(height: 10),
              Obx(() => ListTile(
                title: Text(
                  "Show on PDF printout",
                  style: AppTextStyles.regular(
                      fontSize: subtitleFontSize,
                      fontColor: AppColors.blackColor),
                ),
                trailing: Checkbox(
                  value: controller.showOnPdf.value,
                  activeColor: AppStorages.appColor.value,
                  onChanged: (value) {
                    controller.showOnPdf.value = value!;
                  },
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
