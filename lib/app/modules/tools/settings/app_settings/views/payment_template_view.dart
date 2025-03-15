import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/app_storage.dart';
import '../../../../../resources/app_colors.dart';
import '../../../../../resources/app_styles.dart';
import '../../../../../common/common_appbar.dart';

class ChangeTextPaymentController extends GetxController {
  var selectedText = "".obs;
}

class ChangeTextPaymentScreen extends StatelessWidget {
  final ChangeTextPaymentController controller = Get.put(ChangeTextPaymentController());

  final List<Map<String, String>> items = [
    {"title": "Paid", "subtitle": "Enter text that replaces the 'Paid' text on payment printouts"},
    {"title": "Paid By", "subtitle": "Enter text that replaces the 'Paid By' text on payment printouts"},
    {"title": "Date", "subtitle": "Enter text that replaces the 'Date' text on payment printouts"},
    {"title": "Description", "subtitle": "Enter text that replaces the 'Description' text on payment printouts"},
    {"title": "Payment Amount", "subtitle": "Enter text that replaces the 'Payment Amount' text on payment printouts"},
    {"title": "Payment for", "subtitle": "Enter text that replaces the 'Payment for' text on payment printouts"},
    {"title": "Original Amount", "subtitle": "Enter text that replaces the 'Original Amount' text on payment printouts"},
    {"title": "Balance after payment", "subtitle": "Enter text that replaces the 'Balance after payment' text on payment printouts"},
    {"title": "Status after payment", "subtitle": "Enter text that replaces the 'Balance after payment' text on payment printouts"},
    {"title": "Type", "subtitle": "Enter text that replaces the 'Type' text on payment printouts"},
    {"title": "Memo", "subtitle": "Enter text that replaces the 'Memo' text on payment printouts"},
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
