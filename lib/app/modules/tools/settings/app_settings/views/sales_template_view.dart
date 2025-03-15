import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/app_storage.dart';
import '../../../../../resources/app_colors.dart';
import '../../../../../resources/app_styles.dart';
import '../../../../../common/common_appbar.dart';

class SalesTemplateController extends GetxController {
  var selectedText = "".obs;
}

class SalesTemplateView extends StatelessWidget {
  final SalesTemplateController controller = Get.put(SalesTemplateController());

  final List<Map<String, String>> items = [
    {"title": "Bill To", "subtitle": "Enter text that replaces the 'Bill To' label on printouts"},
    {"title": "Date", "subtitle": "Enter text that replaces the 'Date' label on printouts"},
    {"title": "Due Date", "subtitle": "Enter text that replaces the 'Due Date' label on printouts"},
    {"title": "Signed by", "subtitle": "Enter text that replaces the signature 'Date' label on printouts"},
    {"title": "Sign date", "subtitle": "Enter text that replaces the signature 'Date' label on printouts"},
    {"title": "Signature", "subtitle": "Enter text that replaces the 'Signature' label on printouts"},
    {"title": "Footer", "subtitle": "Enter text that replaces the 'Thank you for your business.' footer"},
  ];

  @override
  Widget build(BuildContext context) {
    double titleFontSize = MediaQuery.of(context).size.width > 600 ? 22.0 : 18.0;
    double subtitleFontSize = MediaQuery.of(context).size.width > 600 ? 20.0 : 14.0;
    double paddingSize = MediaQuery.of(context).size.width > 600 ? 30.0 : 20.0;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Change text",
        showBackButton: true,
        hideLogo: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(paddingSize),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  items[index]['title']!,
                  style: AppTextStyles.bold(fontSize: titleFontSize, fontColor: Colors.black),
                ),
                subtitle: Text(
                  items[index]['subtitle']!,
                  style: AppTextStyles.regular(fontSize: subtitleFontSize, fontColor: Colors.grey),
                ),
                onTap: () => showEditPopup(context, items[index]['title']!),
              ),
              Divider(color: Colors.grey.shade300),
            ],
          );
        },
      ),
    );
  }

  void showEditPopup(BuildContext context, String title) {
    TextEditingController textController = TextEditingController();

    double titleFontSize = MediaQuery.of(context).size.width > 600 ? 22.0 : 18.0;
    double textFontSize = MediaQuery.of(context).size.width > 600 ? 20.0 : 16.0;
    double paddingSize = MediaQuery.of(context).size.width > 600 ? 30.0 : 20.0;

    Get.dialog(
      Dialog(
        backgroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: EdgeInsets.all(paddingSize),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                title,
                style: AppTextStyles.bold(fontSize: titleFontSize, fontColor: AppStorages.appColor.value),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),

              // Input Field
              TextField(
                controller: textController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter new text...",
                ),
              ),
              SizedBox(height: 20),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text("Cancel", style: AppTextStyles.regular(fontSize: textFontSize, fontColor: Colors.black)),
                  ),
                  TextButton(
                    onPressed: () {
                      controller.selectedText.value = textController.text;
                      Get.back();
                    },
                    child: Text("OK", style: AppTextStyles.bold(fontSize: textFontSize, fontColor: AppStorages.appColor.value)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
