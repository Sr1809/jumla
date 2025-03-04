import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../common/common_appbar.dart';
import '../../../../../resources/app_colors.dart';
import '../../../../../resources/app_styles.dart';
import '../controllers/app_settings_controller.dart';

class AppSettingsView extends GetView<AppSettingsController> {
  const AppSettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Settings",
        showBackButton: true,
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: AppColors.whiteColor),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection("TEST", [
              _buildTapableItem("Company name & address", "Basic info about your company", () {}),
              Divider(color: AppColors.darkGrey, thickness: 0.5,height: 1,),
              _buildTapableItem("Company logo", "Set the logo that appears on printouts", () {}),
              Divider(color: AppColors.darkGrey, thickness: 0.5,height: 1,),
              _buildTapableItem("Currency & date formats", "Set how currencies and dates are formatted", () {}),
              Divider(color: AppColors.darkGrey, thickness: 0.5,height: 1,),
              _buildTapableItem("PayPal", "Configure to show PayPal links on invoices and emails", () {}),
              Divider(color: AppColors.darkGrey, thickness: 0.5,height: 1,),
              _buildTapableItem("Manage companies", "Add, remove, or switch to a different company", () {}),
            ]),
            _buildSection("DEVICE INFO", [
              _buildTapableItem("Device name", "Give your device a name", () {}),
              Divider(color: AppColors.darkGrey, thickness: 0.5,height: 1,),
              _buildCheckboxItem("Use screen unlock", "If checked, a PIN is required to open the app", controller.useScreenUnlock),
              Divider(color: AppColors.darkGrey, thickness: 0.5,height: 1,),

              ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
                title: Text(
                  "Set up PIN",
                  style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.greyColor),
                ),
                subtitle: Text(
                  "Enter or reset your PIN number",
                  style: AppTextStyles.regular(fontSize: 12.0, fontColor: AppColors.greyColor),
                ),
              ),

            ]),
            _buildSection("TAXES", [
              _buildTapableItem("One tax", "Tax type", () {}),
              Divider(color: AppColors.darkGrey, thickness: 0.5,height: 1,),
              _buildTapableItem("Manage tax codes", "Create or modify pre-defined tax codes", () {}),
            ]),
            _buildSection("TRANSACTION NUMBERS", [
              Text(
                "    Setting these numbers is done ONLINE",
                style: AppTextStyles.regular(fontSize: 12.0, fontColor: AppColors.greyColor),
              ),
              _buildTapableItem("Next number", "Next number", () {}),
              Divider(color: AppColors.darkGrey, thickness: 0.5,height: 1,),
              _buildTapableItem("Custom number format", "Modify how transaction numbers are formatted, e.g., add prefix, suffix, etc.", () {}),
            ]),
            _buildSection("INVOICING", [
              _buildTapableItem("Default terms", "Set the number of days when quote expires or invoice becomes due", () {}),
              Divider(color: AppColors.darkGrey, thickness: 0.5,height: 1,),
              _buildTapableItem("Default statuses", "Set the default status when orders and quotes are created", () {}),
              Divider(color: AppColors.darkGrey, thickness: 0.5,height: 1,),
              _buildCheckboxItem("Discount before tax", "On new transactions, discounts are applied before tax is calculated.", controller.discountBeforeTax),
              Divider(color: AppColors.darkGrey, thickness: 0.5,height: 1,),
              _buildCheckboxItem("No dates on notes", "When printing public notes, don't show the date.", controller.noDatesOnNotes),
              Divider(color: AppColors.darkGrey, thickness: 0.5,height: 1,),
              _buildCheckboxItem("Create note after email/sms", "After sending transaction by email or SMS, create a note.", controller.createNoteAfterEmailSms),
              Divider(color: AppColors.darkGrey, thickness: 0.5,height: 1,),
              _buildTapableItem("Projects", "Ability to create projects for customer and assign to invoices",(){}),
              Divider(color: AppColors.darkGrey, thickness: 0.5,height: 1,),
              _buildTapableItem("Signatures", "Ability to capture signatures on invoices",(){}),
              Divider(color: AppColors.darkGrey, thickness: 0.5,height: 1,),
              _buildTapableItem("Recurring Transactions", "Setup repetitive transactions and auto-create them on a schedule",(){}),

            ]),
            _buildSection("PERMISSIONS", [
              _buildCheckboxItem("No delete of transactions", "Only Super Admin can delete invoice/cash sale.", controller.noDeleteOfTransactions),
            ]),
            _buildSection("EXTERNAL SERVICES", [
              _buildTapableItem("Dropbox", "Enable access to Dropbox", () {}),
            ]),
            _buildSection("ITEMS", [
              _buildCheckboxItem("Use item pictures", "If checked, item records can add/display pictures.", controller.useItemPictures),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            title,
            style: AppTextStyles.bold(fontSize: 15.0, fontColor: AppColors.blueColor),
          ),
        ),
        Divider(color: AppColors.greyColor, thickness: 1),
        ...children,
      ],
    );
  }

  Widget _buildTapableItem(String title, String subtitle, VoidCallback onTap) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
      title: Text(
        title,
        style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor),
      ),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.regular(fontSize: 12.0, fontColor: AppColors.greyColor),
      ),
      onTap: onTap,
    );
  }

  Widget _buildCheckboxItem(String title, String subtitle, RxBool value) {
    return Column(
      children: [
        Obx(() => CheckboxListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 5.0),
          title: Text(
            title,
            style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor),
          ),
          subtitle: Text(
            subtitle,
            style: AppTextStyles.regular(fontSize: 12.0, fontColor: AppColors.greyColor),
          ),
          value: value.value,
          onChanged: (newValue) => value.value = newValue!,
        )),
      ],
    );
  }
}
