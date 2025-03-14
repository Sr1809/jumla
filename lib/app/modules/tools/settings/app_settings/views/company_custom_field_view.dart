import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/resources/app_colors.dart';

import '../../../../../common/common_appbar.dart';
import '../../../../../core/app_storage.dart';
import '../../../../../resources/app_styles.dart';
import '../controllers/app_settings_controller.dart';
import 'add_custom_field_view.dart';


class CompanyCustomFieldsView extends GetView<AppSettingsController> {
  const CompanyCustomFieldsView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    double textSize = isTablet ? 30.0 : 18.0;
    double paddingSize = isTablet ? 40.0 : 20.0;
    double containerWidth = screenWidth * (isTablet ? 0.7 : 0.9);
    double buttonHeight = isTablet ? 70 : 40;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Custom",
        showBackButton: true,
        hideLogo: true,
        actions: [
          /// **Add New Field Button**
          IconButton(
            icon: Icon(Icons.add, color: Colors.white, size: textSize),
            onPressed: () {
            Get.to(()=>AddCustomFieldView());
            },
          ),
          /// **Close Button**
          IconButton(
            icon: Icon(Icons.close, color: Colors.white, size: textSize),
            onPressed: () => Get.back(),
          ),
        ],
      ),

      /// **Main Body**
      body: Center(
        child: Container(
          width: containerWidth, // ✅ Responsive width
          padding: EdgeInsets.all(paddingSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /// **Dropdown Filter**
              Obx(() => SizedBox(
                width: 200, // ✅ Full width container
                child: PopupMenuButton<String>(
                  onSelected: (value) => controller.selectedFilter.value = value,
                  itemBuilder: (context) => [
                    PopupMenuItem(value: "Show all", child: Text("Show all")),
                    PopupMenuItem(value: "Show activated", child: Text("Show activated")),
                    PopupMenuItem(value: "Show inactivated", child: Text("Show inactivated")),
                  ],
                  offset: Offset(0, 50), // ✅ Positions dropdown below the container
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                    decoration: BoxDecoration(
                      color: AppStorages.appColor.value.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Filter: ${controller.selectedFilter.value}",
                          style: AppTextStyles.regular(fontSize: textSize * 0.4, fontColor: Colors.black),
                        ),
                        Icon(Icons.arrow_drop_down, color: Colors.black),
                      ],
                    ),
                  ),
                ),
              )),

              SizedBox(height: 20),

              /// **List of Custom Fields**
              Expanded(
                child: Obx(
                      () => controller.customFields.isEmpty
                      ? Center(
                    child: Text(
                      "No custom fields available",
                      style: AppTextStyles.regular(fontSize: textSize * 0.8, fontColor: Colors.grey),
                    ),
                  )
                      : ListView.builder(
                    itemCount: controller.customFields.length,
                    itemBuilder: (context, index) {
                      return _buildCustomFieldItem(controller.customFields[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      /// **Bottom Navigation**
      bottomNavigationBar: Container(
        height: buttonHeight,
        padding: EdgeInsets.symmetric(horizontal: paddingSize),
        decoration: BoxDecoration(
          color: AppStorages.appColor.value,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.save, color: Colors.white, size: textSize),
              onPressed: () {
               // controller.saveChanges();
              },
            ),
            Text("TAGS", style: AppTextStyles.bold(fontSize: textSize, fontColor: Colors.white)),
            IconButton(
              icon: Icon(Icons.close, color: Colors.white, size: textSize),
              onPressed: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }

  /// **Reusable List Tile for Custom Fields**
  Widget _buildCustomFieldItem(CustomField field) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: AppStorages.appColor.value,
      elevation: 2,
      child: ListTile(
        title: Text(
          field.name,
          style: AppTextStyles.bold(fontSize: 18.0, fontColor: AppColors.whiteColor),
        ),
        subtitle: Text(
          field.code,
          style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.whiteColor),
        ),
        trailing: Text(
          field.category,
          style: AppTextStyles.bold(fontSize: 14.0, fontColor: AppColors.whiteColor),
        ),
      ),
    );
  }
}
