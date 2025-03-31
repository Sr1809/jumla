import 'package:get/get.dart';

import '../controllers/estimate_controller.dart';

class EstimateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EstimateController>(
      () => EstimateController(),
    );
  }
}
