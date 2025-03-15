import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/modules/tools/settings/app_settings/views/recurring_transactions_detail_view.dart';
import '../../../../../common/common_appbar.dart';
import '../../../../../core/app_storage.dart';
import '../../../../../resources/app_colors.dart';
import '../../../../../resources/app_styles.dart';

class RecurringTransactionsController extends GetxController {
  RxBool enableTransactions = true.obs;
  RxString selectedInterval = "Every 4 hours".obs;

  final List<String> intervals = [
    "Every 15 mins",
    "Every 30 mins",
    "Every 1 hour",
    "Every 2 hours",
    "Every 4 hours",
    "Every 6 hours",
    "Every 12 hours",
  ];

  void showIntervalDialog() {
    double paddingSize = Get.width > 600 ? 40.0 : 20.0;

    Get.defaultDialog(
      title: "Service run interval",
      titleStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      backgroundColor: AppColors.whiteColor, // Updated background color
      contentPadding: EdgeInsets.symmetric(horizontal: paddingSize, vertical: 10),
      content: Column(
        children: intervals.map((interval) {
          return Obx(() => RadioListTile<String>(
            title: Text(interval),
            value: interval,
            groupValue: selectedInterval.value,
            onChanged: (value) {
              selectedInterval.value = value!;
              Get.back(); // Close the dialog
            },
          ));
        }).toList(),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: Text("Cancel", style: TextStyle(color: Colors.black)),
      ),
    );
  }
}



class RecurringTransactionsScreen extends StatelessWidget {
  final RecurringTransactionsController controller =
  Get.put(RecurringTransactionsController());

  @override
  Widget build(BuildContext context) {
    double paddingSize = MediaQuery.of(context).size.width > 600 ? 40.0 : 20.0;
    double checkboxSize = MediaQuery.of(context).size.width > 600 ? 40 : 24;
    double titleFontSize = MediaQuery.of(context).size.width > 600 ? 25.0 : 16.0;
    double subtitleFontSize =
    MediaQuery.of(context).size.width > 600 ? 22.0 : 13.0;
    double checkboxIconSize =
    MediaQuery.of(context).size.width > 600 ? 30 : 20;

    return Scaffold(
      backgroundColor: AppColors.whiteColor, // Set background color
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Recurring Transactions",
        showBackButton: true,
        hideLogo: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingSize, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Enable Transactions Checkbox
            Obx(() => ListTile(
              title: Text(
                "Enable memorized transactions",
                style: AppTextStyles.regular(
                    fontSize: titleFontSize, fontColor: Colors.black),
              ),
              subtitle: Text(
                "If checked, repetitive transactions can be memorized and auto-created to save time",
                style: AppTextStyles.regular(
                    fontSize: subtitleFontSize, fontColor: Colors.grey),
              ),
              trailing: GestureDetector(
                onTap: () =>
                controller.enableTransactions.value = !controller.enableTransactions.value,
                child: Container(
                  width: checkboxSize,
                  height: checkboxSize,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: controller.enableTransactions.value
                      ? Center(
                    child: Icon(Icons.check,
                        color: AppStorages.appColor.value,
                        size: checkboxIconSize),
                  )
                      : null,
                ),
              ),
            )),
Divider(),
            // Service Run Interval
             ListTile(
              title: Text(
                "Service run interval",
                style: AppTextStyles.regular(
                    fontSize: titleFontSize, fontColor: Colors.black),
              ),
              subtitle: Text(
                "Select how frequent the app runs to look for recurring transactions to remind or auto-create",
                style: AppTextStyles.regular(
                    fontSize: subtitleFontSize, fontColor: Colors.grey),
              ),
              onTap: controller.showIntervalDialog,

            ),
            Divider(),
            // Go to Recurring Transactions
            ListTile(
              title: Text(
                "Go to recurring transactions",
                style: AppTextStyles.regular(
                    fontSize: titleFontSize, fontColor: Colors.black),
              ),
              subtitle: Text(
                "Home > Reminders > Recurring Transactions",
                style: AppTextStyles.regular(
                    fontSize: subtitleFontSize, fontColor: Colors.grey),
              ),
              onTap: () {

                Get.to(()=>RecurringTransactionsDetailScreen());
                // Navigate to the recurring transactions screen if needed
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
