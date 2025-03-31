import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/resources/app_colors.dart';

class StatementsController extends GetxController {
  //TODO: Implement StatementsController
  final List<String> saleTypes = [
    "Invoices & Cash Sales",
    "Invoices only",
    "Cash Sales only"
  ];
  final RxString selectedSaleType = "Invoices & Cash Sales".obs;



  void showPopup(BuildContext context) {
    showDialog(
      context: context,

      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColor,
          title: Text("Select a sale type"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: saleTypes.map((type) {
              return Obx(() => RadioListTile<String>(
                title: Text(type),
                value: type,
                groupValue: selectedSaleType.value,
                onChanged: (value) {
                  selectedSaleType.value = value!;
                  Navigator.of(context).pop();
                },
                activeColor: Colors.blue,
              ));
            }).toList(),
          ),
        );
      },
    );
  }
}
