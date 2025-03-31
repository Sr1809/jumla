import 'package:get/get.dart';

import '../controllers/statements_controller.dart';

class StatementsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatementsController>(
      () => StatementsController(),
    );
  }
}
