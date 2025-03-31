import 'package:get/get.dart';

import '../../tools/lists/views/company_fields_view.dart';

class Estimate {
  final String id;
  RxString customerName;
  RxString project;
  RxString status;
  Rx<DateTime> date;
  Rx<DateTime> expiryDate;
  RxString memo;
  RxString billAddress;
  RxString shipAddress;
  RxList<CompanyField> customFields;

  Estimate({
    String? id,
    required String customer,
    String project = 'Not Set',
    String status = 'Proposal',
    DateTime? date,
    DateTime? expiryDate,
    String memo = '',
    String billAddress = '',
    String shipAddress = '',
    List<CompanyField>? customFields,
  })  : id = id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        customerName = customer.obs,
        project = project.obs,
        status = status.obs,
        date = (date ?? DateTime.now()).obs,
        expiryDate = (expiryDate ?? DateTime.now()).obs,
        memo = memo.obs,
        billAddress = billAddress.obs,
        shipAddress = shipAddress.obs,
        customFields = (customFields ?? []).obs;
}
