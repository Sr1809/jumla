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

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  final HomeController homeController = Get.put(HomeController());
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Obx(()=> Scaffold(
        key: _key,
        drawer: DrawerView(),
        backgroundColor: AppColors.whiteColor,
        appBar:  AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              AppStorages.hideCompanyLogo.value?SizedBox(): InkWell(
                  onTap: () {
                    _key.currentState?.openDrawer();
                  },
                  child: Image.asset(AppAssets.logo, width: 100)),
            ],
          ),
          backgroundColor: AppStorages.appColor.value,
          actions: [
            IconButton(
              icon: Icon(Icons.sync, color: Colors.red),
              onPressed: () {
                // Handle refresh
              },
            ),
            IconButton(
              icon: Icon(Icons.menu, color: AppColors.whiteColor),
              onPressed: () {
                // Handle menu
                _key.currentState?.openDrawer();
              },
            ),
          ],
        ),
        body: Obx(() => ListView.separated(
            itemBuilder: (context, index) {
              return expanbleItem(controller.expandableList[index]);
            },
            separatorBuilder: (context, index) {
              return Container();
            },
            itemCount: controller.expandableList.length))));
  }

  void _showPopup() {
    Get.defaultDialog(
      radius: 0.0,
      title: "More shortcuts",
      titleStyle: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(thickness: 1, color: Colors.blue),
          Column(
            children: ['ds', 'dsdsa', 'dsd'].map((key) {
              return CheckboxListTile(
                title: Text(key, style: TextStyle(fontWeight: FontWeight.bold)),
                value: true,
                onChanged: (bool? value) {
                  // controller.shortcuts[key] = value ?? false;
                },
                activeColor: Colors.blue,
                checkColor: Colors.white,
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => Get.back(),
            child: Text("Done"),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(title, style: TextStyle(fontSize: 16)),
    );
  }

  expanbleItem(ExpandablListModel expandItem) {
    return InkWell(
      onTap: () {
        controller.expandableList.forEach((v) {
          v.isExpanded.value = false;
        });
        expandItem.isExpanded.value = !expandItem.isExpanded.value;
      },
      child: Obx(() => Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                color: AppColors.lightGrey,
                child: Row(
                  children: [
                    Icon(
                      expandItem.isExpanded.value
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColors.darkGrey,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                        child: Text(
                      expandItem.title ?? "",
                      style: AppTextStyles.bold(
                          fontSize: 18.0,
                          fontColor: AppColors.blackColor,
                          isUnderLine: false),
                    )),
                    expandItem.isExpanded.value && expandItem.actions!
                        ? Icon(Icons.settings)
                        : SizedBox.shrink(),
                  ],
                ),
              ),
              if (expandItem.isExpanded.value &&
                  expandItem.title == "Shortcuts")
                shortCutsView(),
              if (expandItem.isExpanded.value &&
                  expandItem.title == "Reminders")
                remindersView(),
              if (expandItem.isExpanded.value &&
                  expandItem.title == "Saved Reports")
                savedReportsView(),
              if (expandItem.isExpanded.value &&
                  expandItem.title == "Recent Reports")
                recentRecords()
            ],
          )),
    );
  }

  shortCutsView() {
    return Padding(
      padding: const EdgeInsets.only(
          left: 14.0, right: 14.0, top: 14.0, bottom: 14.0),
      child: Column(
        children: [
          Row(
            children: [
              shortcutItem(
                  icon: AppAssets.personIc,
                  title: "Customers",
                  onPress: () {
                    Get.toNamed(Routes.CUSTOMERS);
                  }),
              shortcutItem(icon: AppAssets.boxItemIc, title: "Items"),
              shortcutItem(icon: AppAssets.calculatorIc, title: "Sales"),
              shortcutItem(icon: AppAssets.plusIc, title: "New"),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            children: [
              shortcutItem(icon: AppAssets.noteIc, title: "Quotes"),
              shortcutItem(icon: AppAssets.noteIc, title: "Sales Order"),
              shortcutItem(icon: AppAssets.noteIc, title: "Cash Sales"),
              shortcutItem(icon: AppAssets.noteIc, title: "Invoices"),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            children: [
              shortcutItem(icon: AppAssets.lockIc, title: "Lock"),
              // shortcutItem(icon: AppAssets.noteIc, title: "Sales Order"),
              // shortcutItem(icon: AppAssets.lockIc, title: "Cash Sales"),
              // shortcutItem(icon: AppAssets.personIc, title: "Invoices"),
            ],
          ),
        ],
      ),
    );
  }

  remindersView() {
    return ListView.separated(
        shrinkWrap: true,
        // padding: EdgeInsets.symmetric(horizontal: 12.0),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                Icon(Icons.calendar_month),
                SizedBox(width: 8),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.reminderList[index].title ?? "",
                      style: AppTextStyles.regular(
                          fontSize: 14.0, fontColor: AppColors.blackColor),
                    ),
                    Text(
                      controller.reminderList[index].subTitle ?? "",
                      style: AppTextStyles.semiBold(
                          fontSize: 12.0, fontColor: Colors.green),
                    )
                  ],
                )),
                Text(
                  controller.reminderList[index].count ?? "",
                  style: AppTextStyles.bold(
                      fontSize: 14.0, fontColor: Colors.green),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(color: AppColors.lightGrey, height: 0.5);
        },
        itemCount: controller.reminderList.length);
  }

  savedReportsView() {
    return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  controller.savedReportList[index].title ?? "",
                  style: AppTextStyles.semiBold(
                      fontSize: 16.0, fontColor: AppColors.blackColor),
                )),
                Text(
                  controller.savedReportList[index].count ?? "",
                  style: AppTextStyles.bold(
                      fontSize: 14.0, fontColor: Colors.green),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(color: AppColors.lightGrey, height: 0.5);
        },
        itemCount: controller.savedReportList.length);
  }

  recentRecords() {
    return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                  controller.anonymusCustomersList[index].title ?? "",
                  style: AppTextStyles.semiBold(
                      fontSize: 16.0, fontColor: AppColors.blackColor),
                )),
                Text(
                  controller.anonymusCustomersList[index].date ?? "",
                  style: AppTextStyles.bold(
                      fontSize: 14.0, fontColor: Colors.green),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(color: AppColors.lightGrey, height: 0.5);
        },
        itemCount: controller.anonymusCustomersList.length);
  }

  shortcutItem({icon, title, Function? onPress}) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (onPress != null) {
            onPress();
          }
        },
        child: Column(
          children: [
            SvgPicture.asset(icon,
                height: 32, width: 32, color: Color(0xff444444)),
            Text(
              title,
              style: AppTextStyles.semiBold(
                  fontSize: 14.0, fontColor: AppColors.blackColor),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
