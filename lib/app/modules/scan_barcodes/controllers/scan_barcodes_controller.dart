import 'package:get/get.dart';

class ScanBarcodesController extends GetxController {
  final RxBool useBarcodes = true.obs;
  final RxString selectedSaleType = "Invoice".obs;
  final RxString selectedCustomer = "Anonymous Customer".obs;

  final List<String> saleTypes = ['Cash Sale', 'Invoice', 'Sales Order', 'Quote'];
  final List<String> customers = ['Anonymous Customer', 'John Doe', 'Company X'];
}
