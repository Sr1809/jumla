import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSettingsController extends GetxController {
  var useScreenUnlock = false.obs;
  var discountBeforeTax = true.obs;
  var noDatesOnNotes = false.obs;
  var createNoteAfterEmailSms = true.obs;
  var showAvailableItemsOnly = false.obs;
  var showOnHandItemsOnly = false.obs;
  var noDeleteOfTransactions = false.obs;
  var useItemPictures = false.obs;




  TextEditingController companyNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController sloganController = TextEditingController();

  RxString selectedFilter = "Show all".obs;
  RxList<CustomField> customFields = <CustomField>[
    CustomField(name: "Drr", code: "CUSTC01", category: "COMPANY"),
  ].obs;



  /// **Text Controllers**
  TextEditingController nameController = TextEditingController();
  TextEditingController defaultValueController = TextEditingController();

  /// **Checkbox for "Apply To"**
  RxBool applyToCompany = true.obs;

  /// **Dropdown Selection for Input Type**
  RxString selectedInputType = "Text".obs;

  /// **Function to Save Custom Field**
  void saveCustomField() {
    if (nameController.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Name field cannot be empty!",
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    addNewField();
    Get.back();
    // **Success message**
    Get.snackbar(
      "Success",
      "Custom Field saved successfully!",
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );

    // **Close the screen**

  }

  void addNewField() {
    customFields.add(CustomField(
        name: nameController.text.trim(),
        code: "CUSTC01", category: selectedInputType.value));
  }


  var logoPath = "".obs;


  // **Controllers for Input Fields**
  TextEditingController businessIdController = TextEditingController();
  TextEditingController payNowTextController = TextEditingController();
  TextEditingController payNowButtonController = TextEditingController();

  // **Reactive Variables for Country & Currency**
  RxString selectedCountry = "Select Country".obs;
  RxString selectedCurrency = "Select Currency".obs;

  /// **Show Country Selection Popup**
  void showCountrySelection() {
    List<String> countries = ["USA", "UK", "Canada", "Australia", "Germany"];
    showSelectionPopup("Select Country", countries, (selected) {
      selectedCountry.value = selected;
    });
  }

  /// **Show Currency Selection Popup**
  void showCurrencySelection() {
    List<String> currencies = ["USD", "GBP", "CAD", "AUD", "EUR"];
    showSelectionPopup("Select Currency", currencies, (selected) {
      selectedCurrency.value = selected;
    });
  }

  /// **Reusable Function to Show Selection Popup**
  void showSelectionPopup(String title, List<String> options, Function(String) onSelected) {
    Get.dialog(
      AlertDialog(
        title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((option) {
            return ListTile(
              title: Text(option, style: TextStyle(fontSize: 16)),
              onTap: () {
                onSelected(option);
                Get.back();
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  /// **Save PayPal Settings**
  void savePayPalSettings() {
    Get.snackbar("Success", "PayPal settings saved successfully!");
  }

  var taxCodes = <TaxCode>[].obs;

  var terms = [
    {"title": "On invoices", "subtitle": "Default number of days for Due date", "days": 7},
    {"title": "On quotes", "subtitle": "Default number of days for Expiry date", "days": 7},
    {"title": "On sales orders", "subtitle": "Default number of days for Due date", "days": 7},
  ].obs;

  void updateDays(int index, int newDays) {
    terms[index]["days"] = newDays;
    terms.refresh();
  }

}

class CustomField {
  final String name;
  final String code;
  final String category;

  CustomField({required this.name, required this.code, required this.category});
}

class TaxCode {
  String name;
  double rate;
  TaxCode({required this.name, required this.rate});
}
