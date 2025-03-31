import 'package:get/get.dart';

import '../controllers/purchase_orders_controller.dart';

class PurchaseOrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PurchaseOrdersController>(
      () => PurchaseOrdersController(),
    );
  }
}
