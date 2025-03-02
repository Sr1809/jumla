import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCurrencyDateFormatsController extends GetxController {
  var localeController  = "United States EN".obs;
  var dateFormatController = "Short date".obs;
  var currencyFormatController = TextEditingController(text: "");
  var currencySymbolController = TextEditingController();
}
