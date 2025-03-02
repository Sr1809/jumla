import 'package:get/get.dart';

class AddTaxSetupController extends GetxController {
  var selectedTaxType = "One tax".obs;
  var selectedTaxCode = "Tax 5%".obs;
  var isTaxInclusive = false.obs;
  RxList<String> taxCodes = ["Tax 5%"].obs;
}
