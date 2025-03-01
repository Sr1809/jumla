import 'package:get/get.dart';

import '../controllers/company_info_note_controller.dart';

class CompanyInfoNoteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyInfoNoteController>(
      () => CompanyInfoNoteController(),
    );
  }
}
