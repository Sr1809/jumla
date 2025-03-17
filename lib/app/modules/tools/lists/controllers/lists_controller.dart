import 'package:get/get.dart';

class ListsController extends GetxController {
  var basicLists = ["Customers", "Items"].obs;
  var otherLists = [
    "Tax Codes",
    "Terms",
    "Payment Methods",
    "Price Levels",
    "Item Categories",
    "Transaction statuses"
  ].obs;
  var customFields = [
    "Customer Fields",
    "Item Fields",
    "Transaction Body Fields",
    "Transaction Line Fields",
    "Project Fields",
    "Company Fields"
  ].obs;
  var templates = ["Print Templates", "Email Templates", "SMS Templates"].obs;
}
