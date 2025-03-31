import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../common/common_appbar.dart';
import '../../../common/common_text_field.dart';
import '../../../core/app_storage.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_styles.dart';
import '../../tools/lists/views/item_fields_view.dart';
import '../controllers/sales_order_controller.dart';

class SalesOrderView extends GetView<SalesOrderController> {
  const SalesOrderView({super.key});
  @override
  Widget build(BuildContext context) {
    final selectedItems = <CompanyField>[].obs;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "SALESORDER#____",
        showBackButton: true,
        hideLogo: true,
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: Colors.white),
            onPressed: controller.saveEstimate,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Obx(() => GestureDetector(
                    child: AbsorbPointer(
                      child: CommonTextFieldWithTitle(
                        controller: TextEditingController(text: controller.selectedCustomer.value),
                        label: 'Customer',

                      ),
                    ),
                  )),
                ),
                IconButton(
                  padding: EdgeInsets.only(bottom: 20),
                  onPressed: controller.selectCustomer,
                  icon: Icon(Icons.person),
                )
              ],
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: controller.selectProject,
              child: AbsorbPointer(
                child: Obx(() => CommonTextFieldWithTitle(
                  controller: TextEditingController(text: controller.project.value), label: 'Project',
                )),
              ),
            ),
            SizedBox(height: 10),

            GestureDetector(
              onTap: controller.selectStatus,
              child: AbsorbPointer(
                child: Obx(() => CommonTextFieldWithTitle(

                  controller: TextEditingController(text: controller.status.value), label: 'Status',
                )),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Obx(() => GestureDetector(
                    onTap: controller.selectDate,
                    child: AbsorbPointer(
                      child: CommonTextFieldWithTitle(
                        controller: TextEditingController(text: controller.date.value), label: 'Date',
                      ),
                    ),
                  )),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Obx(() => GestureDetector(
                    onTap: controller.selectExpiryDate,
                    child: AbsorbPointer(
                      child: CommonTextFieldWithTitle(
                        controller: TextEditingController(text: controller.expiryDateText.value), label: 'Expires',
                      ),
                    ),
                  )),
                ),
                // Expanded(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text("", style: AppTextStyles.bold(fontSize: 16.0,fontColor: AppColors.blackColor)),
                //       Obx(() => CommonTextField(
                //         controller: TextEditingController(text: controller.expiryLabel.value), label: '',
                //       )),
                //     ],
                //   ),
                // ),
              ],
            ),
            SizedBox(height: 10),

            CommonTextFieldWithTitle(label: "Bill Address", controller: controller.memoController),
            CommonTextFieldWithTitle(label: "Ship Address", controller: controller.memoController),

            CommonTextFieldWithTitle(label: "Memo", controller: controller.memoController),
            SizedBox(height: 10),
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
                          selectedItems.value = v;
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
              itemCount: selectedItems.length,
              itemBuilder: (context, index) {
                var field = selectedItems[index];
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
