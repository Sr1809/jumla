import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/common_appbar.dart';
import '../../../common/common_button.dart';
import '../../../core/app_storage.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_styles.dart';
import '../../../routes/app_pages.dart';
import '../../items/model/item_model.dart';
import '../../items/views/add_note_view.dart';

class CashSaleDetailView extends StatelessWidget {
   CashSaleDetailView({super.key});


  final RxList<Map<String, dynamic>> items = <Map<String, dynamic>>[
    {
      "qty": 1,
      "title": "Cable - IDE",
      "description": "18 inch IDE hard drive connector cable",
      "amount": 8.50,
    }
  ].obs;
   final RxList<Map<String, String>> payments = <Map<String, String>>[
     {"date": "3/25/25", "method": "Cash", "amount": "0.00"},
     {"date": "3/25/25", "method": "Cash", "amount": "0.00"},
   ].obs;

   RxList<ItemNote> itemNote = <ItemNote>[].obs;


  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: CommonAppBarWithTitleAndIcon(
          title: "CASHSALE#____",
          showBackButton: true,
          hideLogo: true,
          actions: [
            PopupMenuButton<String>(
              icon: Icon(Icons.edit, color: Colors.white),
              onSelected: (value) {

              },
              color: AppColors.whiteColor,
              itemBuilder: (context) => [
                PopupMenuItem(value: 'edit_customer', child: Text("Customer, dates, status, etc")),
                PopupMenuItem(value: 'change_status', child: Text("Change status")),
                PopupMenuItem(value: 'convert_sales_order', child: Text("Convert to sales order")),
                PopupMenuItem(value: 'convert_invoice', child: Text("Convert to invoice")),
                PopupMenuItem(value: 'convert_cash_sale', child: Text("Convert to cash sale")),
                PopupMenuItem(value: 'apply_discount', child: Text("Apply discount")),
                PopupMenuItem(value: 'apply_tax', child: Text("Apply tax")),
                PopupMenuItem(value: 'signature', child: Text("Signature")),
                PopupMenuItem(value: 'mark_processed', child: Text("Mark as processed")),
                PopupMenuItem(value: 'copy_quote', child: Text("Copy quote")),
                PopupMenuItem(value: 'make_recurring', child: Text("Make this quote recurring")),
                PopupMenuItem(value: 'delete_quote', child: Text("Delete quote")),
                PopupMenuItem(value: 'custom_fields', child: Text("Custom fields")),
              ],
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.share,color: AppColors.whiteColor,)),
            IconButton(onPressed: () {}, icon: Icon(Icons.refresh, color: Colors.red)),
            PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, color: Colors.white),
              onSelected: (value) {

              },
              color: AppColors.whiteColor,
              itemBuilder: (context) => [
                PopupMenuItem(value: 'edit_customer', child: Text("Go to customer")),
                PopupMenuItem(value: 'change_status', child: Text("Go to project")),
                PopupMenuItem(value: 'convert_sales_order', child: Text("Show item buttons")),
                PopupMenuItem(value: 'convert_sales_order', child: Text("Bac k to transactions list")),

              ],
            ),
          ],
        ),
        body: Column(
          children: [
            Container(

              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Anonymous Customer", style:
                      AppTextStyles.bold(fontSize: 18.0,fontColor: AppColors.blackColor)),
                      Text("Proposal", style: AppTextStyles.regular(fontSize: 14.0,fontColor: AppColors.blackColor)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Date: 3/24/25", style: AppTextStyles.regular(fontSize: 14.0, fontColor: Colors.green)),
                      Text("Expires: 3/24/25", style: AppTextStyles.regular(fontSize: 14.0, fontColor: Colors.green)),
                    ],
                  )
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
                indicator: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                dividerColor: Colors.transparent,
                isScrollable: true,

                padding: EdgeInsets.only(top: 4,bottom: 4,),
                tabs: const [
                  Tab(child: SizedBox(width: 80, child: Center(child: Text("Items")))),
                  Tab(child: SizedBox(width: 80, child: Center(child: Text("Payments")))),
                  Tab(child: SizedBox(width: 80, child: Center(child: Text("Details")))),
                  Tab(child: SizedBox(width: 80, child: Center(child: Text("Notes")))),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _itemsTab(),
                  _payments(),
                  _detailsTab(),
                  _notesTab(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

   Widget _payments(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.grey.shade200,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Anonymous Customer", style: AppTextStyles.bold(fontSize: 18.0, fontColor: AppColors.blackColor)),
              Text("Fully Paid", style: AppTextStyles.regular(fontSize: 14.0, fontColor: Colors.grey)),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Due: \$0.00"),
                      Text("Total Paid: \$0.00"),
                      Text("Balance: ", style: AppTextStyles.bold(fontSize: 16.0, fontColor: AppColors.blackColor)),
                    ],
                  ),
                  CommonElevatedButton(text: "Add payment", onPressed: (){
Get.toNamed(Routes.ADD_PAYMENNT);
                  })

                ],
              ),
            ],
          ),
        ),
        Container(
          color: AppColors.blueColor,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              Expanded(child: Text("Date", style: AppTextStyles.bold(fontSize: 14.0, fontColor: AppColors.whiteColor))),
              Expanded(child: Text("Method", style: AppTextStyles.bold(fontSize: 14.0, fontColor: AppColors.whiteColor))),
              Expanded(child: Text("Amount", style: AppTextStyles.bold(fontSize: 14.0, fontColor: AppColors.whiteColor))),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text("To see more options, long-hold on one line.", style: TextStyle(color: Colors.grey)),
        ),
        Expanded(
          child: Obx(() => ListView.separated(
            itemCount: payments.length,
            separatorBuilder: (context,index)=>Divider(),
            itemBuilder: (context, index) {
              final payment = payments[index];
              return GestureDetector(
                onLongPress: () => _showPaymentOptions(context),
                child: ListTile(
                  title: Row(
                    children: [
                      Expanded(child: Text(payment["date"] ?? "")),
                      Expanded(child: Text(payment["method"] ?? "")),
                      Expanded(child: Text("\$"+payment["amount"]!)),
                    ],
                  ),
                ),
              );
            },
          )),
        ),
      ],
    );
   }

  Widget _itemsTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              _keyValueRow("Sub Total:", "0.00"),
              _keyValueRow("Discount:", "0.00"),
              _keyValueRow("Shipping:", "0.00"),
              _keyValueRow("Taxes:", "0.00"),
              Divider(),
              _keyValueRow("TOTAL:", "0.00", isBold: true),
            ],
          ),
        ),
        CommonElevatedButton(text: "Add Item", onPressed: (){Get.toNamed(Routes.ITEMS,arguments: "estimate")!.then((v){


        });}),
        Divider(),
        _tableHeader(["Qty", "Description", "Gross Amt"]),

        Container(
          width: double.infinity,
          color: AppColors.blackColor,
          padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
          child: Text(
            "To see more options, long-hold on one line.",
            style: AppTextStyles.regular(fontSize: 10.0, fontColor: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return InkWell(
                onLongPress: (){
                  Get.bottomSheet(
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _popupTile(Icons.edit, "Edit", () {
                            // handle edit
                            Get.back();
                          }),
                          _popupTile(Icons.arrow_upward, "Move up", () {
                            // handle move up
                            Get.back();
                          }),
                          _popupTile(Icons.arrow_downward, "Move down", () {
                            // handle move down
                            Get.back();
                          }),
                          _popupTile(Icons.delete, "Remove line", () {
                            // handle remove
                            Get.back();
                          }),
                          _popupTile(Icons.copy, "Copy line", () {
                            // handle copy
                            Get.back();
                          }),
                          _popupTile(Icons.input, "Copy line to", () {
                            // handle copy line to
                            Get.back();
                          }),
                          _popupTile(Icons.content_copy, "Copy all lines to", () {
                            // handle copy all lines
                            Get.back();
                          }),
                        ],
                      ),
                    ),
                  );

                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 30, child: Text("${item['qty']}", style: AppTextStyles.regular(fontColor: AppColors.blackColor,fontSize: 12.0))),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${item['title']}", style: AppTextStyles.bold(fontSize: 14.0, fontColor: AppColors.blackColor)),
                            Text("${item['description']}", style: AppTextStyles.regular(fontSize: 13.0, fontColor: AppColors.blackColor)),
                          ],
                        ),
                      ),
                      Text("${item['amount'].toStringAsFixed(2)}", style: AppTextStyles.bold(fontSize: 14.0, fontColor: AppColors.blackColor)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
   void _showPaymentOptions(BuildContext context) {
     showModalBottomSheet(
       context: context,
       builder: (_) => Column(
         mainAxisSize: MainAxisSize.min,
         children: [
           ListTile(leading: Icon(Icons.edit,color: AppStorages.appColor.value,), title: Text("Edit"), onTap: () {}),
           ListTile(leading: Icon(Icons.email,color: AppStorages.appColor.value,), title: Text("Email"), onTap: () {}),
           ListTile(leading: Icon(Icons.sms,color: AppStorages.appColor.value,), title: Text("SMS"), onTap: () {}),
           ListTile(leading: Icon(Icons.print,color: AppStorages.appColor.value,), title: Text("Print"), onTap: () {}),
           ListTile(leading: Icon(Icons.delete,color: AppStorages.appColor.value,), title: Text("Delete"), onTap: () {}),
         ],
       ),
     );
   }

  Widget _detailsTab() {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: const [
        _keyValueRow("Project", "Egegge", isLink: true),
        _keyValueRow("Bill address", ""),
        _keyValueRow("Ship address", ""),
        Divider(),
        _keyValueRow("Tax Type", "One tax (5%)"),
        _keyValueRow("Tax Inclusive", "No"),
        _keyValueRow("Discounts", ""),
        _keyValueRow("Cost of goods", ""),
        _keyValueRow("Gross profit", ""),
        _keyValueRow("Is Processed?", "No"),
        _keyValueRow("Terms", "0 days"),
        _keyValueRow("Memo", ""),
        Divider(),
        _keyValueRow("Signed by", ""),
        _keyValueRow("Sign Date", ""),
        _keyValueRow("Signature", ""),
        Divider(),
        _keyValueRow("Created by:", "Test Test 3/24/25 10:08 PM"),
        _keyValueRow("Updated by:", "Test Test 3/24/25 10:08 PM"),
        _keyValueRow("MobileBiz Id:", "21"),
        _keyValueRow("External Id:", ""),
      ],
    );
  }

  Widget _notesTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                      child: Text("${itemNote[index].date.month}/${itemNote[index].date.day}/${itemNote[index].date.year}",style: AppTextStyles.regular(fontSize: 12.0, fontColor: AppColors.whiteColor),)),

                ],
              );
            },itemCount: itemNote.length):
        Center(child: Text("Notes"))),
      ],
    );
  }
}

class _keyValueRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final bool isLink;

  const _keyValueRow(this.label, this.value, {this.isBold = false, this.isLink = false});

  @override
  Widget build(BuildContext context) {
    final valueStyle = isBold
        ? AppTextStyles.bold(fontSize: 14.0,fontColor: AppColors.blackColor)
        : AppTextStyles.regular(fontSize: 14.0,fontColor: AppColors.blackColor);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: Text(label, style: AppTextStyles.bold(fontSize: 14.0,fontColor: AppColors.blackColor))),
          Expanded(
              flex: 5,
              child: isLink
                  ? Text(value, style: TextStyle(color: Colors.blue))
                  : Text(value, style: valueStyle)),
        ],
      ),
    );
  }
}

Widget _tableHeader(List<String> headers) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Row(
      children: headers.map((h) => Expanded(child: Text(h, style: AppTextStyles.bold(fontSize: 13.0,fontColor: AppColors.blackColor)))).toList(),
    ),
  );

}

Widget _popupTile(IconData icon, String label, VoidCallback onTap) {
  return ListTile(
    leading: Icon(icon, color: AppStorages.appColor.value),
    title: Text(label, style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.blackColor)),
    onTap: onTap,
  );
}
