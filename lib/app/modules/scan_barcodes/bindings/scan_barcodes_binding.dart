import 'package:get/get.dart';

import '../controllers/scan_barcodes_controller.dart';

class ScanBarcodesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScanBarcodesController>(
      () => ScanBarcodesController(),
    );
  }
}
