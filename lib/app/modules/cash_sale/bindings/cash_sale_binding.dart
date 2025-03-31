import 'package:get/get.dart';

import '../controllers/cash_sale_controller.dart';

class CashSaleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CashSaleController>(
      () => CashSaleController(),
    );
  }
}
