import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDeviceNameController extends GetxController {
  var deviceNameController = TextEditingController(text: "");
  var isAppendDeviceName = false.obs;
}
