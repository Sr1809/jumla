import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jumla/app/common/common_appbar.dart';
import 'package:jumla/app/resources/app_colors.dart';

import '../../../core/app_storage.dart';
import '../../../routes/app_pages.dart';
import '../controllers/expiring_quotes_controller.dart';

class ExpiringQuotesView extends GetView<ExpiringQuotesController> {
  const ExpiringQuotesView({super.key});
  @override
  Widget build(BuildContext context) {
    // `controller` is automatically available because we bind the controller
    // via a Binding (shown below) or Get.put(...).
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(title: controller.title,hideLogo: true,),
      body: Obx(() {
        // Observe the quotes list
        return ListView.builder(
          itemCount: controller.quotes.length,
padding: EdgeInsets.all(20),
          itemBuilder: (context, index) {
            final quote = controller.quotes[index];
            final customer = quote["customer"] ?? "";
            final estimateNo = quote["estimateNo"] ?? "";
            final amount = (quote["amount"] ?? 0.0) as double;
            final daysAgo = quote["daysAgo"] ?? "";

            return InkWell(
              onTap: (){
                _showQuoteOptionsPopup(context);
              },
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),

                child: ListTile(
                  tileColor: AppStorages.appColor.value.withOpacity(0.1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),

                  title: Text(customer),
                  subtitle: Text("$estimateNo \$${amount.toStringAsFixed(2)}"),
                  trailing: Text(
                    daysAgo,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Container(

        color: AppStorages.appColor.value,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 20,left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(onPressed: (){
                  _showDateRangePopup(context,"".obs);
                }, icon: Icon(Icons.filter_list_rounded,color: AppColors.whiteColor,)),
                IconButton(onPressed: ()=>Get.toNamed(Routes.QUOTES), icon: Icon(Icons.dashboard,color: AppColors.whiteColor,)),
              ],
            ),
          ),
        ),

      ),
    );
  }


  void _showDateRangePopup(BuildContext context, RxString targetValue) {
    // Full date range list as seen in your screenshot
    final dateRanges = [
      "Today",
      "Yesterday",
      "Tomorrow",
      "This week",
      "Next week",
      "This month",
      "Next month",
      "This year",
      "Next year",
      "Next 3 weeks",
      "Next 2 months",
      "Next 3 months",
      "Next 6 months",
      "Next 12 months",
      "Last 1 week",
      "Last 2 weeks",
      "Last 3 weeks",
      "Last 4 weeks",
      "2 weeks ago",
      "3 weeks ago",
      "Last 2 months",
      "Last 3 months",
      "1 month ago",
      "2 months ago",
      "3 months ago",
      "4 months ago",
      "5 months ago",
      "6 months ago",
      "7 months ago",
      "8 months ago",
      "9 months ago",
      "10 months ago",
      "11 months ago",
      "1 year ago",
      "Year to date",
      "Last year",
    ];

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        height: Get.height * 0.8,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        ),
        child: Column(
          children: [
            const Text(
              "Select a date range",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.cyan,
              ),
            ),
            const Divider(),
            // Scrollable list of radio buttons (single select)
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: dateRanges.map((item) {
                    return Obx(
                          () => RadioListTile<String>(
                        title: Text(item),
                        value: item,
                        groupValue: targetValue.value,
                        onChanged: (value) {
                          if (value != null) {
                            targetValue.value = value;
                          }
                          Get.back();
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }




  void _showQuoteOptionsPopup(BuildContext context) {
    // Example data; you can pass these in as parameters if needed
    final phoneNumber = "8557765";
    final estimateNo = "ESTIMATE#007";
    final customerName = "Anonymous Customer";

    // Actions you want in the popup
    final actions = [
      "Adjust expire date",
      "Call $phoneNumber",
      "Send SMS $phoneNumber",
      "Send email",
      "Go to $customerName",
      "Go to $estimateNo",
      "Convert to salesorder (won)",
      "Convert to invoice (won)",
      "Convert to cash sale (won)",
      "Mark as Lost",
    ];

    Get.bottomSheet(
      Container(
        // A fixed max height if the list is long
        constraints: BoxConstraints(
          maxHeight: Get.height * 0.8,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: actions.length,
          itemBuilder: (context, index) {
            final action = actions[index];
            return ListTile(
              title: Text(action),
              onTap: () {
                // Handle each action
                switch (action) {
                  case "Adjust expire date":
                  // your logic here
                    break;
                  case "Call 8557765":
                  // your logic here (e.g., launch phone dialer)
                    break;
                  case "Send SMS 8557765":
                  // your logic here
                    break;
                  case "Send email":
                  // your logic here
                    break;
                  case "Go to Anonymous Customer":
                  // your logic here
                    break;
                  case "Go to ESTIMATE#007":
                  // your logic here
                    break;
                  case "Convert to salesorder (won)":
                  // your logic here
                    break;
                  case "Convert to invoice (won)":
                  // your logic here
                    break;
                  case "Convert to cash sale (won)":
                  // your logic here
                    break;
                  case "Mark as Lost":
                  // your logic here
                    break;
                }

                // Close the bottom sheet after handling
                Get.back();
              },
            );
          },
        ),
      ),
      isScrollControlled: true, // so it can scroll if it’s long
    );
  }

}
