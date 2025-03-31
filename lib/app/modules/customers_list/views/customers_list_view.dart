import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/modules/customers_list/views/customer_detail_view.dart';
import 'package:jumla/app/modules/tools/lists/views/item_categories_view.dart';
import '../../../core/app_storage.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_styles.dart';
import '../../../routes/app_pages.dart';
import '../../tools/manage_data/views/export_csv.dart';
import '../../tools/manage_data/views/import_csv.dart';
import '../controllers/customers_list_controller.dart';
import 'add_or_edit_customer_view.dart';


class CustomersListView extends GetWidget<CustomersListController> {
  const CustomersListView({super.key});
  @override
  Widget build(BuildContext context) {
var controller = Get.put(CustomersListController());
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Obx(() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: AppStorages.appColor.value,
            padding: const EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 5),
            child: SafeArea(
              bottom: false,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back_ios,color: AppColors.whiteColor,)),
                  if (controller.isSearching.value)
                    Expanded(
                      child: TextField(
                        controller: controller.searchController,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          hintStyle: TextStyle(color: Colors.white60),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(color: Colors.white),
                        onChanged: (val) => controller.searchQuery.value = val,
                      ),
                    )
                  else
                    Expanded(
                      child: Text("Customers", style: AppTextStyles.bold(fontColor: Colors.white, fontSize: 20.0),maxLines: 1,overflow: TextOverflow.ellipsis,),
                    ),
                  if (controller.isSearching.value)
                    IconButton(

                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: () {
                        controller.searchController.clear();
                        controller.searchQuery.value = '';
                        controller.isSearching.value = false;
                      },
                    )
                  else ...[
                    IconButton(

                      icon: Icon(Icons.search, color: Colors.white),
                      onPressed: () => controller.isSearching.value = true,
                    ),
                    IconButton(

                      icon: Icon(Icons.refresh, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        controller.selectedItem.value = null;
                        Get.to(() => AddOrEditCustomerScreen());
                      },
                    ),
                    PopupMenuButton<String>(
                      icon: Icon(Icons.more_vert, color: Colors.white),
                      onSelected: (value) {

                          showDialog(
                            context: context,
                            builder: (_) => SimpleDialog(
                              title: Text("Import / Export"),
                              children: [
                                ListTile(title: Text("Import CSV"), onTap: () { Navigator.pop(context);
                                Get.to(()=>ImportCSVScreen());
                                }),
                                ListTile(title: Text("Export CSV"), onTap: () { Navigator.pop(context);
                                Get.to(()=>ExportCSVScreen());
                                }),
                              ],
                            ),
                          );
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem<String>(
                          value: 'import_export',
                          child: Text('Import / Export'),
                        ),
                      ],
                    )
                  ]
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: Colors.black,
            width: double.infinity,
            child: Center(
              child: Text(
                "To see more options, long-hold on one line.",
                style: AppTextStyles.regular(fontColor: Colors.white, fontSize: 12.0),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0, right: 16.0),
              child: Text(
                "${controller.customer.length} records",
                style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.darkGrey),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.customer.length,
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final item = controller.customer[index];
                return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Obx(()=> ListTile(
                      tileColor: AppStorages.appColor.value.withOpacity(0.1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      title: Text(item.name.value, style: AppTextStyles.bold(fontColor: AppColors.blackColor,fontSize: 16.0)),
                      subtitle:  Text(item.isCompany.value?"Company":"", style: AppTextStyles.semiBold( fontSize: 15.0,fontColor: AppColors.blueColor)),
                      trailing: Icon(Icons.arrow_forward_ios,size: 15,),
                      onLongPress: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: Icon(Icons.edit,color: AppStorages.appColor.value,),
                                  title: Text("Edit this contact"),
                                  onTap: () {
                                    Get.back();
                                    controller.selectedItem.value = item;
                                    Get.to(() => AddOrEditCustomerScreen());
                                  },
                                ),
                                ListTile(
                                  leading: Icon(Icons.delete,color: AppStorages.appColor.value,),
                                  title: Text("Delete"),
                                  onTap: () {
                                      controller.deleteItem(item);
                                    Get.back();
                                  },
                                ),
                                ListTile(
                                    leading: Icon(Icons.category,color: AppStorages.appColor.value,),
                                    title: Text("Create a quote"),
                                    onTap: (){
                                      Get.back();
                                      Get.toNamed(Routes.ESTIMATE);
                                    }
                                ),
                                ListTile(
                                    leading: Icon(Icons.category,color: AppStorages.appColor.value,),
                                    title: Text("Create a sales order"),
                                    onTap: (){
                                      Get.back();
                                      Get.toNamed(Routes.SALES_ORDER);
                                    }
                                ),
                                ListTile(
                                    leading: Icon(Icons.category,color: AppStorages.appColor.value,),
                                    title: Text("Create a cash sale"),
                                    onTap: (){
                                      Get.back();
                                      Get.toNamed(Routes.CASH_SALE);
                                    }
                                ),
                                ListTile(
                                    leading: Icon(Icons.category,color: AppStorages.appColor.value,),
                                    title: Text("Create a invoice"),
                                    onTap: (){
                                      Get.back();
                                      Get.toNamed(Routes.INVOICE);
                                    }
                                ),

                              ],
                            ),
                          ),
                        );
                      },
                      onTap: (){
                        if( controller.isFrom.value){
                          Get.back(result:  item.name.value);
                        }else{
                        Get.to(()=>CustomerDetailView());}
                      },
                    ),
                    ));
              },
            ),
          ),
        ],
      )),
    );
  }
}