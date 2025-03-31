import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/core/app_storage.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

import '../../../common/common_appbar.dart';
import '../../../common/common_text_field.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_styles.dart';
import '../../tools/lists/views/item_categories_view.dart';
import '../../tools/lists/views/item_fields_view.dart';
import '../../tools/lists/views/tac_codes_view.dart';
import '../controllers/items_controller.dart';
import '../model/item_model.dart';

class AddOrEditItemScreen extends StatelessWidget {
  final ItemsController controller = Get.put(ItemsController());
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final priceUnitController = TextEditingController();
  final costController = TextEditingController();
  final barcodeController = TextEditingController();
  RxString category = "Uncategorized".obs;
  RxString tax = "".obs;
  final priceController = TextEditingController();
  final RxString selectedType = "Non-inventory Item".obs;
  final RxBool isTaxable = true.obs;
  final selectedItems = <CompanyField>[].obs;

  @override
  Widget build(BuildContext context) {
    final item = controller.selectedItem.value;
    if (item != null) {
      nameController.text = item.name.value;
      descController.text = item.description.value;
      category.value = item.category.value;
      priceController.text = item.price.value.toString();
      selectedType.value = item.type.value;
      priceUnitController.text = item.priceUnit.value;
      costController.text = item.cost.value.toString();
      isTaxable.value = item.isTaxable.value;
      tax.value = item.tax.value;
    }

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Add Item",
        hideLogo: true,
        showBackButton: true,
        actions: [
          if (item != null)
            IconButton(
              icon: Icon(Icons.delete, color: AppColors.whiteColor),
              onPressed: () {
                controller.deleteItem(item);
                Get.back();
              },
            ),
          IconButton(
            icon: Icon(Icons.save, color: AppColors.whiteColor),
            onPressed: () {
              final newItem = Item(
                  id: item?.id,
                  name: nameController.text,
                  category: category.value,
                  description: descController.text,
                  price: double.tryParse(priceController.text) ?? 0.0,
                  isTaxable: isTaxable.value,
                  tax: tax.value,
                  type: selectedType.value,priceUnit: priceUnitController.text,cost: double.tryParse( costController.text)??0.0);
              controller.addOrUpdateItem(newItem);
              Get.back();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CommonTextFieldWithTitle(label: "Name", controller: nameController),
            CommonTextFieldWithTitle(
                label: "Sales description", controller: descController),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Choose a type of item",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold)),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...[
                          "Non-inventory Item",
                          "Inventory Item",
                          "Service Item",
                          "Shipping Item",
                          "Description Item",
                        ].map((type) => ListTile(
                              title: Text(type),
                              onTap: () {
                                selectedType.value = type;
                                Navigator.pop(context);
                              },
                            )),
                      ],
                    ),
                  ),
                );
              },
              child: AbsorbPointer(
                child: Obx(() => CommonTextFieldWithTitle(
                      label: "Type",
                      controller:
                          TextEditingController(text: selectedType.value),
                    )),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                        onTap: () {
                          Get.to(() => ItemCategoryListView("options"))!
                              .then((v) {
                            if (v != null) {
                              category.value = v;
                            }
                          });
                        },
                        child: Obx(() => AbsorbPointer(
                            child: CommonTextFieldWithTitle(
                                label: "Category",
                                controller: TextEditingController(
                                    text: category.value)))))),
                SizedBox(width: 8),
                Text("Active:"),
                Checkbox(value: true, onChanged: (_) {})
              ],
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppStorages.appColor.value,

              ),
              child: Text("Financial Setup",
                  style: AppTextStyles.bold(
                      fontColor: AppColors.whiteColor, fontSize: 16.0)),
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                    child: CommonTextFieldWithTitle(
                        label: "Sales Price", controller: priceController,hint: "0.0",)),

                Expanded(
                  flex: 2,
                    child: CommonTextFieldWithTitle(
                        label: "Price Unit",
                        controller: priceUnitController,hint: "eg. pcs",)),

                Expanded(
                  flex: 2,
                    child: CommonTextFieldWithTitle(
                        label: "Cost",
                        hint: "0.0",
                        controller: costController)),
              ],
            ),
            Row(
              children: [
                Text("Taxable?"),
                SizedBox(width: 8),
                Obx(() => ElevatedButton(
                  onPressed: () {
                    isTaxable.value = !isTaxable.value; // Toggle between Yes/No
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isTaxable.value ? AppStorages.appColor.value : Colors.grey[300],
                  ),
                  child: Text(
                    isTaxable.value ? "Yes" : "No",
                    style: TextStyle(color: isTaxable.value ? Colors.white : Colors.black),
                  ),
                ))
,
                SizedBox(width: 16),
                Expanded(
                    child: GestureDetector(
                      onTap: (){
                        Get.to(() => TaxCodeListView("item"))!.then((v){
                          if(v != null){
                            tax.value = v;
                          }
                        });
                      },
                      child: AbsorbPointer(
                        child:Obx(()=> CommonTextFieldWithTitle(
                            label: "Tax (optional)",
                            controller: TextEditingController(text: tax.value))),
                      ),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                "If set, it overrides the default company tax",
                style: AppTextStyles.regular(
                    fontColor: Colors.green, fontSize: 12.0),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppStorages.appColor.value,

              ),
              child: Text("Inventory",
                  style: AppTextStyles.bold(
                      fontColor: AppColors.whiteColor, fontSize: 16.0)),
            ),
            SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: CommonTextFieldWithTitle(label: "Barcode", controller: barcodeController, hint: "eg. 12345678")),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                    onPressed: () async {
                      String? res = await SimpleBarcodeScanner.scanBarcode(
                        context,
                        barcodeAppBar: const BarcodeAppBar(
                          appBarTitle: 'Test',
                          centerTitle: false,
                          enableBackButton: true,
                          backButtonIcon: Icon(Icons.arrow_back_ios),
                        ),
                        isShowFlashIcon: true,
                        delayMillis: 2000,
                        cameraFace: CameraFace.back,
                      );
                    },
                    child: Icon(Icons.qr_code),

                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(12.0),
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Stock Qty:"), SizedBox(height: 4), Text("10")])),
                  SizedBox(width: 16),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Available Qty:"), SizedBox(height: 4), Text("10")])),
                ],
              ),
            ),
            Text("To adjust inventory, go back to view mode > Adjust Inventory", style: TextStyle(color: Colors.green, fontSize: 12.0)),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppStorages.appColor.value,

              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("CUSTOM FIELDS",
                      style: AppTextStyles.bold(
                          fontColor: AppColors.whiteColor, fontSize: 16.0)),
                   GestureDetector(
                     onTap: (){
                       Get.to(()=>ItemFieldListView("item"))!.then((v){
                         if(v != null){
                           selectedItems.value = v;
                         }
                       });
                     },
                     child: Container(
                       padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
                         color: Colors.white,
                         child: Text("Add / Edit")),
                   )
                ],
              ),
            ),
            Obx(() => ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(10),
              shrinkWrap: true,
              itemCount: selectedItems.length,
              itemBuilder: (context, index) {
                var field = selectedItems[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 1,
                  child: Obx(() => ListTile(
                    dense: true,
                    tileColor: AppStorages.appColor.value.withOpacity(0.1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    title: Text(
                      field.name.value,
                      style: AppTextStyles.bold(fontSize: 16.0, fontColor:!field.isActive.value?Colors.red: AppColors.blackColor),
                    ),
                    subtitle: Text(
                      field.code.value,
                      style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.darkGrey),
                    ),
                  )),
                );
              },
            )),

          ],
        ),
      ),
    );
  }
}
