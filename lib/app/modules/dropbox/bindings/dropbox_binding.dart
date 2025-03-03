import 'package:get/get.dart';

import '../controllers/dropbox_controller.dart';

class DropboxBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DropboxController>(
      () => DropboxController(),
    );
  }
}
