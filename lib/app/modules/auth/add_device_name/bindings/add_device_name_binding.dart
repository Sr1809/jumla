import 'package:get/get.dart';

import '../controllers/add_device_name_controller.dart';

class AddDeviceNameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddDeviceNameController>(
      () => AddDeviceNameController(),
    );
  }
}
