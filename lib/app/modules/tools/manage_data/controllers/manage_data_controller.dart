import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ManageDataController extends GetxController {
  var saveToSdCard = true.obs;
  var saveToDropbox = false.obs;
  var sendToEmail = false.obs;

  TextEditingController optionalController = TextEditingController();
}
