import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jumla/app/common/common_text_field.dart';
import 'package:jumla/app/core/app_storage.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:jumla/app/resources/app_styles.dart';

import '../../../../common/common_appbar.dart';
import '../../../../common/common_button.dart';
import '../../../../common/common_picker.dart';
import '../../../../routes/app_pages.dart';
import '../controllers/add_currency_date_formats_controller.dart';

class AddCurrencyDateFormatsView
    extends GetView<AddCurrencyDateFormatsController> {
  const AddCurrencyDateFormatsView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600; // Detect if device is a tablet

    double textSize = isTablet ? 30.0 : 18.0; // Adjust text size for tablets
    double paddingSize = isTablet ? 40.0 : 20.0; // Adjust padding for tablets
    double fieldWidth =
        isTablet ? screenWidth * 0.7 : screenWidth; // Adjust form width
    double buttonHeight = isTablet ? 70 : 30;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar:
          CommonAppBar(title: 'Currency & date formats', showBackButton: true),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: fieldWidth, // Adjust width dynamically
            padding: EdgeInsets.all(paddingSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle("Locale", textSize),
                _buildDivider(),
                SizedBox(
                  height: 16,
                ),
                _buildLocalePicker(context),

                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "Locale is used as the main basis for currency and date formats.",
                    style: AppTextStyles.regular(
                        fontSize: textSize * 0.7,
                        fontColor: AppColors.greyColor),
                  ),
                ),

                SizedBox(height: paddingSize / 2),
                _buildSectionTitle("Date Formats", textSize),
                _buildDivider(),
                SizedBox(height: 10),

                _buildDateFormatRow("Long date:",
                    DateFormat('MMMM d, y').format(DateTime.now()), textSize),
                _buildDateFormatRow("Medium date:",
                    DateFormat('MMM d, y').format(DateTime.now()), textSize),
                _buildDateFormatRow("Short date:",
                    DateFormat('M/d/yy').format(DateTime.now()), textSize),

                SizedBox(height: 10),
                _buildDateFormatPicker(context, textSize),

                SizedBox(height: paddingSize / 2),
                _buildSectionTitle("Currency (optional)", textSize),
                _buildDivider(),
                SizedBox(height: 20),

                // _buildInputLabel("Currency format", textSize),
                _buildTextField(controller.currencyFormatController, "1,234.56",
                    120, textSize),

                _buildDescription(
                  "The format used when showing currency amounts on the screens and printouts. "
                  "By default, this is taken from the selected locale.",
                  textSize,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, top: 5),
                  child: SizedBox(
                    width: 200,
                    child: CommonTextField(
                      label: "",
                      controller: controller.currencySymbolController,
                      prefix: Text("\$",style: AppTextStyles.semiBold(fontSize: 16.0, fontColor: AppColors.blackColor),),
                                         keyboardType: TextInputType.phone,
                    ),
                  ),
                ),
                //   _buildInputLabel("Currency symbol", textSize),\

                _buildDescription(
                  "The currency symbol taken from the locale. Override if necessary.\n\n"
                  "Note: By default, the currency symbol is NOT shown on printouts. Please insert "
                  "the {COMPANY.CURRENCY} tag on print templates to show the value entered here.",
                  textSize,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Get.arguments == "setting"
          ? CommonSaveAndNextButton()
          : Container(
              color: AppColors.blueColor,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: SafeArea(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavButton("NEXT", Routes.ADD_TAX_SETUP, textSize,buttonHeight),
                    SizedBox(width: 10),
                    _buildNavButton("BACK", null, textSize,buttonHeight),
                  ],
                ),
              ),
            ),
    );
  }

  /// **Title for sections like "Locale", "Date Formats", etc.**
  Widget _buildSectionTitle(String title, double textSize) {
    return Text(
      title,
      style: AppTextStyles.regular(
          fontSize: textSize, fontColor: AppStorages.appColor.value),
    );
  }

  /// **Divider for sections**
  Widget _buildDivider() {
    return Container(width: Get.width, height: 1, color: Colors.black26);
  }

  /// **Locale Picker**
  Widget _buildLocalePicker(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CommonPicker.showCountryPopup(context, (v) {
          controller.localeController.value = v;
        });
      },
      child: Obx(() => _buildPickerBox(controller.localeController.value)),
    );
  }

  /// **Date Format Row (Long, Medium, Short)**
  Widget _buildDateFormatRow(String label, String value, double textSize) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        children: [
          SizedBox(
              width: 120,
              child: Text(label,
                  style: AppTextStyles.regular(
                      fontSize: textSize * 0.7,
                      fontColor: AppColors.greyColor))),
          Text(value,
              style: AppTextStyles.medium(
                  fontSize: textSize * 0.8, fontColor: AppColors.greyColor)),
        ],
      ),
    );
  }

  /// **Date Format Picker**
  Widget _buildDateFormatPicker(BuildContext context, double textSize) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Use this format:",
              style: AppTextStyles.semiBold(
                  fontSize: textSize * 0.7, fontColor: AppColors.blackColor)),
          GestureDetector(
            onTap: () {
              CommonPicker.selectDateFormatPopup(context, (v) {
                controller.dateFormatController.value = v;
              });
            },
            child: Obx(
                () => _buildPickerBox(controller.dateFormatController.value)),
          ),
        ],
      ),
    );
  }

  /// **Text Field for Currency**
  Widget _buildTextField(TextEditingController controller, String hint,
      double width, double textSize) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 5),
      child: SizedBox(
        width: 200,
        child: CommonTextField(
          label: hint,
          controller: controller,
        ),
      ),
    );
  }

  /// **Description Text**
  Widget _buildDescription(String text, double textSize) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 5),
      child: Text(
        text,
        style: AppTextStyles.medium(
            fontSize: textSize * 0.7, fontColor: AppColors.greyColor),
      ),
    );
  }

  /// **Navigation Button (NEXT / BACK)**
  Widget _buildNavButton(
      String text, String? route, double textSize, buttonHeight) {
    return Flexible(
      child: InkWell(
          onTap: route != null ? () => Get.toNamed(route) : Get.back,
          child: SizedBox(
            width: double.infinity,
            height: buttonHeight,
            child: Center(
              child: Text(
                text,
                style: AppTextStyles.bold(
                    fontSize: textSize, fontColor: AppColors.whiteColor),
              ),
            ),
          )),
    );
  }

  /// **Picker Box for Locale & Date Format**
  Widget _buildPickerBox(String value) {
    return Container(
      margin: EdgeInsets.only(left: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: AppStorages.appColor.value,
          border: Border.all(width: 1, color: AppColors.greyColor),
          borderRadius: BorderRadius.circular(8.0)),
      child: Text(value,
          style: AppTextStyles.regular(
              fontSize: 15.0, fontColor: AppColors.whiteColor)),
    );
  }
}
