import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/common/common_appbar.dart';
import 'package:jumla/app/common/common_button.dart';
import 'package:jumla/app/core/app_storage.dart';
import 'package:jumla/app/modules/tools/lists/views/sale_template_setting_view.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:jumla/app/resources/app_styles.dart';

class InstalledTemplateScreen extends StatelessWidget {
   InstalledTemplateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // We have 2 tabs: ABOUT and SCREENSHOTS
      child: Scaffold(
        appBar: CommonAppBarWithTitleAndIcon(title: "Installed Template",hideLogo: true,),
        body: Column(
          children: [
            Container(
              color: AppStorages.appColor.value,
              child: TabBar(
                labelColor: AppColors.blackColor,
                unselectedLabelColor: Colors.white,
                labelStyle: AppTextStyles.bold(fontSize: 13.0, fontColor: AppColors.blackColor),
                indicator: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                dividerColor: Colors.transparent,
                isScrollable: false,

                padding: EdgeInsets.only(top: 4,bottom: 4,),
                tabs: [
                  Tab(child: SizedBox(width: 150, child: Center(child: Text("ABOUT")))),
                  Tab(child: SizedBox(width: 150, child: Center(child: Text("SCREENSHOTS")))),

                ],

              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // ABOUT tab

                  ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      // Title
                       Text(
                        "Jumla Sales Template",
                        style: AppTextStyles.semiBold(fontSize: 24.0, fontColor: AppStorages.appColor.value),
                      ),
                      const SizedBox(height: 8),

                      // Subtitle
                     Container(
                       padding: EdgeInsets.all(20),
                       decoration: BoxDecoration(
                         color: AppStorages.appColor.value.withOpacity(0.1)
                       ),
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                            Text(
                             "Jumla",
                             style: AppTextStyles.semiBold(fontSize: 20.0, fontColor: AppColors.blackColor),
                           ),
                           const SizedBox(height: 4),

                           // Email
                           InkWell(
                             onTap: () {
                               // TODO: open email app or handle click
                             },
                             child:  Text(
                               "support@mobilebizco.com",
                               style: AppTextStyles.semiBold(fontSize: 16.0, fontColor: AppStorages.appColor.value),
                             ),
                           ),
                         ],
                       ),
                     ),
                      const SizedBox(height: 16),

                      Obx(()=>CommonElevatedButton(text: saleType.value, onPressed: (){showApplyToSaleTypePopup();})),
                      const SizedBox(height: 10),
                      CommonElevatedButton(text: "Settings", onPressed: (){Get.to(()=>SalesTemplateSettingsView());}),

                      const SizedBox(height: 30),

                      // Description
                      const Text(
                        "This is the default print template for MobileBiz Pro. "
                            "It was designed to accommodate a lot of variations to display "
                            "your customized printout using free-text or MobileBiz tags.\n\n"
                            "On the Screenshots tab, look at the possible areas where you can "
                            "put your data. Then go to Options tab to fill these areas with data. "
                            "Print areas can be hidden if not needed by simply putting a blank "
                            "value on that specific area.\n\n"
                            "You can use a combination of free-text or MobileBiz tags to pull "
                            "your data from your transactions, customer, and items. For a full "
                            "list of MobileBiz tags, tap Menu > Tag Reference.",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),

                  // SCREENSHOTS tab
                  Center(
                    child: Text(
                      "Screenshots here...",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
var saleType = "Cash sale".obs;

  void showApplyToSaleTypePopup() {
    final saleTypes = [
      "Quote",
      "Sales Order",
      "Cash Sale",
      "Invoice",
      "Payment",
      "Purchase Order",
    ];

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        ),
        child: Column(
          // Minimize vertical space usage so the sheet only grows as needed
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            const Text(
              "Apply to sale type",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.cyan,
              ),
            ),
            const Divider(),

            // List of sale types
            // If you have many items, consider wrapping with Expanded + ListView
            Column(
              children: saleTypes.map((type) {
                return ListTile(
                  title: Text(type),
                  onTap: () {
                    // TODO: Handle selection logic
                    // e.g. store the selected type, or navigate somewhere
                    print("Selected: $type");
                    saleType.value =  type;
                    Get.back(); // close the bottom sheet
                  },
                );
              }).toList(),
            ),

            const Divider(),

            // Bottom row with Cancel & "Don't apply"
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Get.back(), // just close
                  child: const Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: Handle "Don't apply to any type" logic
                    print("Don't apply to any type");
                    saleType.value = "";
                        Get.back();
                  },
                  child: const Text("Don't apply to any type"),
                ),
              ],
            ),
          ],
        ),
      ),
      isScrollControlled: true, // so it can scroll if items exceed screen height
    );
  }

}
