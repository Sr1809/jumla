import 'package:get/get.dart';

import '../controllers/add_paymennt_controller.dart';

class AddPaymenntBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPaymenntController>(
      () => AddPaymenntController(),
    );
  }
}
