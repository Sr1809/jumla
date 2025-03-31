import 'package:get/get.dart';

class ExpiringQuotesController extends GetxController {
  /// Date range displayed in the AppBar (observable).
  final dateRange = "3/24/25 - 3/30/25".obs;
var title = Get.arguments;
  /// List of quotes (observable).
  final quotes = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadQuotes();
  }

  /// Simulate fetching or loading quotes.
  void loadQuotes() {
    quotes.value = [
      {
        "customer": "Anonymous Customer",
        "estimateNo": "ESTIMATE#009",
        "amount": 0.00,
        "daysAgo": "5 days ago",
      },
      {
        "customer": "Anonymous Customer",
        "estimateNo": "ESTIMATE#008",
        "amount": 0.00,
        "daysAgo": "5 days ago",
      },
      {
        "customer": "Anonymous Customer",
        "estimateNo": "ESTIMATE#007",
        "amount": 0.00,
        "daysAgo": "5 days ago",
      },
    ];
  }
}
