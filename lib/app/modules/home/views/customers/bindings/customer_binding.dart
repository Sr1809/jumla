import 'package:get/get.dart';
import 'package:jumla/app/modules/home/views/customers/controllers/customer_controller.dart';

class CustomersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerController>(
      () => CustomerController(),
    );
  }
}
