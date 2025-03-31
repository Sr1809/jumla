import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/modules/items/views/add_note_view.dart';
import '../../../common/common_appbar.dart';
import '../../../core/app_storage.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_styles.dart';
import '../controllers/items_controller.dart';
import '../model/item_model.dart';
import 'add_or_edit_item_view.dart';

class ItemDetailScreen extends StatelessWidget {
  RxList<ItemNote> itemNote = <ItemNote>[].obs;

   ItemDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: CommonAppBarWithTitleAndIcon(
          title: "Item",
          showBackButton: true,
          hideLogo: true,
          actions: [
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'adjust':
                  // Handle Adjust inventory logic
                    break;
                  case 'edit':
                 Get.to(()=>AddOrEditItemScreen());
                    break;
                  case 'copy':
                  // Handle Copy item logic
                    break;
                  case 'delete':
                  // Handle Delete item logic
                    Get.defaultDialog(
                      title: "Delete Item?",
                      middleText: "Are you sure you want to delete this item?",
                      confirm: ElevatedButton(
                        onPressed: () {
                          // delete logic
                          Get.back(); // Close dialog
                          Get.back(); // Go back after delete
                        },
                        child: Text("Yes"),
                      ),
                      cancel: TextButton(onPressed: () => Get.back(), child: Text("No")),
                    );
                    break;
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(value: 'adjust', child: Text("Adjust inventory")),
                PopupMenuItem(value: 'edit', child: Text("Edit item")),
                PopupMenuItem(value: 'copy', child: Text("Copy item")),
                PopupMenuItem(value: 'delete', child: Text("Delete item")),
              ],

              icon: Icon(Icons.edit,color: AppColors.whiteColor,),
            ),
          ],
        ),

        body: Column(
          children: [
            Container(
              color: Colors.grey.shade200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("CD-R", style: AppTextStyles.bold(fontSize: 20.0, fontColor: AppColors.blackColor)),
                        Text("Inventory Item", style: AppTextStyles.regular(fontSize: 16.0, fontColor: Colors.grey)),
                      ],
                    ),
                  ),
                  Container(
                    color: AppStorages.appColor.value,
                    height: 45,
                    child: TabBar(
                      labelColor: AppColors.blackColor,
                      unselectedLabelColor: Colors.white,
                      labelStyle: AppTextStyles.bold(fontSize: 13.0, fontColor: AppColors.blackColor),
                      unselectedLabelStyle: AppTextStyles.regular(fontSize: 13.0, fontColor: AppColors.whiteColor),
                      indicator: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      isScrollable: true,
                      padding: EdgeInsets.only(top: 4,bottom: 4,),
                      tabs:  [
                        Tab(child: Container(padding: EdgeInsets.only(left: 20,right: 20,top: 4,bottom: 4), child: Center(child: Text("Info")))),
                        Tab(child: SizedBox(width: 100, child: Center(child: Text("Pricing")))),
                        Tab(child: SizedBox(width: 100, child: Center(child: Text("Sold")))),
                        Tab(child: SizedBox(width: 100, child: Center(child: Text("Purchased")))),
                        Tab(child: SizedBox(width: 100, child: Center(child: Text("Notes")))),
                      ],
                    ),
                  )


                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _infoTab(),
                  _pricingTab(),
                  _soldTab(),
                  _purchasedTab(),
                  _notesTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTab() {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        _infoRow("Category", "Uncategorized"),
        _infoRow("Sales description", "80 minute 700 MB CD-R"),
        _infoRow("Sales Price", "\$25.00"),
        _infoRow("Price Unit", "pc"),
        _infoRow("Cost", "\$0.00"),
        _infoRow("Taxable", "No"),
        _infoRow("Tax", "None"),
        _infoRow("Barcode", ""),
        _infoRow("Stock Qty", "26.0"),
        _infoRow("Available Qty", "26.0"),
        _infoRow("Frff", "No"),
        _infoRow("Is Inactive", "No"),
        _infoRow("Created by", "Test Test 3/1/25"),
        _infoRow("Updated by", "Test Test 3/22/25"),
        _infoRow("MobileBiz Id", "2"),
        _infoRow("External Id", ""),
      ],
    );
  }

  Widget _pricingTab() {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        _tableHeader(["Price Level", "Discount", "Item Price"]),
        _tableRow(["Base Price", "0 %", "25"]),
      ],
    );
  }

  Widget _soldTab() {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        _tableHeader(["Sale", "Quantity", "Tax", "Sold", "Cost", "Profit"]),
        _emptyRow(),
      ],
    );
  }

  Widget _purchasedTab() {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        _tableHeader(["Purchase", "Quantity", "Tax", "Amount"]),
        _emptyRow(),
      ],
    );
  }

  Widget _notesTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(onPressed: () {
                Get.to(()=>AddNoteScreen())!.then((v){
                  if(v!= null){
                  itemNote.add(v);}
                });
              }, child: Text("Add note")),
              SizedBox(width: 10),
              ElevatedButton(onPressed: () {
                itemNote.clear();
              }, child: Text("Clear")),
            ],
          ),
        ),
       Obx(()=> itemNote.isNotEmpty ? ListView.builder(
           shrinkWrap: true,
padding: EdgeInsets.all(20),
           itemBuilder: (context,index){
             return Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 Text(itemNote[index].note,style: AppTextStyles.regular(fontSize: 15.0, fontColor: AppColors.blackColor),),
                 Container(
                     decoration: BoxDecoration(
                       color: AppStorages.appColor.value
                     ),
                     padding: EdgeInsets.only(left: 5,right: 5,top: 3,bottom: 3),
                     child: Text("${itemNote[index].date.month}/${itemNote[index].date.day}//${itemNote[index].date.year}",style: AppTextStyles.regular(fontSize: 12.0, fontColor: AppColors.whiteColor),)),

               ],
             );
           },itemCount: itemNote.length):
        Center(child: Text("Notes"))),
      ],
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: Text("$label:", style: AppTextStyles.bold(fontSize: 13.0,fontColor: AppColors.blackColor))),
          Expanded(flex: 5, child: Text(value)),
        ],
      ),
    );
  }

  Widget _tableHeader(List<String> headers) {
    return Row(
      children: headers.map((h) => Expanded(child: Text(h, style: AppTextStyles.bold(fontSize: 13.0,fontColor: AppColors.blackColor)))).toList(),
    );
  }

  Widget _tableRow(List<String> values) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: values.map((v) => Expanded(child: Text(v))).toList(),
      ),
    );
  }

  Widget _emptyRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Center(child: Text("No records found")),
    );
  }
}
