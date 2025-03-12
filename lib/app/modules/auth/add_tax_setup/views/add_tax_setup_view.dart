import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/common/common_picker.dart';
import 'package:jumla/app/core/app_storage.dart';

import '../../../../common/common_appbar.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_styles.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/add_tax_setup_controller.dart';

class AddTaxSetupView extends GetView<AddTaxSetupController> {
  const AddTaxSetupView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600; // Detect if the device is a tablet

    double textSize = isTablet ? 30.0 : 18.0; // Adjust font size
    double paddingSize = isTablet ? 40.0 : 20.0; // Adjust padding
    double fieldWidth = isTablet ? screenWidth * 0.7 : screenWidth * 0.9; // Adjust form width

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: 'Tax Setup', showBackButton: true),

      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: fieldWidth, // Adjust width dynamically
            padding: EdgeInsets.all(paddingSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildSectionTitle("Select Tax Type", textSize),
                _buildPickerBox(context, controller.selectedTaxType, () {
                  CommonPicker.selectTaxTypePopup(context, (v) {
                    controller.selectedTaxType.value = v;
                  });
                }),

                SizedBox(height: paddingSize / 2),
                _buildSectionTitle("Tax 1", textSize),
                _buildPickerBox(context, controller.selectedTaxCode, () {
                  showTaxCodePopup(context);
                }),

                SizedBox(height: paddingSize / 2),
                _buildTaxInclusiveCheckbox(textSize),

                Divider(color: AppColors.greyColor, thickness: 0.5),
                _buildDescription(
                  "This is the tax used by the company. The selected tax is applied to new transactions only.",
                  textSize,
                ),
                _buildDescription(
                  "To override this tax at the transaction level, open the transaction record > Edit > Apply tax.",
                  textSize,
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: Container(
        color: AppColors.blueColor,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavButton("NEXT", Routes.ADD_DEVICE_NAME, textSize),
            SizedBox(width: 10),
            _buildNavButton("BACK", null, textSize),
          ],
        ),
      ),
    );
  }

  /// **Title for sections like "Select Tax Type", "Tax 1"**
  Widget _buildSectionTitle(String title, double textSize) {
    return Text(
      title,
      style: AppTextStyles.regular(fontSize: textSize, fontColor: AppColors.greyColor),
    );
  }

  /// **Picker Box (For Selecting Tax Type & Tax Code)**
  Widget _buildPickerBox(BuildContext context, RxString selectedValue, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Obx(() => Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: AppStorages.appColor.value,
          border: Border.all(width: 1, color: AppStorages.appColor.value),
          borderRadius: BorderRadius.circular(8.0)
        ),
        child: Text(
          selectedValue.value,
          style: AppTextStyles.regular(fontSize: 15.0, fontColor: AppColors.whiteColor),
        ),
      )),
    );
  }

  /// **Tax Inclusive Checkbox**
  Widget _buildTaxInclusiveCheckbox(double textSize) {
    return Obx(
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
          SizedBox(width: 10),
          Text(
            "Tax Inclusive Price",
            style: AppTextStyles.regular(fontSize: textSize, fontColor: AppColors.blackColor),
          ),
        ],
      ),
    );
  }

  /// **Description Text**
  Widget _buildDescription(String text, double textSize) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        text,
        style: AppTextStyles.regular(fontSize: textSize * 0.7, fontColor: AppColors.greyColor),
      ),
    );
  }

  /// **Navigation Button (NEXT / BACK)**
  Widget _buildNavButton(String text, String? route, double textSize) {
    return Flexible(
      child: InkWell(
        onTap: route != null ? () => Get.toNamed(route) : Get.back,
        child: Text(
          text,
          style: AppTextStyles.bold(fontSize: textSize, fontColor: AppColors.whiteColor),
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
          backgroundColor: AppColors.whiteColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
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
