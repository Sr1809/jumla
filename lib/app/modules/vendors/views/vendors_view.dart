import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jumla/app/modules/customers_list/views/add_or_edit_customer_view.dart';
import 'package:jumla/app/modules/customers_list/views/customer_detail_view.dart';
import 'package:jumla/app/modules/invoice/views/invoice_detail_view.dart';

import '../../../core/app_storage.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_styles.dart';
import '../../../routes/app_pages.dart';
import '../../tools/manage_data/views/export_csv.dart';
import '../../tools/manage_data/views/import_csv.dart';
import '../controllers/vendors_controller.dart';

class VendorsView extends GetView<VendorsController> {
  const VendorsView({super.key});
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Obx(() => Column(
        children: [
          Container(
            color: AppStorages.appColor.value,
            padding: const EdgeInsets.only(left: 10,right: 10,top: 0,bottom: 5),
            child: SafeArea(
              bottom: false,
              child: Row(
                children: [
                  IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back_ios,color: AppColors.whiteColor,)),
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
                      child: Text("Vendors", style: AppTextStyles.bold(fontColor: Colors.white, fontSize: 20.0)),
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
                      icon: Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                       Get.to(()=>AddOrEditCustomerScreen(title: "New Vendor",));
                      },
                    ),
                    PopupMenuButton<String>(
                      icon: Icon(Icons.more_vert, color: Colors.white),
                      onSelected: (value) {
                        if (value == 'use_pictures') {
                          controller.usePictures.value = !controller.usePictures.value;
                        } else if (value == 'filter') {
                          showDialog(
                            context: context,
                            builder: (_) => SimpleDialog(
                              title: Text("Filter"),
                              children: [
                                ListTile(title: Text("By category"), onTap: () => Navigator.pop(context)),
                                ListTile(title: Text("By active/inactive"), onTap: () => Navigator.pop(context)),
                              ],
                            ),
                          );
                        } else if (value == 'import_export') {
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
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem<String>(
                          value: 'filter',
                          child: Text('Filter'),
                        ),
                        PopupMenuItem<String>(
                          value: 'use_pictures',
                          child: Text(controller.usePictures.value ? 'Hide pictures' : 'Use pictures'),
                        ),
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
                "${controller.items.length} records",
                style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.darkGrey),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.items.length,
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final item = controller.items[index];
                return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Obx(()=> ListTile(
                      tileColor: AppStorages.appColor.value.withOpacity(0.1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      title: Text(item.name.value, style: AppTextStyles.bold(fontColor: AppColors.blackColor,fontSize: 16.0)),
                      subtitle: Text(item.category.value, style: AppTextStyles.regular(fontColor: AppColors.blackColor,fontSize: 14.0)),
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
                                  title: Text("Edit this vendor"),
                                  onTap: () {
                                    Get.back();
Get.to(()=>AddOrEditCustomerScreen());
                                  },
                                ),

                                ListTile(
                                    leading: Icon(Icons.category,color: AppStorages.appColor.value,),
                                    title: Text("Delete this vendor"),
                                    onTap: (){ Get.back();
                                    Get.to(()=>InvoiceDetailView(title: "VENDOR",));
                                    }
                                ),
                                ListTile(
                                  leading: Icon(Icons.delete,color: AppStorages.appColor.value,),
                                  title: Text("Create a purchase order"),
                                  onTap: () {
                                    controller.deleteItem(item);
                                    Get.back();
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      onTap: (){

                        Get.to(()=>CustomerDetailView(title: "Vendor",));
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
