import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jumla/app/modules/estimate/views/estimate_detail_view.dart';
import 'package:jumla/app/modules/estimate/views/estimate_view.dart';
import 'package:jumla/app/modules/items/views/item_detail_view.dart';
import 'package:jumla/app/modules/reports/views/filter_view.dart';

import '../controllers/quotes_controller.dart';
import 'package:jumla/app/modules/customers_list/views/customer_detail_view.dart';
import 'package:jumla/app/modules/invoice/views/invoice_detail_view.dart';

import '../../../core/app_storage.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_styles.dart';
import '../../../routes/app_pages.dart';

class QuotesView extends GetView<QuotesController> {
  const QuotesView({super.key});
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
                      child: Text("Quotes", style: AppTextStyles.bold(fontColor: Colors.white, fontSize: 20.0)),
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
                       Get.toNamed(Routes.ESTIMATE);
                      },
                    ),
                    PopupMenuButton<String>(
                      icon: Icon(Icons.more_vert, color: Colors.white),
                      onSelected: (value) {
                       if (value == 'use_pictures') {
Get.to(()=>FilterSortScreen());
                        } else if (value == 'import_export') {

                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem<String>(
                          value: 'filter',
                          child: Text('Sync'),
                        ),
                        PopupMenuItem<String>(
                          value: 'use_pictures',
                          child: Text('Filet/Sort'),
                        ),
                        PopupMenuItem<String>(
                          value: 'import_export',
                          child: Text('Export'),
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
                      leading: controller.usePictures.value
                          ? Container(width: 40, height: 40, color: Colors.grey[300])
                          : null,
                      title: Text(item.name.value, style: AppTextStyles.bold(fontColor: AppColors.blackColor,fontSize: 16.0)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.category.value, style: AppTextStyles.bold( fontSize: 13.0,fontColor: AppColors.blueColor)),
                          Row(
                            children: [
                              Text("Date:", style: AppTextStyles.regular( fontSize: 12.0,fontColor: AppColors.greyColor)),
                              Text(item.type.value, style: AppTextStyles.regular( fontSize: 12.0,fontColor: AppColors.blackColor)),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Date:", style: AppTextStyles.regular( fontSize: 12.0,fontColor: AppColors.greyColor)),
                              Text(item.type.value, style: AppTextStyles.regular( fontSize: 12.0,fontColor: AppColors.blackColor)),
                            ],
                          ),
                        ],
                      ),
                      trailing:Obx(()=> Text("\$"+item.price.value.toStringAsFixed(2), style: AppTextStyles.bold(fontSize: 14.0,fontColor: !item.isTaxable.value ?AppStorages.appColor.value:AppColors.blackColor))),
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
                                  title: Text("View this Invoices"),
                                  onTap: () {
                                    Get.back();
                                    Get.to(() => InvoiceDetailView());
                                  },
                                ),
                                ListTile(
                                    leading: Icon(Icons.adjust,color: AppStorages.appColor.value,),
                                    title: Text("Mark as processed"),
                                    onTap: () {
                                      Get.back();
                                      item.isTaxable.value = !item.isTaxable.value;
                                    }
                                ),
                                ListTile(
                                    leading: Icon(Icons.category,color: AppStorages.appColor.value,),
                                    title: Text("Go to customer"),
                                    onTap: (){ Get.back();
                                    Get.to(CustomerDetailView());
                                    }
                                ),
                                ListTile(
                                  leading: Icon(Icons.delete,color: AppStorages.appColor.value,),
                                  title: Text("Delete this invoice"),
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

                        Get.to(()=>EstimateDetailScreen());
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

