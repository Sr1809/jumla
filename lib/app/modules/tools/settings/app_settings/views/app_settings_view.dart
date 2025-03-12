import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/common_appbar.dart';
import '../../../../../resources/app_styles.dart';
import '../../../../../core/app_storage.dart';
import '../controllers/app_settings_controller.dart';

class AppSettingsView extends GetView<AppSettingsController> {
  const AppSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    double textSize = isTablet ? 30.0 : 18.0;
    double paddingSize = isTablet ? 40.0 : 20.0;
    double containerWidth =  screenWidth;
    double checkboxSize = isTablet ? 40 : 24;
    double checkboxIconSize = isTablet ? 30 : 20;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Settings",
        showBackButton: true,
        hideLogo: true,
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: containerWidth, // ✅ Responsive width
          padding: EdgeInsets.all(paddingSize),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// **Company Settings**
                _buildSection("COMPANY SETTINGS", textSize, [
                  _buildTapableItem("Company Name & Address", "Basic info about your company", () {}),
                  _buildTapableItem("Company Logo", "Set the logo that appears on printouts", () {}),
                  _buildTapableItem("Currency & Date Formats", "Set how currencies and dates are formatted", () {}),
                  _buildTapableItem("PayPal", "Configure to show PayPal links on invoices and emails", () {}),
                  _buildTapableItem("Manage Companies", "Add, remove, or switch to a different company", () {}),
                ]),

                /// **Device Settings**
                _buildSection("DEVICE INFO", textSize, [
                  _buildTapableItem("Device Name", "Give your device a name", () {}),
                  _buildCheckboxItem("Use Screen Unlock", "If checked, a PIN is required to open the app", controller.useScreenUnlock),
                  _buildTapableItem("Set Up PIN", "Enter or reset your PIN number", () {}),
                ]),

                /// **Taxes**
                _buildSection("TAXES", textSize, [
                  _buildTapableItem("One Tax", "Tax type", () {}),
                  _buildTapableItem("Manage Tax Codes", "Create or modify pre-defined tax codes", () {}),
                ]),

                /// **Transaction Numbers**
                _buildSection("TRANSACTION NUMBERS", textSize, [
                  Text(
                    "    Setting these numbers is done ONLINE",
                    style: AppTextStyles.regular(fontSize: textSize * 0.7, fontColor: Colors.grey),
                  ),
                  _buildTapableItem("Next Number", "Next number", () {}),
                  _buildTapableItem("Custom Number Format", "Modify how transaction numbers are formatted, e.g., add prefix, suffix, etc.", () {}),
                ]),

                /// **Invoicing**
                _buildSection("INVOICING", textSize, [
                  _buildTapableItem("Default Terms", "Set the number of days when a quote expires or an invoice becomes due", () {}),
                  _buildTapableItem("Default Statuses", "Set the default status when orders and quotes are created", () {}),
                  _buildCheckboxItem("Discount Before Tax", "On new transactions, discounts are applied before tax is calculated.", controller.discountBeforeTax, ),
                  _buildCheckboxItem("No Dates on Notes", "When printing public notes, don't show the date.", controller.noDatesOnNotes,),
                  _buildCheckboxItem("Create Note After Email/SMS", "After sending a transaction by email or SMS, create a note.", controller.createNoteAfterEmailSms, ),
                  _buildTapableItem("Projects", "Ability to create projects for customers and assign them to invoices", () {}),
                  _buildTapableItem("Signatures", "Ability to capture signatures on invoices", () {}),
                  _buildTapableItem("Recurring Transactions", "Setup repetitive transactions and auto-create them on a schedule", () {}),
                ]),
                _buildSection("PRINTING", textSize, [
                  _buildTapableItem("Language Output", "Select the language to use for print output", () {}),
                  _buildTapableItem("Sale Totals", "Modify how totals are shown on printouts", () {}),
                  _buildTapableItem("Sale Columns", "Modify how line items are shown on printouts", () {}),
                  _buildTapableItem("Extra Grid", "Show more info above invoice lines", () {}),
                  _buildTapableItem("Other Template Areas", "Bill To, Ship To, Payment Details, etc.", () {}),
                  _buildTapableItem("Override Labels & Dates", "Changes here affect only printouts", () {}),
                ]),
                _buildSection("DOCUMENT", textSize, [
                  _buildTapableItem("PDF Options", "PDF page size, orientation, and security", () {}),
                  _buildTapableItem("File Names", "Control how generated PDF files are named", () {}),
                  _buildTapableItem("Watermark", "Show watermark based on transaction status", () {}),
                ]),
                _buildSection("INVENTORY", textSize, [
                  _buildCheckboxItem("Show Available Items Only", "Show only items with available stock", controller.showAvailableItemsOnly),
                  _buildCheckboxItem("Show On Hand Items Only", "Show only items with on-hand stock", controller.showOnHandItemsOnly),
                ]),
                /// **Permissions**
                _buildSection("PERMISSIONS", textSize, [
                  _buildCheckboxItem("No Delete of Transactions", "Only Super Admin can delete invoices/cash sales.", controller.noDeleteOfTransactions),
                ]),


                /// **External Services**
                _buildSection("EXTERNAL SERVICES", textSize, [
                  _buildTapableItem("Dropbox", "Enable access to Dropbox", () {}),
                ]),

                /// **Items**
                _buildSection("ITEMS", textSize, [
                  _buildCheckboxItem("Use Item Pictures", "If checked, item records can add/display pictures.", controller.useItemPictures, ),
                  _buildTapableItem("Item Type", "Set the default type when adding new items", () {}),

                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// **Reusable Section Builder**
  Widget _buildSection(String title, double textSize, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            title,
            style: AppTextStyles.bold(fontSize: textSize, fontColor: AppStorages.appColor.value),
          ),
        ),
        Divider(color: Colors.grey, thickness: 1),
        ...children,
      ],
    );
  }

  /// **Reusable Tappable Item with Responsive Text Sizes**
  Widget _buildTapableItem(String title, String subtitle, VoidCallback onTap) {
    double screenWidth = Get.width;
    bool isTablet = screenWidth > 600;

    double titleFontSize = isTablet ? 25.0 : 16.0;
    double subtitleFontSize = isTablet ? 22.0 : 13.0;

    return ListTile(
     /* contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 5.0),*/
      title: Text(
        title,
        style: AppTextStyles.regular(fontSize: titleFontSize, fontColor: Colors.black),
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.regular(fontSize: subtitleFontSize, fontColor: Colors.grey),
      ),
      onTap: onTap,
    );
  }


  /// **Reusable Checkbox Item with Responsive Text Sizes and Trailing Checkbox**
  Widget _buildCheckboxItem(String title, String subtitle, RxBool value) {
    double screenWidth = Get.width;
    bool isTablet = screenWidth > 600;

    double titleFontSize = isTablet ? 25.0 : 16.0;
    double subtitleFontSize = isTablet ? 22.0 : 13.0;
    double checkboxSize = isTablet ? 40 : 24;
    double checkboxIconSize = isTablet ? 30 : 20;

    return Obx(() => ListTile(
      title: Text(
        title,
        style: AppTextStyles.regular(fontSize: titleFontSize, fontColor: Colors.black),
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.regular(fontSize: subtitleFontSize, fontColor: Colors.grey),
      ),
      trailing: GestureDetector(
        onTap: () => value.value = !value.value,
        child: Container(
          width: checkboxSize,
          height: checkboxSize,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: value.value
              ? Center(
            child: Icon(Icons.check, color: AppStorages.appColor.value, size: checkboxIconSize),
          )
              : null,
        ),
      ),
    ));
  }

}
