import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/common_appbar.dart';
import '../../../../../common/common_button.dart';
import '../../../../../common/common_text_field.dart';
import '../../../../../core/app_storage.dart';
import '../../../../../resources/app_colors.dart';
import '../../../../../resources/app_styles.dart';
import '../controllers/app_settings_controller.dart';


class PayPalSetupScreen  extends GetView<AppSettingsController> {
const PayPalSetupScreen({super.key});

@override
Widget build(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  bool isTablet = screenWidth > 600;
  double textSize = isTablet ? 30.0 : 18.0;
  double paddingSize = isTablet ? 40.0 : 20.0;
  double buttonHeight = isTablet ? 70 : 40;


  return Scaffold(
    backgroundColor: Colors.white,
    appBar: CommonAppBarWithTitleAndIcon(
      title: "PayPal Setup",
      showBackButton: true,
      hideLogo: true,
      actions: [
        IconButton(icon: Icon(Icons.save), onPressed: ()=>Get.back()),
      ],
    ),
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
          IconButton(
            icon: Icon(Icons.close, color: Colors.white, size: textSize),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    ),
    body: Padding(
      padding: EdgeInsets.all(paddingSize),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Required Info", style: AppTextStyles.bold(fontSize: textSize, fontColor: Colors.black)),
            SizedBox(height: 10),

            // **Business ID Input**
            CommonTextFieldWithTitle(
              controller: controller.businessIdController,
              label: "Business Id",
              hint: "Enter your PayPal Merchant Id or your PayPal email address",
            ),
            SizedBox(height: 20),

            // **Country Selection**
            Obx(() => _buildDropdownField("Country", controller.selectedCountry.value, controller.showCountrySelection)),
            SizedBox(height: 20),

            // **Currency Selection**
            Obx(() => _buildDropdownField("Currency", controller.selectedCurrency.value, controller.showCurrencySelection)),
            SizedBox(height: 30),

            Text("PayPal link generation", style: AppTextStyles.bold(fontSize: textSize, fontColor: Colors.black)),
            SizedBox(height: 10),

            // **Pay Now Text**
            CommonTextFieldWithTitle(
              controller: controller.payNowTextController,
              label: "Pay Now Text",
              hint: "Pay with PayPal",
            ),
            SizedBox(height: 20),

            // **Pay Now Button**
            CommonTextFieldWithTitle(
              controller: controller.payNowButtonController,
              label: "Pay Now Button",
              hint: "http://mywebsite.com/paypal_button",
            ),
            SizedBox(height: 30),

            Text("PayPal links and buttons only appear when all these conditions are satisfied:",
                style: AppTextStyles.bold(fontSize: textSize * 0.8, fontColor: Colors.black)),
            SizedBox(height: 10),

            _buildConditionText("An invoice record with a non-zero balance is emailed"),
            _buildConditionText("{PAYPAL.BTN} is added to print template"),
            _buildConditionText("{PAYPAL.LINK} is added to email template"),
            _buildConditionText("Business ID, Country, and Currency should not be blank"),
          ],
        ),
      ),
    ),
  );
}

/// **Reusable Dropdown Field**
Widget _buildDropdownField(String label, String value, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: Get.width*0.7,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(value, style: AppTextStyles.regular(fontSize: 18.0, fontColor: Colors.black)),
          Icon(Icons.arrow_drop_down, color: Colors.black),
        ],
      ),
    ),
  );
}

/// **Reusable Condition Text**
Widget _buildConditionText(String text) {
  return Padding(
    padding: EdgeInsets.only(left: 100, bottom: 5),
    child: Row(
      children: [
        Icon(Icons.check_circle, color: AppStorages.appColor.value, size: 18),
        SizedBox(width: 8),
        Expanded(child: Text(text, style: AppTextStyles.regular(
            fontSize: 16.0, fontColor: Colors.black))),
      ],
    ),
  );
}}