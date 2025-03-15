import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/core/app_storage.dart';

import '../../../../../common/common_appbar.dart';
import '../../../../../resources/app_colors.dart';
import '../../../../../resources/app_styles.dart';

class RecurringTransactionsDetailController extends GetxController {
  RxInt selectedTabIndex = 0.obs;

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  void onRunToday() {
    // Add action for Run Today
  }

  void onSwitchToTransactionsView() {
    // Add action for Switch to Transactions View
  }

  void onSettingsPressed() {
    // Navigate to settings or open a settings dialog
  }}


class RecurringTransactionsDetailScreen extends StatelessWidget {
  final RecurringTransactionsDetailController controller =
  Get.put(RecurringTransactionsDetailController());

  @override
  Widget build(BuildContext context) {
    double paddingSize = MediaQuery.of(context).size.width > 600 ? 40.0 : 20.0;
    double buttonHeight = MediaQuery.of(context).size.width > 600 ? 70.0 : 40.0;
    double tabFontSize = MediaQuery.of(context).size.width > 600 ? 22.0 : 16.0;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Recurring Transactions",
        showBackButton: true,
        hideLogo: true,

      ),
      body: Column(
        children: [
          // Settings and Schedules label
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 4.0),
            color: Colors.black,
            child: Center(
              child: Text(
                "Settings and Schedules",
                style: AppTextStyles.regular(fontSize: 10.0, fontColor: Colors.white),
              ),
            ),
          ),
SizedBox(height: 10,),
          // Tab Selection (Due Today, Due This Week, All)
          Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(3, (index) {
              List<String> tabs = ["Due today", "Due this week", "All"];
              return Expanded(
                child: GestureDetector(
                  onTap: () => controller.changeTab(index),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: controller.selectedTabIndex.value != index
                          ? Colors.white
                          : AppStorages.appColor.value,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        tabs[index],
                        style: AppTextStyles.regular(fontSize: tabFontSize,fontColor:controller.selectedTabIndex.value == index
                            ? Colors.white
                            : Colors.black),
                      ),
                    ),
                  ),
                ),
              );
            }),
          )),

          SizedBox(height: 20),

          // Empty state message
          Expanded(
            child: Center(
              child: Text(
                "To add one, open a transaction record > Edit > Make Recurring",
                textAlign: TextAlign.center,
                style: AppTextStyles.regular(fontSize: tabFontSize,fontColor: Colors.black),
              ),
            ),
          ),

          // Bottom buttons: Run Today & Switch to Transactions View
          Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingSize, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: controller.onRunToday,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppStorages.appColor.value,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(color: Colors.black),
                      ),
                      minimumSize: Size(double.infinity, buttonHeight),
                    ),
                    child: Text(
                      "Run Today",
                      style: AppTextStyles.regular(fontSize: tabFontSize*0.7, fontColor: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: controller.onSwitchToTransactionsView,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppStorages.appColor.value,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(color: Colors.black),
                      ),
                      minimumSize: Size(double.infinity, buttonHeight),
                    ),
                    child: Text(
                      "Switch to transactions view",
                      style: AppTextStyles.regular(fontSize: tabFontSize*0.7, fontColor: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
