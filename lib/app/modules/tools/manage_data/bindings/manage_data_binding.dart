import 'package:get/get.dart';

import '../controllers/manage_data_controller.dart';

class ManageDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageDataController>(
      () => ManageDataController(),
    );
  }
}
