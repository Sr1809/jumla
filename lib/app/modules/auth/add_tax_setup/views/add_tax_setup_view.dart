import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/common/common_picker.dart';

import '../../../../common/common_appbar.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_styles.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/add_tax_setup_controller.dart';

class AddTaxSetupView extends GetView<AddTaxSetupController> {
  const AddTaxSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: 'Tax Setup',showBackButton: true,),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                CommonPicker.selectTaxTypePopup(context, (v) {
                  controller.selectedTaxType.value = v;
                });
                // CommonPopup.showSelectionPopup(
                //   context: context,
                //   title: "Select a tax type",
                //   options: ["No tax", "One tax", "Two taxes", "Two taxes cumulative"],
                //   onSelected: (value) => controller.selectedTaxType.value = value,
                // );
              },
              child:  Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    border: Border.all(width: 1, color: AppColors.greyColor),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.greyColor.withOpacity(0.3),
                        blurRadius: 4,
                        spreadRadius: 1,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Obx(
                    () => Text(
                      controller.selectedTaxType.value,
                      style: AppTextStyles.regular(
                        fontSize: 15.0,
                        fontColor: AppColors.blackColor,
                      ),
                    ),
                  ),
                ),
              ),

            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Tax 1",
                  style: AppTextStyles.regular(
                    fontSize: 16.0,
                    fontColor: AppColors.greyColor,
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    showTaxCodePopup(context);
                  },
                  child: Obx(
                    () => Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        border: Border.all(
                          width: 1,
                          color: AppColors.greyColor,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.greyColor.withOpacity(0.3),
                            blurRadius: 4,
                            spreadRadius: 1,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        controller.selectedTaxCode.value,
                        style: AppTextStyles.regular(
                          fontSize: 15.0,
                          fontColor: AppColors.blackColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => controller.isTaxInclusive.value = !controller.isTaxInclusive.value,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        border: Border.all(color: AppColors.blackColor, width: 1.0),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: controller.isTaxInclusive.value
                          ? Icon(Icons.check, color: AppColors.blueColor, size: 16)
                          : null,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text(
                    "Tax Inclusive Price",
                    style: AppTextStyles.regular(
                      fontSize: 16.0,
                      fontColor: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(color: AppColors.greyColor,thickness: 0.5,),
            Text(
              "This is the tax used by the company. Selected tax is applied to new transactions only.",
              style: AppTextStyles.regular(
                fontSize: 14.0,
                fontColor: AppColors.greyColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "To override this tax at transaction level, open the transaction record > Edit > Apply tax.",
              style: AppTextStyles.regular(
                fontSize: 14.0,
                fontColor: AppColors.greyColor,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColors.blueColor,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: InkWell(
                onTap: () {
                  Get.toNamed(Routes.ADD_DEVICE_NAME);
                },

                child: Text(
                  "NEXT",
                  style: AppTextStyles.bold(
                    fontSize: 16.0,
                    fontColor: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Flexible(
              child: InkWell(
                onTap: () {
                  Get.back();
                },

                child: Text(
                  "BACK",
                  style: AppTextStyles.bold(
                    fontSize: 16.0,
                    fontColor: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showTaxCodePopup(BuildContext context) {
    List<String> actions = ["Cancel", "Add new", "Not Set"];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select a tax code",
                style: AppTextStyles.bold(
                  fontSize: 18.0,
                  fontColor: AppColors.blueColor,
                ),
              ),
              SizedBox(height: 5),
              Divider(color: AppColors.blueColor, thickness: 2),
            ],
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(
                  () => ListView.separated(
                    shrinkWrap: true,
                    primary: true,
                    itemCount: controller.taxCodes.length,
                    separatorBuilder:
                        (context, index) => Divider(color: AppColors.greyColor),
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          controller.taxCodes[index],
                          style: AppTextStyles.regular(
                            fontSize: 16.0,
                            fontColor: AppColors.blackColor,
                          ),
                        ),
                        onTap: () {
                          controller.selectedTaxCode.value =
                              controller.taxCodes[index];
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
                Container(
                  width: Get.width,
                  height: 1,
                  color: AppColors.greyColor,
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    children: List.generate(actions.length, (index) {
                      return Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              right:
                                  index < actions.length - 1
                                      ? BorderSide(
                                        color: AppColors.greyColor,
                                        width: 1,
                                      )
                                      : BorderSide.none,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (index == 0) {
                                Get.back();
                              } else if (index == 1) {
                                Get.back();
                                Get.toNamed(Routes.ADD_TAX_CODE_DATA)!.then((v){
                                  if(v != null){
                                    controller.taxCodes.add(v);
                                    controller.selectedTaxCode.value = v;
                                  }
                                });
                              } else if (index == 2) {
                                Get.back();
                                controller.selectedTaxCode.value = "Not Set";
                              }
                            },
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child: Text(
                              actions[index],
                              style: AppTextStyles.regular(
                                fontSize: 16.0,
                                fontColor: AppColors.blackColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
