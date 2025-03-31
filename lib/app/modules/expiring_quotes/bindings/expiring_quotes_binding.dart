import 'package:get/get.dart';

import '../controllers/expiring_quotes_controller.dart';

class ExpiringQuotesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExpiringQuotesController>(
      () => ExpiringQuotesController(),
    );
  }
}
