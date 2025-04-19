import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/common_appbar.dart';
import '../../../common/common_button.dart';
import '../../../core/app_storage.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_styles.dart';
import '../../items/views/add_note_view.dart';
import '../controllers/customers_list_controller.dart';

class CustomerDetailView extends StatelessWidget {
  var controller = Get.put(CustomersListController());
var title;
  CustomerDetailView({super.key,this.title});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: CommonAppBarWithTitleAndIcon(
          title: title ?? "Customer",
          showBackButton: true,
          hideLogo: true,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.edit, color: AppColors.whiteColor)),
            IconButton(onPressed: () {}, icon: Icon(Icons.check, color: AppColors.whiteColor)),
          ],
        ),
        body: Column(
          children: [
            _header(),
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
                  Tab(child: SizedBox(width: 80, child: Center(child: Text("Info")))),
                  Tab(child: SizedBox(width: 80, child: Center(child: Text("Sales")))),
                  Tab(child: SizedBox(width: 80, child: Center(child: Text("Payments")))),
                  Tab(child: SizedBox(width: 80, child: Center(child: Text("Projects")))),
                  Tab(child: SizedBox(width: 80, child: Center(child: Text("Notes")))),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _infoTab(),
                  _salesTab(),
                  _paymentsTab(),
                  _projectsTab(),
                  _notesTab(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Anonymous Customer", style: AppTextStyles.bold(fontSize: 18.0,fontColor: AppColors.blackColor)),
          Text("Customer", style: AppTextStyles.regular(fontSize: 14.0,fontColor: AppColors.blackColor)),
        ],
      ),
    );
  }

  Widget _infoTab() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: const [
        _keyValueRow("Home:", "None"),
        _keyValueRow("Phone:", "8557765"),
        _keyValueRow("Email:", "anonymous@mycompany.com"),
        Divider(),
        _keyValueRow("Type:", "Company"),
        _keyValueRow("Is Public:", "No"),
        _keyValueRow("Taxable:", "Yes (Tax)"),
        _keyValueRow("Price Level:", "Base Price 0%"),
        _keyValueRow("Terms:", "Same day"),
        Divider(),
        _keyValueRow("Created by:", "Test Test 3/1/25"),
        _keyValueRow("Updated by:", "Test Test 3/2/25"),
        _keyValueRow("MobileBiz Id:", "1"),
        _keyValueRow("External Id:", ""),
      ],
    );
  }

  Widget _salesTab() {
    return Obx(() => ListView.builder(
      itemCount: controller.sales.length,
      itemBuilder: (context, index) {
        final item = controller.sales[index];
        return ListTile(
          title: Row(
            children: [
              Expanded(child: Text(item['date'] ?? '')),
              Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['transaction'] ?? 'test', style: AppTextStyles.bold(fontSize: 14.0,fontColor: AppColors.blackColor)),
                      Text(item['status'] ?? '', style: AppTextStyles.regular(fontSize: 12.0,fontColor: AppColors.blackColor)),
                    ],
                  )),
              Expanded(child: Text("\$${item['total']!}")),
            ],
          ),
        );
      },
    ));
  }

  Widget _paymentsTab() {
    return Obx(() => Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text("Total Due: 0.00"),
                  Text("Total Paid: 0.00"),
                  Text("Balance: \$0.00", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              CommonElevatedButton(text: "Accept Payments", onPressed: () {})
            ],
          ),
        ),
        Container(
          color: AppColors.blueColor,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            children: [
              Expanded(child: Text("Date", style: AppTextStyles.bold(fontColor: AppColors.whiteColor,fontSize: 13.0))),
              Expanded(child: Text("Payment", style: AppTextStyles.bold(fontColor: AppColors.whiteColor,fontSize: 13.0))),
              Expanded(child: Text("Amount", style: AppTextStyles.bold(fontColor: AppColors.whiteColor,fontSize: 13.0))),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: controller.payments.length,
            itemBuilder: (context, index) {
              final payment = controller.payments[index];
              return ListTile(
                title: Row(
                  children: [
                    Expanded(child: Text(payment['date'] ?? '')),
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(payment['method'] ?? ''),
                            Text(payment['reference'] ?? ''),
                          ],
                        )),
                    Expanded(child: Text("\$${payment['amount']!}")),
                  ],
                ),
              );
            },
          ),
        )
      ],
    ));
  }

  Widget _projectsTab() {
    return Obx(() => Column(
      children: [
        Row(
          children: [
            Spacer(),
            CommonElevatedButton(text: "+", onPressed: () {}),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: controller.projects.length,
            itemBuilder: (context, index) {
              final project = controller.projects[index];
              return ListTile(
                title: Text(project['title'] ?? ''),
                subtitle: Text(project['description'] ?? ''),
                trailing: Text(project['startDate'] ?? 'Not Set'),
              );
            },
          ),
        ),
      ],
    ));
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
                    controller.itemNote.add(v);}
                });
              }, child: Text("Add note")),
              SizedBox(width: 10),
              ElevatedButton(onPressed: () {
                controller.itemNote.clear();
              }, child: Text("Clear")),
            ],
          ),
        ),
        Obx(()=> controller.itemNote.isNotEmpty ? ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(20),
            itemBuilder: (context,index){
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(controller.itemNote[index].note,style: AppTextStyles.regular(fontSize: 15.0, fontColor: AppColors.blackColor),),
                  Container(
                      decoration: BoxDecoration(
                          color: AppStorages.appColor.value
                      ),
                      padding: EdgeInsets.only(left: 5,right: 5,top: 3,bottom: 3),
                      child: Text("${controller.itemNote[index].date.month}/${controller.itemNote[index].date.day}/${controller.itemNote[index].date.year}",style: AppTextStyles.regular(fontSize: 12.0, fontColor: AppColors.whiteColor),)),

                ],
              );
            },itemCount: controller.itemNote.length):
        Center(child: Text("Notes"))),
      ],
    );
  }
}

class _keyValueRow extends StatelessWidget {
  final String label;
  final String value;

  const _keyValueRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(flex: 3, child: Text(label,)),
          Expanded(flex: 5, child: Text(value,)),
        ],
      ),
    );
  }
}
