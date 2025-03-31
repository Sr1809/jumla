import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../items/model/item_model.dart';
import '../model/customer_model.dart';

class CustomersListController extends GetxController {
  final searchController = TextEditingController();
  var isSearching = false.obs;
  var searchQuery = ''.obs;
  var selectedItem = Rxn<Customer>();
  var customer = <Customer>[].obs;
  RxList<ItemNote> itemNote = <ItemNote>[].obs;
var isFrom  = false.obs;

  @override
  void onInit() {
    super.onInit();
    if(Get.arguments != null)
    {
      isFrom.value = true;
    }
    _loadDummyData();
  }

  void _loadDummyData() {
    customer.addAll([
      Customer(name: "Anonymous Customer"),
       ]);
  }
  void deleteItem(Customer item) {
    customer.remove(item);
  }

  void addOrUpdateCustomer(Customer customers) {
    final index = customer.indexWhere((c) => c.id == customers.id);
    if (index != -1) {
      // Update existing
      customer[index] = customers;
    } else {
      // Add new
      customer.add(customers);
    }
    customer.refresh(); // Notify observers
  }


  var sales = <Map<String, String>>[
    {"date": "3/25/25", "title": "SALESORDER#004", "status": "Pending Billing", "total": "0.00"},
    {"date": "3/25/25", "title": "CASHSALE#005", "status": "Fully Paid", "total": "0.00"},
    {"date": "3/25/25", "title": "INVOICE#001", "status": "Fully Paid", "total": "0.00"},
  ].obs;

  var projects = <Map<String, String>>[
    {"title": "Egegge", "start": "Not Set"},
    {"title": "Vuugg", "start": "Not Set"},
  ].obs;

  var payments = <Map<String, String>>[
    {"date": "3/25/25", "method": "Cash", "ref": "CASHSALE#006", "amount": "0.00"},
    {"date": "3/25/25", "method": "Cash", "ref": "CASHSALE#006", "amount": "0.00"},
  ].obs;

  var notes = <String>[].obs;
}
