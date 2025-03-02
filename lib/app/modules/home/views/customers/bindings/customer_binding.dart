import 'package:get/get.dart';
import 'package:jumla/app/modules/home/controllers/home_controller.dart';

class CustomersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
