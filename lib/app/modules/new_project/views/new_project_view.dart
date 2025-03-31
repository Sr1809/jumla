import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jumla/app/core/app_storage.dart';

import '../../../common/common_appbar.dart';
import '../../../common/common_text_field.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_styles.dart';
import '../../tools/lists/views/item_fields_view.dart';
import '../controllers/new_project_controller.dart';

class NewProjectView extends GetView<NewProjectController> {
  const NewProjectView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "New project",
        showBackButton: true,
        hideLogo: true,
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: Colors.white),
            onPressed: controller.saveProject,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Customer
            Obx(() => AbsorbPointer(
              child: CommonTextFieldWithTitle(
                label: "Customer",
                controller: TextEditingController(text: controller.customerName.value),

              ),
            )),
            // Project name
            CommonTextFieldWithTitle(
              label: "Project name",
              controller: controller.projectNameController,
            ),
            // Project description
            CommonTextFieldWithTitle(
              label: "Project description",
              controller: controller.projectDescController,
            ),
            SizedBox(height: 10),
            // Start and End Date
            Row(
              children: [
                Expanded(
                  child: Obx(() => GestureDetector(
                    onTap: controller.selectStartDate,
                    child: AbsorbPointer(
                      child: CommonTextFieldWithTitle(
                        label: "Start date",
                        controller: TextEditingController(text: controller.startDateText.value),
                      ),
                    ),
                  )),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Obx(() => GestureDetector(
                    onTap: controller.selectEndDate,
                    child: AbsorbPointer(
                      child: CommonTextFieldWithTitle(
                        label: "End date",
                        controller: TextEditingController(text: controller.endDateText.value),
                      ),
                    ),
                  )),
                ),

              ],
            ),
            SizedBox(height: 10),
            // Status
            GestureDetector(
              onTap: controller.selectStatus,
              child: AbsorbPointer(
                child: Obx(() => CommonTextFieldWithTitle(
                  label: "Status",
                  controller: TextEditingController(text: controller.status.value),
                )),
              ),
            ),
            SizedBox(height: 10),
            // Addresses
            CommonTextFieldWithTitle(
              label: "Bill Address",
              controller: controller.billAddressController,
            ),
            CommonTextFieldWithTitle(
              label: "Ship Address",
              controller: controller.shipAddressController,
            ),
            SizedBox(height: 10),
            // Contact
            Text("Contact", style: AppTextStyles.bold(fontSize: 16.0,fontColor: AppColors.blackColor)),
            CommonTextFieldWithTitle(
              label: "Name",
              controller: controller.contactNameController,
            ),
            CommonTextFieldWithTitle(
              label: "Email",
              controller: controller.contactEmailController,
            ),
            CommonTextFieldWithTitle(
              label: "Phone",
              controller: controller.contactPhoneController,
            ),
            SizedBox(height: 20),
            // Custom Fields
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppStorages.appColor.value,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("CUSTOM FIELDS",
                      style: AppTextStyles.bold(
                          fontColor: AppColors.whiteColor, fontSize: 16.0)),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => ItemFieldListView("item"))!.then((v) {
                        if (v != null) {
                          controller.selectedItems.value = v;
                        }
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        color: Colors.white,
                        child: Text("Add / Edit")),
                  )
                ],
              ),
            ),
            Obx(() => ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              itemCount: controller.selectedItems.length,
              itemBuilder: (context, index) {
                var field = controller.selectedItems[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 1,
                  child: Obx(() => ListTile(
                    dense: true,
                    tileColor: AppStorages.appColor.value.withOpacity(0.1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    title: Text(
                      field.name.value,
                      style: AppTextStyles.bold(
                          fontSize: 16.0,
                          fontColor: !field.isActive.value
                              ? Colors.red
                              : AppColors.blackColor),
                    ),
                    subtitle: Text(
                      field.code.value,
                      style: AppTextStyles.regular(
                          fontSize: 14.0, fontColor: AppColors.darkGrey),
                    ),
                  )),
                );
              },
            )),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
