import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jumla/app/core/app_storage.dart';
import 'package:jumla/app/modules/home/models/home_models.dart';
import 'package:jumla/app/resources/app_assets.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:jumla/app/resources/app_styles.dart';
import 'package:jumla/app/routes/app_pages.dart';

import '../../drawer/views/drawer_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetWidget<HomeController> {
  HomeView({super.key});
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    double textSize = isTablet ? 30.0 : 18.0;
    double iconSize = isTablet ? 50.0 : 22.0;
    double paddingSize = isTablet ? 40.0 : 20.0;
    double logoSize = isTablet ? 150 : 100;
    double appBarTextSize = isTablet ? 30.0 : 18.0;

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
              // Handle refresh
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
      body: Obx(() => ListView.separated(
          padding: EdgeInsets.all(paddingSize),
          itemBuilder: (context, index) {
            return expanbleItem(controller.expandableList[index], textSize, iconSize);
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 10);
          },
          itemCount: controller.expandableList.length)),
    ));
  }

  expanbleItem(ExpandablListModel expandItem, double textSize, double iconSize) {
    return InkWell(
      onTap: () {
        controller.expandableList.forEach((v) => v.isExpanded.value = false);
        expandItem.isExpanded.value = !expandItem.isExpanded.value;
      },
      child: Obx(() => Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: AppStorages.appColor.value,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(
                  expandItem.isExpanded.value ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: AppColors.whiteColor,
                  size: iconSize,
                ),
                SizedBox(width: 10),
                Expanded(
                    child: Text(
                      expandItem.title ?? "",
                      style: AppTextStyles.bold(fontSize: textSize, fontColor: AppColors.whiteColor),
                    )),
                if (expandItem.isExpanded.value && expandItem.actions!) Icon(Icons.settings, size: iconSize,color: AppColors.whiteColor,),
              ],
            ),
          ),
          if (expandItem.isExpanded.value && expandItem.title == "Shortcuts") shortCutsView(textSize, iconSize),
          if (expandItem.isExpanded.value && expandItem.title == "Reminders") remindersView(),
          if (expandItem.isExpanded.value && expandItem.title == "Saved Reports") savedReportsView(),
          if (expandItem.isExpanded.value && expandItem.title == "Recent Reports") recentRecords(),
        ],
      )),
    );
  }

  /// **Grid-based Shortcut View**
  Widget shortCutsView(double textSize, double iconSize) {
    List<Map<String, dynamic>> shortcuts = [
      {"icon": AppAssets.personIc, "title": "Customers", "route": Routes.CUSTOMERS},
      {"icon": AppAssets.boxItemIc, "title": "Items"},
      {"icon": AppAssets.calculatorIc, "title": "Sales"},
      {"icon": AppAssets.plusIc, "title": "New"},
      {"icon": AppAssets.noteIc, "title": "Quotes"},
      {"icon": AppAssets.noteIc, "title": "Sales Order"},
      {"icon": AppAssets.noteIc, "title": "Cash Sales"},
      {"icon": AppAssets.noteIc, "title": "Invoices"},
      {"icon": AppAssets.lockIc, "title": "Lock"},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: shortcuts.length,
      padding: EdgeInsets.only(top: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 4 items per row for better spacing
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        var shortcut = shortcuts[index];
        return shortcutItem(
          icon: shortcut["icon"],
          title: shortcut["title"],
          onPress: shortcut.containsKey("route") ? () => Get.toNamed(shortcut["route"]) : null,
          textSize: textSize,
          iconSize: iconSize,
        );
      },
    );
  }

  /// **Modern Box-Styled Shortcut Item**
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
          borderRadius: BorderRadius.circular(12), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: AppStorages.appColor.value.withOpacity(0.1), // Soft shadow
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
              padding: EdgeInsets.all(iconSize == 50?20:12), // Icon background padding
              decoration: BoxDecoration(
                color: AppColors.whiteColor, // Light grey background
                shape: BoxShape.circle, // Circular icon container
              ),
              child: SvgPicture.asset(icon, height: iconSize, width: iconSize,color: AppStorages.appColor.value, ),
            ),
            SizedBox(height: 6),
            Text(
              title,
              style: AppTextStyles.semiBold(fontSize: textSize * 0.8, fontColor: AppColors.blackColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }








  Widget remindersView() {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 10),
      physics: NeverScrollableScrollPhysics(),
      itemCount: controller.reminderList.length,
      separatorBuilder: (context, index) => SizedBox(height: 10), // Space between items
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

  /// **Modern Box-Styled Reminder Item (List View)**
  Widget _reminderItem({
    required IconData icon,
    required String title,
    required String subTitle,
    required String count,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppStorages.appColor.value.withOpacity(0.1), // Soft transparent color
        borderRadius: BorderRadius.circular(12), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: AppStorages.appColor.value.withOpacity(0.1), // Soft shadow
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
          /// **Icon with Circular Background**
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.whiteColor, // White background
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 24, color: AppStorages.appColor.value),
          ),
          SizedBox(width: 12),

          /// **Text Details**
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor)),
                Text(subTitle,
                    style: AppTextStyles.semiBold(fontSize: 14.0, fontColor: Colors.green)),
              ],
            ),
          ),

          /// **Count Display**
          Text(count,
              style: AppTextStyles.bold(fontSize: 16.0, fontColor: Colors.green)),
        ],
      ),
    );
  }

  Widget savedReportsView() {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 10),
      itemCount: controller.savedReportList.length,
      separatorBuilder: (context, index) => SizedBox(height: 10), // Space between items
      itemBuilder: (context, index) {
        var report = controller.savedReportList[index];
        return _reportItem(
          title: report.title ?? "",
          count: report.count ?? "",
        );
      },
    );
  }

  /// **Modern Box-Styled Report Item**
  Widget _reportItem({
    required String title,
    required String count,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppStorages.appColor.value.withOpacity(0.1), // Transparent background
        borderRadius: BorderRadius.circular(12), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: AppStorages.appColor.value.withOpacity(0.1), // Soft shadow
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
          /// **Title Section**
          Expanded(
            child: Text(title,
                style: AppTextStyles.semiBold(fontSize: 16.0, fontColor: AppColors.blackColor)),
          ),

          /// **Count Display**
          Text(count,
              style: AppTextStyles.bold(fontSize: 16.0, fontColor: Colors.green)),
        ],
      ),
    );
  }

  Widget recentRecords() {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.only(top: 10),
      physics: NeverScrollableScrollPhysics(),
      itemCount: controller.anonymusCustomersList.length,
      separatorBuilder: (context, index) => SizedBox(height: 10), // Space between items
      itemBuilder: (context, index) {
        var record = controller.anonymusCustomersList[index];
        return _recentRecordItem(
          title: record.title ?? "",
          date: record.date ?? "",
        );
      },
    );
  }

  /// **Modern Box-Styled Recent Record Item**
  Widget _recentRecordItem({
    required String title,
    required String date,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppStorages.appColor.value.withOpacity(0.1), // Transparent background
        borderRadius: BorderRadius.circular(12), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: AppStorages.appColor.value.withOpacity(0.1), // Soft shadow
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
          /// **Title Section**
          Expanded(
            child: Text(title,
                style: AppTextStyles.semiBold(fontSize: 16.0, fontColor: AppColors.blackColor)),
          ),

          /// **Date Display**
          Text(date,
              style: AppTextStyles.bold(fontSize: 16.0, fontColor: Colors.green)),
        ],
      ),
    );
  }


}
