import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../tools/lists/views/item_fields_view.dart';


class NewProjectController extends GetxController {
  RxString customerName = "Anonymous Customer".obs;

  TextEditingController projectNameController = TextEditingController();
  TextEditingController projectDescController = TextEditingController();
  TextEditingController billAddressController = TextEditingController();
  TextEditingController shipAddressController = TextEditingController();
  TextEditingController contactNameController = TextEditingController();
  TextEditingController contactEmailController = TextEditingController();
  TextEditingController contactPhoneController = TextEditingController();

  RxString status = "None".obs;
  Rx<DateTime?> startDate = Rx<DateTime?>(null);
  Rx<DateTime?> endDate = Rx<DateTime?>(null);
  RxString startDateText = "Not Set".obs;
  RxString endDateText = "Not Set".obs;

  RxList<CompanyField> selectedItems = <CompanyField>[].obs;

  void selectStartDate() async {
    DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      startDate.value = picked;
      startDateText.value = "${picked.month}/${picked.day}/${picked.year}";
    }
  }

  void selectEndDate() async {
    DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      endDate.value = picked;
      endDateText.value = "${picked.month}/${picked.day}/${picked.year}";
    }
  }

  void clearStartDate() {
    startDate.value = null;
    startDateText.value = "Not Set";
  }

  void clearEndDate() {
    endDate.value = null;
    endDateText.value = "Not Set";
  }

  void selectStatus() {
    Get.defaultDialog(
      title: "Select Status",
      content: Column(
        children: [
          for (var s in ["None", "Active", "Completed", "Hold", "Cancelled"])
            ListTile(
              title: Text(s),
              onTap: () {
                status.value = s;
                Get.back();
              },
            ),
        ],
      ),
    );
  }

  void editCustomFields() {
    // Dummy example
    // customFields.assignAll([
    //   CustomField(name: "Priority".obs, code: "High".obs),
    //   CustomField(name: "Manager".obs, code: "Amit".obs),
    // ]);
  }

  void saveProject() {
    // Logic to save the project or send it to backend
   Get.back(result: projectNameController.text);
  }
}
