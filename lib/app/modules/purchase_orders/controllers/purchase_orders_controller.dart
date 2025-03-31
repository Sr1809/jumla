import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../items/model/item_model.dart';

class PurchaseOrdersController extends GetxController {
  var items = <Item>[].obs;
  var selectedItem = Rxn<Item>();
  final searchController = TextEditingController();
  var isSearching = false.obs;
  var usePictures = false.obs;
  var searchQuery = ''.obs;
  var itsFrom = false.obs;

  @override
  void onInit() {
    if(Get.arguments != null){
      itsFrom.value = true;
    }
    super.onInit();
    _loadDummyData();
  }

  void _loadDummyData() {
    items.addAll([
      Item(name: "Anonymous Customer", category: "INVOICE#004 - Full Paid", description: "80 minute 700 MB CD-R", price: 25.00,type: "3/27/25",priceUnit: "1",cost: 2.0,isTaxable: true,tax: ""),
      Item(name: "Anonymous Customer", category: "INVOICE#004 - Full Paid", description: "18 inch IDE hard drive connector cable", price: 8.50,type: "3/27/25",priceUnit: "1",cost: 2.0,isTaxable: true,tax: ""),
      Item(name: "Anonymous Customer", category: "INVOICE#004 - Full Paid", description: "4.7 GB DVD-R", price: 20.00,type: "3/27/25",priceUnit: "1",cost: 2.0,isTaxable: true,tax: ""),
      Item(name: "Anonymous Customer", category: "INVOICE#004 - Full Paid", description: "In-store hardware repair and/or service.", price: 50.00,type: "3/27/25",priceUnit: "1",cost: 2.0,isTaxable: true,tax: ""),
    ]);
  }

  void addOrUpdateItem(Item item) {
    int index = items.indexWhere((i) => i.id == item.id);
    if (index != -1) {
      items[index] = item;
    } else {
      items.add(item);
    }
  }

  void deleteItem(Item item) {
    items.remove(item);
  }
}
