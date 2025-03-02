import 'package:get/get.dart';

import '../controllers/add_currency_date_formats_controller.dart';

class AddCurrencyDateFormatsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCurrencyDateFormatsController>(
      () => AddCurrencyDateFormatsController(),
    );
  }
}
