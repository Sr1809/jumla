import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddPaymenntController extends GetxController {
  var paymentMethod = 'Cash'.obs;
  var dateText = ''.obs;

  TextEditingController amountController = TextEditingController(text: '0');
  TextEditingController memoController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    dateText.value = DateFormat('M/d/yy').format(DateTime.now());
  }

  void selectDate() async {
    DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      dateText.value = DateFormat('M/d/yy').format(picked);
    }
  }

  void savePayment() {
    String method = paymentMethod.value;
    String date = dateText.value;
    String amount = amountController.text.trim();
    String memo = memoController.text.trim();

    // You can add your saving logic here
    print("Saved Payment:");
    print("Method: $method, Date: $date, Amount: $amount, Memo: $memo");

    Get.back(); // Close the screen after saving
  }


  void selectPaymentMethod() {
    final methods = ['Cash', 'Check', 'Discover', 'Mastercard', 'PayPal', 'Visa'];
    String selected = paymentMethod.value;

    Get.defaultDialog(
      title: "Select a payment method",
      content: Column(
        children: methods.map((method) {
          return Obx(() => RadioListTile<String>(
            title: Text(method),
            value: method,
            groupValue: paymentMethod.value,
            onChanged: (value) {
              paymentMethod.value = value!;
              Get.back();
            },
          ));
        }).toList(),
      ),
    );
  }

}
