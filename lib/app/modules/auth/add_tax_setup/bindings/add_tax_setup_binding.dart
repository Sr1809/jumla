import 'package:get/get.dart';

import '../controllers/add_tax_setup_controller.dart';

class AddTaxSetupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTaxSetupController>(
      () => AddTaxSetupController(),
    );
  }
}
