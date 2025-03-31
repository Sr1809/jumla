import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jumla/app/core/app_storage.dart';
import 'package:jumla/app/modules/customers_list/views/add_or_edit_customer_view.dart';
import 'package:jumla/app/modules/customers_list/views/customers_list_view.dart';
import 'package:jumla/app/modules/home/models/home_models.dart';
import 'package:jumla/app/modules/invoice/views/invoice_detail_view.dart';
import 'package:jumla/app/modules/invoice/views/invoice_list_view.dart';
import 'package:jumla/app/modules/items/views/add_or_edit_item_view.dart';
import 'package:jumla/app/modules/tools/settings/app_settings/views/recurring_transactions_detail_view.dart';
import 'package:jumla/app/modules/tools/settings/app_settings/views/recurring_transactions_view.dart';
import 'package:jumla/app/resources/app_assets.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:jumla/app/resources/app_styles.dart';
import 'package:jumla/app/routes/app_pages.dart';

import '../../../common/pin_setup_view.dart';
import '../../cash_sale/views/cash_sale_list_view.dart';
import '../../cash_sale/views/cash_sale_view.dart';
import '../../drawer/views/drawer_view.dart';
import '../../reports/views/saved_reports.dart';
import '../../sales_order/views/sales_order_list_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetWidget<HomeController> {
  HomeView({super.key});
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  /// All possible shortcuts (icon + title).
  final RxList<Map<String, dynamic>> allShortcuts = <Map<String, dynamic>>[
    {"icon": AppAssets.personIc,      "title": "Customers"},
    {"icon": AppAssets.boxItemIc,     "title": "Items"},
    {"icon": AppAssets.calculatorIc,  "title": "Sales"},
    {"icon": AppAssets.plusIc,        "title": "New"},
    {"icon": AppAssets.noteIc,        "title": "Quotes"},
    {"icon": AppAssets.noteIc,        "title": "Sales Order"},
    {"icon": AppAssets.noteIc,        "title": "Cash Sales"},
    {"icon": AppAssets.noteIc,        "title": "Invoices"},
    {"icon": AppAssets.noteIc,        "title": "Vendors"},
    {"icon": AppAssets.noteIc,        "title": "Purchases"},
    {"icon": AppAssets.lockIc,        "title": "Lock"},
  ].obs;

  /// **Pre-selected** shortcuts.
  /// These will appear in the grid by default.
  final RxList<String> selectedShortcutTitles = <String>[
    "Customers",
    "Items",
    "Sales",
    "New",
    "Quotes",
    "Sales Order",
    "Cash Sales",
    "Vendors",
    "Lock",
  ].obs;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    double textSize = isTablet ? 30.0 : 18.0;
    double iconSize = isTablet ? 50.0 : 22.0;
    double paddingSize = isTablet ? 40.0 : 20.0;
    double logoSize = isTablet ? 150 : 100;

    return Obx(() => Scaffold(
      key: _key,
      drawer: DrawerView(),
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            if (!AppStorages.hideCompanyLogo.value)
              InkWell(
                onTap: () => _key.currentState?.openDrawer(),
                child: Image.asset(AppAssets.logo, width: logoSize),
              ),
          ],
        ),
        backgroundColor: AppStorages.appColor.value,
        actions: [
          IconButton(
            icon: Icon(Icons.sync, color: Colors.red, size: iconSize),
            onPressed: () {
              // Handle refresh if needed
            },
          ),
          IconButton(
            icon: Icon(Icons.menu, color: AppColors.whiteColor, size: iconSize),
            onPressed: () {
              _key.currentState?.openDrawer();
            },
          ),
        ],
      ),
      body: Obx(
            () => ListView.separated(
          padding: EdgeInsets.all(paddingSize),
          itemBuilder: (context, index) {
            return expanbleItem(controller.expandableList[index], textSize, iconSize);
          },
          separatorBuilder: (context, index) => SizedBox(height: 10),
          itemCount: controller.expandableList.length,
        ),
      ),
    ));
  }

  /// **Expanding Item** (Shortcuts, Reminders, etc.)
  Widget expanbleItem(ExpandablListModel expandItem, double textSize, double iconSize) {
    return InkWell(
      onTap: () {
        // Collapse all items, then toggle the tapped one
        for (var v in controller.expandableList) {
          v.isExpanded.value = false;
        }
        expandItem.isExpanded.value = !expandItem.isExpanded.value;
      },
      child: Obx(
            () => Column(
          children: [
            // Title bar
            Container(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: AppStorages.appColor.value,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(
                    expandItem.isExpanded.value
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: AppColors.whiteColor,
                    size: iconSize,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      expandItem.title ?? "",
                      style: AppTextStyles.bold(
                        fontSize: textSize,
                        fontColor: AppColors.whiteColor,
                      ),
                    ),
                  ),
                  // If expanded and 'actions' is true, show gear icon for "Shortcuts"
                  if (expandItem.isExpanded.value &&
                      expandItem.actions! &&
                      expandItem.title == "Shortcuts")
                    InkWell(
                      onTap: () => _showShortcutsFilterPopup(),
                      child: Icon(
                        Icons.settings,
                        size: iconSize,
                        color: AppColors.whiteColor,
                      ),
                    ),
                ],
              ),
            ),

            // Content for "Shortcuts"
            if (expandItem.isExpanded.value && expandItem.title == "Shortcuts")
              shortCutsView(textSize, iconSize),

            // Content for "Reminders"
            if (expandItem.isExpanded.value && expandItem.title == "Reminders")
              remindersView(),

            // Content for "Saved Reports"
            if (expandItem.isExpanded.value && expandItem.title == "Saved Reports")
              savedReportsView(),

            // Content for "Recent Reports"
            if (expandItem.isExpanded.value && expandItem.title == "Recent Reports")
              recentRecords(),
          ],
        ),
      ),
    );
  }

  /// **Shortcuts Grid**
  /// Only shows items whose title is in `selectedShortcutTitles`.
  Widget shortCutsView(double textSize, double iconSize) {
    // Filter out only the shortcuts the user has selected
    final displayedShortcuts = allShortcuts
        .where((sc) => selectedShortcutTitles.contains(sc["title"]))
        .toList();

    // If none are selected, show a placeholder
    if (displayedShortcuts.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          "No shortcuts selected. Tap the gear icon to choose.",
          style: AppTextStyles.semiBold(fontSize: textSize * 0.8, fontColor: AppColors.blackColor),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: displayedShortcuts.length,
      padding: EdgeInsets.only(top: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 items per row
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        var shortcut = displayedShortcuts[index];
        return shortcutItem(
          icon: shortcut["icon"],
          title: shortcut["title"],
          onPress: () {
            // Navigate or open a dialog depending on which shortcut is tapped
            switch (shortcut["title"]) {
              case "Customers":
                Get.toNamed(Routes.CUSTOMERS_LIST);
                break;
              case "Items":
                Get.toNamed(Routes.ITEMS);
                break;
              case "Sales":
                Get.toNamed(Routes.TRANSACTIONS);
                break;
              case "Quotes":
                Get.toNamed(Routes.QUOTES);
                break;
              case "Sales Order":
                Get.to(() => SalesOrderListView());
                break;
              case "Vendors":
                Get.toNamed(Routes.VENDORS);
                break;
              case "Purchases":
                Get.toNamed(Routes.PURCHASE_ORDERS);
                break;
              case "Cash Sales":
                Get.to(() => CashOrderListView());
                break;
              case "Invoices":
                Get.to(() => InvoiceListView());
                break;
              case "New":
                _add(context);
                case "Lock":
                  _showCannotLockDialog(context);
                break;
            // ... more cases if needed
            }
          },
          textSize: textSize,
          iconSize: iconSize,
        );
      },
    );
  }

  /// **Popup to filter which shortcuts appear in the grid.**
  /// Check/uncheck updates `selectedShortcutTitles`.
  void _showShortcutsFilterPopup() {
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
            Text(
              "Choose Shortcuts",
              style: AppTextStyles.bold(fontSize: 18.0, fontColor: AppStorages.appColor.value),
            ),
            const Divider(),
            Expanded(
              child: Obx(
                    () => SingleChildScrollView(
                  child: Column(
                    children: allShortcuts.map((shortcut) {
                      final title = shortcut["title"] as String;
                      final isSelected = selectedShortcutTitles.contains(title);
                      return CheckboxListTile(
                        title: Text(title),
                        value: isSelected,
                        onChanged: (checked) {
                          if (checked == true) {
                            selectedShortcutTitles.add(title);
                          } else {
                            selectedShortcutTitles.remove(title);
                          }
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text("Done"),
                ),
              ],
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  /// **Shortcut Grid Item**
  Widget shortcutItem({
    required String icon,
    required String title,
    Function? onPress,
    required double textSize,
    required double iconSize,
  }) {
    return GestureDetector(
      onTap: onPress != null ? () => onPress() : null,
      child: Container(
        decoration: BoxDecoration(
          color: AppStorages.appColor.value.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppStorages.appColor.value.withOpacity(0.1),
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(2, 2),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(iconSize == 50 ? 20 : 12),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                icon,
                height: iconSize,
                width: iconSize,
                color: AppStorages.appColor.value,
              ),
            ),
            SizedBox(height: 6),
            Text(
              title,
              style: AppTextStyles.semiBold(
                fontSize: textSize * 0.8,
                fontColor: AppColors.blackColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// **Dialog for "New" button** in shortcuts
  void _add(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: Text(
          "Add Record",
          style: AppTextStyles.bold(
            fontSize: 20.0,
            fontColor: AppStorages.appColor.value,
          ),
        ),
        children: [
          Divider(thickness: 2, color: AppStorages.appColor.value),
          ListTile(
            title: Text("New quote"),
            onTap: () {
              Get.back();
              Get.toNamed(Routes.ESTIMATE);
            },
          ),
          ListTile(
            title: Text("New invoice"),
            onTap: () {
              Get.back();
              Get.toNamed(Routes.INVOICE);
            },
          ),
          ListTile(
            title: Text("New sales order"),
            onTap: () {
              Get.back();
              Get.toNamed(Routes.SALES_ORDER);
            },
          ),
          ListTile(
            title: Text("New cash order"),
            onTap: () {
              Get.back();
              Get.toNamed(Routes.CASH_SALE);
            },
          ),
          ListTile(
            title: Text("New purchase order"),
            onTap: () {
              Get.back();
              Get.to(() => CashSaleView(title: "PURCHASEORDER#_",));
            },
          ),
          ListTile(
            title: Text("Accept payment"),
            onTap: () {
              Get.back();
              Get.to(() => CustomersListView());
            },
          ),
          ListTile(
            title: Text("Add customer"),
            onTap: () {
              Get.back();
              Get.to(() => AddOrEditCustomerScreen());
            },
          ),
          ListTile(
            title: Text("Add vendor"),
            onTap: () {
              Get.back();
              Get.to(() => AddOrEditCustomerScreen(title: "Vendor"));
            },
          ),
          ListTile(
            title: Text("Add item"),
            onTap: () {
              Get.back();
              Get.to(() => AddOrEditItemScreen());
            },
          ),
          ListTile(
            title: Text(
              "Cancel",
              style: AppTextStyles.regular(
                fontSize: 16.0,
                fontColor: AppStorages.appColor.value,
              ),
            ),
            onTap: () => Get.back(),
          ),
        ],
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////////
  //                          OTHER SECTIONS                                   //
  //////////////////////////////////////////////////////////////////////////////

  /// **Reminders** list
  Widget remindersView() {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 10),
      physics: NeverScrollableScrollPhysics(),
      itemCount: controller.reminderList.length,
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemBuilder: (context, index) {
        var reminder = controller.reminderList[index];
        return _reminderItem(
          icon: Icons.calendar_month,
          title: reminder.title ?? "",
          subTitle: reminder.subTitle ?? "",
          count: reminder.count ?? "",
        );
      },
    );
  }

  Widget _reminderItem({
    required IconData icon,
    required String title,
    required String subTitle,
    required String count,
  }) {
    return InkWell(
      onTap: (){
        if(title == "Recurring Transactions"){
          Get.to(RecurringTransactionsDetailScreen());
        }else{
        Get.toNamed(Routes.EXPIRING_QUOTES,arguments: title);}
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppStorages.appColor.value.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppStorages.appColor.value.withOpacity(0.1),
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(2, 2),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 24, color: AppStorages.appColor.value),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor),
                  ),
                  Text(
                    subTitle,
                    style: AppTextStyles.semiBold(fontSize: 14.0, fontColor: Colors.green),
                  ),
                ],
              ),
            ),
            Text(
              count,
              style: AppTextStyles.bold(fontSize: 16.0, fontColor: Colors.green),
            ),
          ],
        ),
      ),
    );
  }

  /// **Saved Reports** list
  Widget savedReportsView() {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 10),
      itemCount: controller.savedReportList.length,
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemBuilder: (context, index) {
        var report = controller.savedReportList[index];
        return _reportItem(
          title: report.title ?? "",
          count: report.count ?? "",
        );
      },
    );
  }

  Widget _reportItem({
    required String title,
    required String count,
  }) {
    return InkWell(
      onTap:(){
        Get.to(()=>SavedReports());
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppStorages.appColor.value.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppStorages.appColor.value.withOpacity(0.1),
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(2, 2),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.semiBold(fontSize: 16.0, fontColor: AppColors.blackColor),
              ),
            ),
            Text(
              count,
              style: AppTextStyles.bold(fontSize: 16.0, fontColor: Colors.green),
            ),
          ],
        ),
      ),
    );
  }

  /// **Recent Records** list
  Widget recentRecords() {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 10),
      physics: NeverScrollableScrollPhysics(),
      itemCount: controller.anonymusCustomersList.length,
      separatorBuilder: (context, index) => SizedBox(height: 10),
      itemBuilder: (context, index) {
        var record = controller.anonymusCustomersList[index];
        return _recentRecordItem(
          title: record.title ?? "",
          date: record.date ?? "",
        );
      },
    );
  }

  Widget _recentRecordItem({
    required String title,
    required String date,
  }) {
    return InkWell(
      onTap: (){
        Get.to(()=>InvoiceDetailView());
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppStorages.appColor.value.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppStorages.appColor.value.withOpacity(0.1),
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(2, 2),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.semiBold(fontSize: 16.0, fontColor: AppColors.blackColor),
              ),
            ),
            Text(
              date,
              style: AppTextStyles.bold(fontSize: 16.0, fontColor: Colors.green),
            ),
          ],
        ),
      ),
    );
  }


  void _showCannotLockDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Cannot lock"),
        content: const Text("Would you like to set up a PIN first?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx), // Close dialog
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);  // Close dialog
              // Navigate to PIN setup screen
              Get.to(() => PinSetupScreen());
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

}
