import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/modules/tools/lists/views/item_categories_view.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import '../../../core/app_storage.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_styles.dart';
import '../../tools/manage_data/views/export_csv.dart';
import '../../tools/manage_data/views/import_csv.dart';
import '../controllers/items_controller.dart';
import 'add_or_edit_item_view.dart';
import 'item_detail_view.dart';

class ItemsView extends GetWidget<ItemsController> {
  const ItemsView({super.key});
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
                      child: Text("Items", style: AppTextStyles.bold(fontColor: Colors.white, fontSize: 20.0)),
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
                        Get.to(() => AddOrEditItemScreen());
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
                    leading: controller.usePictures.value
                        ? Container(width: 40, height: 40, color: Colors.grey[300])
                        : null,
                    title: Text(item.name.value, style: AppTextStyles.bold(fontColor: AppColors.blackColor,fontSize: 14.0)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.category.value, style: AppTextStyles.bold( fontSize: 14.0,fontColor: AppColors.blueColor)),
                        Text(item.description.value, style: AppTextStyles.regular( fontSize: 12.0,fontColor: AppColors.blackColor)),
                      ],
                    ),
                    trailing: Text(item.price.value.toStringAsFixed(2), style: AppTextStyles.bold(fontSize: 13.0,fontColor: AppColors.blackColor)),
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
                                title: Text("Edit"),
                                onTap: () {
                                  Get.back();
                                  controller.selectedItem.value = item;
                                  Get.to(() => AddOrEditItemScreen());
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.adjust,color: AppStorages.appColor.value,),
                                title: Text("Adjust inventory"),
                                onTap: () { Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text("Reset stock quantity"),
                                    content: TextField(
                                      decoration: InputDecoration(
                                        hintText: "Enter a quantity ..",
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(color: AppStorages.appColor.value),
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Get.back(),
                                        child: Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: ()=>Get.back(),
                                        child: Text("Done"),
                                      ),
                                    ],
                                  ),
                                );

                                }
                              ),
                              ListTile(
                                leading: Icon(Icons.category,color: AppStorages.appColor.value,),
                                title: Text("Change category"),
                                onTap: (){ Get.back();
                                Get.to(()=>ItemCategoryListView("options"))!.then((v){
                                  if(v!=null){
                                    item.category.value = v;
                                  }
                                });
                                }
                              ),
                              ListTile(
                                leading: Icon(Icons.delete,color: AppStorages.appColor.value,),
                                title: Text("Delete"),
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
                      if(controller.itsFrom.value){
                        Get.back(result: item);
                      }else{
                  Get.to(()=>ItemDetailScreen());}
                  print("@@@");
                  },
                  ),
                ));
              },
            ),
          ),
        ],
      )),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
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
                icon: Icon(Icons.qr_code_scanner),
                label: Text("Find"),
              ),
              ElevatedButton.icon(
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
                icon: Icon(Icons.qr_code),
                label: Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
