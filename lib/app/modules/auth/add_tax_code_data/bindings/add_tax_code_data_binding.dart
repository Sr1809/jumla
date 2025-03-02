import 'package:get/get.dart';

import '../controllers/add_tax_code_data_controller.dart';

class AddTaxCodeDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTaxCodeDataController>(
      () => AddTaxCodeDataController(),
    );
  }
}
