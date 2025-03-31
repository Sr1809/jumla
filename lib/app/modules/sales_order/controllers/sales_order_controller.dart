import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../routes/app_pages.dart';
import '../../estimate/model/estimate_model.dart';
import '../../estimate/views/estimate_detail_view.dart';
import '../../items/model/item_model.dart';
import '../../tools/lists/views/company_fields_view.dart';
import '../views/sales_order_detail_view.dart';

class SalesOrderController extends GetxController {
  RxString selectedCustomer = 'Anonymous Customer'.obs;
  RxString project = 'Not Set'.obs;
  RxString status = 'Proposal'.obs;

  Rx<DateTime> estimateDate = DateTime.now().obs;
  Rx<DateTime> expiryDate = DateTime.now().obs;
  RxString date = ''.obs;
  RxString expiryDateText = ''.obs;
  RxString expiryLabel = 'Same day'.obs;

  TextEditingController memoController = TextEditingController();
  TextEditingController billAddressController = TextEditingController();
  TextEditingController shipAddressController = TextEditingController();

  RxList<CompanyField> customFields = <CompanyField>[].obs;

  Rx<Estimate?> selectedEstimate = Rx<Estimate?>(null);
  RxList<Estimate> estimates = <Estimate>[].obs;

  @override
  void onInit() {
    super.onInit();
    _updateDateStrings();
    _loadDummyData();

  }

  void _updateDateStrings() {
    final formatter = DateFormat('M/d/yy');
    date.value = formatter.format(estimateDate.value);

    expiryDateText.value = formatter.format(expiryDate.value);
    expiryLabel.value = estimateDate.value == expiryDate.value ? 'Same day' : '';
  }

  void selectCustomer() {
    // TODO: Implement customer selector
  }

  void selectProject() {

    List<String> projects = ['Vuugg', 'Project A', 'Project B'];

    Get.defaultDialog(
      title: "Select one",
      titleStyle: TextStyle(color: Colors.cyan[800], fontSize: 18.0),
      content: Column(
        children: [
          ...projects.map((projects) => Obx(() => RadioListTile<String>(
            title: Text(projects),
            value: projects,
            groupValue: project.value,
            onChanged: (value) {
              project.value = value!;
              Get.back();
            },
          ))),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(onPressed: () => Get.back(), child: Text("Cancel")),
              TextButton(
                onPressed: () {
                  project.value = "Not Set";
                  Get.back();
                },
                child: Text("Not Set"),
              ),
              TextButton(
                onPressed: () {
                  Get.back();
                  Get.toNamed(Routes.NEW_PROJECT)!.then((v){
                    if(v != null){
                      if(v.toString().isNotEmpty){
                        project.value = v;}
                    }
                  });
                },
                child: Text("Add new"),
              ),
            ],
          )
        ],
      ),
    );




  }

  void _setProject(String value) {
    project.value = value;
    Get.back();
  }

  void selectStatus() {
    Get.dialog(SimpleDialog(
      title: Text("Select Status"),
      children: [
        ListTile(title: Text("Proposal"), onTap: () => _setStatus("Proposal")),
        ListTile(title: Text("Confirmed"), onTap: () => _setStatus("Confirmed")),
        ListTile(title: Text("In Progress"), onTap: () => _setStatus("In Progress")),
        ListTile(title: Text("Completed"), onTap: () => _setStatus("Completed")),
      ],
    ));
  }

  void _setStatus(String value) {
    status.value = value;
    Get.back();
  }

  void selectDate() async {
    final picked = await showDatePicker(
      context: Get.context!,
      initialDate: estimateDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      estimateDate.value = picked;
      if (expiryDate.value.isBefore(picked)) {
        expiryDate.value = picked;
      }
      _updateDateStrings();
    }
  }

  void selectExpiryDate() async {
    final picked = await showDatePicker(
      context: Get.context!,
      initialDate: expiryDate.value,
      firstDate: estimateDate.value,
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      expiryDate.value = picked;
      _updateDateStrings();
    }
  }

  void selectBillAddress() {
    // TODO: Replace with real implementation
    billAddressController.text = "Billing Address...";
  }

  void selectShipAddress() {
    // TODO: Replace with real implementation
    shipAddressController.text = "Shipping Address...";
  }

  void editCustomFields() {
    // TODO: Navigate to custom field selector
  }

  void saveEstimate() {
    // final newEstimate = Estimate(
    //   id: selectedEstimate.value!.id,
    //   customer: selectedCustomer.value,
    //   project: project.value,
    //   status: status.value,
    //   date: estimateDate.value,
    //   expiryDate: expiryDate.value,
    //   memo: memoController.text,
    //   billAddress: billAddressController.text,
    //   shipAddress: shipAddressController.text,
    //   customFields: List<CompanyField>.from(customFields),
    // );
    //
    // if (selectedEstimate.value == null) {
    //   estimates.add(newEstimate);
    // } else {
    //   final index = estimates.indexWhere((e) => e.id == newEstimate.id);
    //   if (index != -1) {
    //     estimates[index] = newEstimate;
    //   }
    // }
    //
    // clearForm();
    Get.to(()=>SalesOrderDetailView());
  }

  void clearForm() {
    selectedCustomer.value = '';
    project.value = 'Not Set';
    status.value = 'Proposal';
    estimateDate.value = DateTime.now();
    expiryDate.value = DateTime.now();
    memoController.clear();
    billAddressController.clear();
    shipAddressController.clear();
    customFields.clear();
    selectedEstimate.value = null;
    _updateDateStrings();
  }



  void showProjectPopup(BuildContext context, RxString selectedProject) {
    List<String> projects = ['Vuugg', 'Project A', 'Project B']; // replace with dynamic list if needed

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text("Select one", style: TextStyle(color: Colors.cyan[800], fontSize: 18.0)),
          children: [
            ...projects.map((project) => RadioListTile<String>(
              title: Text(project),
              value: project,
              groupValue: selectedProject.value,
              onChanged: (value) {
                selectedProject.value = value!;
                Navigator.pop(context);
              },
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
                TextButton(
                    onPressed: () {
                      selectedProject.value = "Not Set";
                      Navigator.pop(context);
                    },
                    child: Text("Not Set")),
                TextButton(
                    onPressed: () {
                      // Trigger "Add New" logic
                      Navigator.pop(context);
                      // e.g., show input dialog to add new project
                    },
                    child: Text("Add new")),
              ],
            )
          ],
        );
      },
    );
  }



  var items = <Item>[].obs;
  var selectedItem = Rxn<Item>();
  final searchController = TextEditingController();
  var isSearching = false.obs;
  var usePictures = false.obs;
  var searchQuery = ''.obs;
  var itsFrom = false.obs;



  void _loadDummyData() {
    items.addAll([
      Item(name: "Anonymous Customer", category: "ESTIMATE#012-Closed Won", description: "80 minute 700 MB CD-R", price: 25.00,type: "3/27/25",priceUnit: "1",cost: 2.0,isTaxable: true,tax: ""),
      Item(name: "Anonymous Customer", category: "ESTIMATE#012-Closed Won", description: "18 inch IDE hard drive connector cable", price: 8.50,type: "3/27/25",priceUnit: "1",cost: 2.0,isTaxable: true,tax: ""),
      Item(name: "Anonymous Customer", category: "ESTIMATE#012-Closed Won", description: "4.7 GB DVD-R", price: 20.00,type: "3/27/25",priceUnit: "1",cost: 2.0,isTaxable: true,tax: ""),
      Item(name: "Anonymous Customer", category: "ESTIMATE#012-Closed Won", description: "In-store hardware repair and/or service.", price: 50.00,type: "3/27/25",priceUnit: "1",cost: 2.0,isTaxable: true,tax: ""),
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
