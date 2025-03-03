import 'package:get/get.dart';
import 'package:jumla/app/modules/home/views/customers/controllers/customer_detail_controller.dart';

class CustomersDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomerDetailController>(
      () => CustomerDetailController(),
    );
  }
}
