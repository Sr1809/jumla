import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/modules/tools/settings/app_settings/views/payment_template_view.dart';
import 'package:jumla/app/modules/tools/settings/app_settings/views/sales_template_view.dart';
import '../../../../../common/common_appbar.dart';
import '../../../../../core/app_storage.dart';
import '../../../../../resources/app_colors.dart';
import '../../../../../resources/app_styles.dart';

class OverrideLabelsController extends GetxController {}

class OverrideLabelsScreen extends StatelessWidget {
  final OverrideLabelsController controller = Get.put(OverrideLabelsController());

  @override
  Widget build(BuildContext context) {
    double paddingSize = MediaQuery.of(context).size.width > 600 ? 40.0 : 20.0;
    double titleFontSize = MediaQuery.of(context).size.width > 600 ? 25.0 : 18.0;
    double subtitleFontSize = MediaQuery.of(context).size.width > 600 ? 22.0 : 14.0;
    double sectionFontSize = MediaQuery.of(context).size.width > 600 ? 22.0 : 16.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Override labels & dates",
        showBackButton: true,
        hideLogo: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingSize, vertical: 10),
        child: ListView(
          children: [
            _buildSectionTitle("TRANSACTION TYPE LABELS", sectionFontSize),
Divider(),
            _buildListTile("Estimate", "Label for quotes when it is printed", titleFontSize, subtitleFontSize,()=>showLabelEditPopup(context,"Label for Estimate")),
            _buildListTile("Sales Order", "Label for sales orders when it is printed", titleFontSize,  subtitleFontSize,()=>showLabelEditPopup(context,"Label for Sales Order")),
            _buildListTile("Cash Sale", "Label for cash sales when it is printed", titleFontSize,  subtitleFontSize,()=>showLabelEditPopup(context,"Label for Cash Sale")),
            _buildListTile("Invoice", "Label for invoices when it is printed", titleFontSize,  subtitleFontSize,()=>showLabelEditPopup(context,"Label for Invoice")),
            _buildListTile("Payment", "Label for payments when it is printed", titleFontSize,  subtitleFontSize,()=>showLabelEditPopup(context,"Label for Payment")),
            _buildListTile("Purchase Order", "Label for purchase orders when it is printed", titleFontSize,  subtitleFontSize,()=>showLabelEditPopup(context,"Label for Purchase Order")),

            _buildSectionTitle("CHANGE LABELS ON PRINT TEMPLATES", sectionFontSize),
            Divider(),
            _buildListTile("Sales template", "Override default text seen in MobileBiz Sales Template", titleFontSize,  subtitleFontSize,()=>Get.to(()=>SalesTemplateView())),
            _buildListTile("Payment template", "Override default text seen in MobileBiz Payment Template", titleFontSize,  subtitleFontSize,()=>Get.to(()=>ChangeTextPaymentScreen())),

            _buildSectionTitle("PRINT DATE FORMATS", sectionFontSize),
            Divider(),
            _buildListTile("Transaction date", "Date format used to display the transaction date on printouts", titleFontSize,  subtitleFontSize,()=>showDateFormatPopup(context)),
            _buildListTile("Due Date", "Date format used to display the due/expiry dates on printouts", titleFontSize,  subtitleFontSize,()=>showDateFormatPopup(context)),
            _buildListTile("Other date", "Date format used to display other dates (notes, custom fields, etc.) on printouts", titleFontSize,  subtitleFontSize,()=>showDateFormatPopup(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, double fontSize) {
    return Text(
      title,
      style: AppTextStyles.bold(fontSize: fontSize, fontColor: AppStorages.appColor.value),
    );
  }

  Widget _buildListTile(String title, String subtitle, double titleFontSize, double subtitleFontSize,onTap) {
    return ListTile(
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



  void showLabelEditPopup(BuildContext context, String title,) {

    double titleFontSize = MediaQuery.of(context).size.width > 600 ? 25.0 : 18.0;
    double textFontSize = MediaQuery.of(context).size.width > 600 ? 22.0 : 16.0;
    double paddingSize = MediaQuery.of(context).size.width > 600 ? 30.0 : 20.0;

    Get.dialog(
      Dialog(
        backgroundColor: AppColors.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: EdgeInsets.all(paddingSize),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                title,
                style: AppTextStyles.bold(fontSize: titleFontSize, fontColor: AppStorages.appColor.value),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),

              // Input Field
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "",
                ),
              ),
              SizedBox(height: 20),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text("Cancel", style: AppTextStyles.regular(fontSize: textFontSize, fontColor: Colors.black)),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle save logic here
                      Get.back();
                    },
                    child: Text("OK", style: AppTextStyles.bold(fontSize: textFontSize, fontColor: AppStorages.appColor.value)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


void showDateFormatPopup(BuildContext context) {
   var selectedFormat = "".obs;
  double titleFontSize = MediaQuery.of(context).size.width > 600 ? 25.0 : 18.0;
  double textFontSize = MediaQuery.of(context).size.width > 600 ? 22.0 : 16.0;
  double paddingSize = MediaQuery.of(context).size.width > 600 ? 30.0 : 20.0;

  List<String> formats = [
    "Use company default",
    "MMM dd, yyyy",
    "dd/MM/yyyy",
    "dd/MMM/yyyy",
    "dd.MM.yyyy",
    "dd/MM/yy",
    "MM/dd/yy",
    "MM/dd/yyyy",
    "yyyy-MM-dd",
  ];

  Get.dialog(
    Dialog(
      backgroundColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.all(paddingSize),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              "Select a date format",
              style: AppTextStyles.bold(fontSize: titleFontSize, fontColor: AppStorages.appColor.value),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),

            // Date Format Options
            Obx(() => Column(
              children: formats.map((format) {
                return RadioListTile<String>(
                  title: Text(format, style: AppTextStyles.regular(fontSize: textFontSize, fontColor: Colors.black)),
                  value: format,
                  groupValue: selectedFormat.value,
                  onChanged: (value) {
                    if (value != null) {
                      selectedFormat.value = value;
                    }
                  },
                );
              }).toList(),
            )),

            // Cancel Button
            TextButton(
              onPressed: () => Get.back(),
              child: Text("Cancel", style: AppTextStyles.regular(fontSize: textFontSize, fontColor: Colors.black)),
            ),
          ],
        ),
      ),
    ),
  );
}