import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/modules/tools/settings/app_settings/views/paypal_setup_view.dart';
import 'package:jumla/app/modules/tools/settings/app_settings/views/pdf_option_view.dart';
import 'package:jumla/app/modules/tools/settings/app_settings/views/project_setting.dart';
import 'package:jumla/app/modules/tools/settings/app_settings/views/recurring_transactions_view.dart';
import 'package:jumla/app/modules/tools/settings/app_settings/views/signature_setting.dart';
import 'package:jumla/app/modules/tools/settings/app_settings/views/tax_code_view.dart';
import 'package:jumla/app/modules/tools/settings/app_settings/views/watermark_view.dart';
import '../../../../../common/common_appbar.dart';
import '../../../../../resources/app_colors.dart';
import '../../../../../resources/app_styles.dart';
import '../../../../../core/app_storage.dart';
import '../../../../../routes/app_pages.dart';
import '../controllers/app_settings_controller.dart';
import 'company_name_and_address.dart';
import 'companyy_logo_view.dart';
import 'default_status_view.dart';
import 'default_terms.dart';
import 'file_name_view.dart';
import 'language_output_view.dart';
import 'manage_company_view.dart';
import 'override_label_date_view.dart';

class AppSettingsView extends GetView<AppSettingsController> {
  const AppSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    double textSize = isTablet ? 30.0 : 18.0;
    double paddingSize = isTablet ? 40.0 : 20.0;
    double containerWidth =  screenWidth;


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
                  _buildTapableItem("Company Name & Address", "Basic info about your company", ()=>Get.to(()=>CompanyInfoView())),
                  _buildTapableItem("Company Logo", "Set the logo that appears on printouts", () =>Get.to(()=>CompanyLogoScreen())),
                  _buildTapableItem("Currency & Date Formats", "Set how currencies and dates are formatted", ()=>Get.toNamed(Routes.ADD_CURRENCY_DATE_FORMATS,arguments: "setting")),
                  _buildTapableItem("PayPal", "Configure to show PayPal links on invoices and emails", ()=>Get.to(()=>PayPalSetupScreen())),
                  _buildTapableItem("Manage Companies", "Add, remove, or switch to a different company", ()=>Get.to(()=>ManageCompaniesScreen())),
                ]),

                /// **Device Settings**
                _buildSection("DEVICE INFO", textSize, [
                  _buildTapableItem("Device Name", "Give your device a name",()=>Get.toNamed(Routes.ADD_DEVICE_NAME,arguments: "setting")),
                  _buildCheckboxItem("Use Screen Unlock", "If checked, a PIN is required to open the app", controller.useScreenUnlock),
                  _buildTapableItem("Set Up PIN", "Enter or reset your PIN number", () {}),
                ]),

                /// **Taxes**
                _buildSection("TAXES", textSize, [
                  _buildTapableItem("One Tax", "Tax type", ()=>Get.toNamed(Routes.ADD_TAX_SETUP,arguments: "setting")),
                  _buildTapableItem("Manage Tax Codes", "Create or modify pre-defined tax codes", () =>Get.to(()=>TaxCodesScreen())),
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
                  _buildTapableItem("Default Terms", "Set the number of days when a quote expires or an invoice becomes due", ()=>Get.to(()=>DefaultTermsView())),
                  _buildTapableItem("Default Statuses", "Set the default status when orders and quotes are created", ()=>Get.to(()=>DefaultStatusScreen())),
                  _buildCheckboxItem("Discount Before Tax", "On new transactions, discounts are applied before tax is calculated.", controller.discountBeforeTax, ),
                  _buildCheckboxItem("No Dates on Notes", "When printing public notes, don't show the date.", controller.noDatesOnNotes,),
                  _buildCheckboxItem("Create Note After Email/SMS", "After sending a transaction by email or SMS, create a note.", controller.createNoteAfterEmailSms, ),
                  _buildTapableItem("Projects", "Ability to create projects for customers and assign them to invoices", ()=>Get.to(()=>ProjectSettingsScreen())),
                  _buildTapableItem("Signatures", "Ability to capture signatures on invoices", ()=>Get.to(()=>SignatureSettingsScreen())),
                  _buildTapableItem("Recurring Transactions", "Setup repetitive transactions and auto-create them on a schedule", ()=>Get.to(()=>RecurringTransactionsScreen())),
                ]),
                _buildSection("PRINTING", textSize, [
                  _buildTapableItem("Language Output", "Select the language to use for print output", ()=>Get.to(()=>LanguageOutputScreen())),
                  _buildTapableItem("Sale Totals", "Modify how totals are shown on printouts", ()=>showSaleTotalsPopup()),
                  _buildTapableItem("Sale Columns", "Modify how line items are shown on printouts", ()=>showSaleTotalsPopup()),
                  _buildTapableItem("Extra Grid", "Show more info above invoice lines", ()=>showSaleTotalsPopup()),
                  _buildTapableItem("Other Template Areas", "Bill To, Ship To, Payment Details, etc.", () {}),
                  _buildTapableItem("Override Labels & Dates", "Changes here affect only printouts", ()=>Get.to(()=>OverrideLabelsScreen())),
                ]),
                _buildSection("DOCUMENT", textSize, [
                  _buildTapableItem("PDF Options", "PDF page size, orientation, and security", ()=>Get.to(()=>PdfOptionsScreen())),
                  _buildTapableItem("File Names", "Control how generated PDF files are named", ()=>Get.to(()=>FileNamesScreen())),
                  _buildTapableItem("Watermark", "Show watermark based on transaction status", ()=>Get.to(()=>WatermarkSettingsScreen())),
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
                  _buildTapableItem("Dropbox", "Enable access to Dropbox", ()=>Get.toNamed(Routes.DROPBOX)),
                ]),

                /// **Items**
                _buildSection("ITEMS", textSize, [
                  _buildCheckboxItem("Use Item Pictures", "If checked, item records can add/display pictures.", controller.useItemPictures, ),
                  _buildTapableItem("Item Type", "Set the default type when adding new items", ()=>showItemTypeDialog()),

                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }



  void showItemTypeDialog() {
    Get.defaultDialog(
      title: "Choose an item type",
      titleStyle: AppTextStyles.bold(
        fontSize: 18.0,
        fontColor: AppStorages.appColor.value,
      ),
      backgroundColor: AppColors.whiteColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      content: Column(
        children: [
          Divider(color: AppStorages.appColor.value, thickness: 1),
          Column(
            children: [
              _buildItemTypeTile("Non-inventory Item"),
              _buildItemTypeTile("Inventory Item"),
              _buildItemTypeTile("Service Item"),
              _buildItemTypeTile("Shipping Item"),
              _buildItemTypeTile("Description Item"),
            ],
          ),
          SizedBox(height: 10),
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              "Cancel",
              style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemTypeTile(String title) {
    return InkWell(
      onTap: () {
        Get.back(result: title);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.regular(
                  fontSize: 16.0,
                  fontColor: AppColors.blackColor,
                ),
              ),
            ),
            Obx(
                  () => Radio(
                value: title,
                groupValue: controller.selectedItem.value,
                activeColor: AppStorages.appColor.value,
                onChanged: (value) {
                  controller. selectedItem.value = value as String;
                  Get.back(result: value);
                },
              ),
            ),
          ],
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


  void showSaleTotalsPopup() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Sale totals",
                style: AppTextStyles.bold(fontSize: 20.0, fontColor: AppStorages.appColor.value),
              ),
              Divider(color: AppStorages.appColor.value, thickness: 1),
              ...[
                "On quotes",
                "On sales orders",
                "On invoices",
                "On cash sales",
                "On purchase orders"
              ].map((option) =>  ListTile(
                title: Text(
                  option,
                  style: AppTextStyles.regular(fontSize: 18.0, fontColor: Colors.black),
                ),
                subtitle: Text(
                  "Customize sale totals on $option",
                  style: AppTextStyles.regular(fontSize: 14.0, fontColor: Colors.grey),
                ),
                onTap: () => Get.back(),
              )).toList(),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Get.back(),
                  child: Text("Cancel", style: TextStyle(color: AppStorages.appColor.value)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
