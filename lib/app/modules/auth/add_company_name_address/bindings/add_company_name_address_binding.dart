import 'package:get/get.dart';

import '../controllers/add_company_name_address_controller.dart';

class AddCompanyNameAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCompanyNameAddressController>(
      () => AddCompanyNameAddressController(),
    );
  }
}
