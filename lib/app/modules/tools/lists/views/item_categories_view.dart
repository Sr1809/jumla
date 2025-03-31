import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/common/common_appbar.dart';
import 'package:jumla/app/core/app_storage.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:jumla/app/resources/app_styles.dart';
import '../../../../common/common_text_field.dart';

class ItemCategory {
  final String id;
  RxString name;

  ItemCategory({
    String? id,
    required String name,
  })  : id = id ?? DateTime.now().toString(),
        name = name.obs;
}

class ItemCategoryController extends GetxController {
  var categories = <ItemCategory>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDummyData();
  }

  void _loadDummyData() {
    categories.addAll([
      ItemCategory(name: "Test"),
      ItemCategory(name: "Uncategorized"),
    ]);
  }

  void addOrUpdateCategory(ItemCategory category) {
    int index = categories.indexWhere((c) => c.id == category.id);
    if (index != -1) {
      categories[index] = category;
    } else {
      categories.add(category);
    }
  }
}

class ItemCategoryListView extends StatelessWidget {
  var from;
  ItemCategoryListView(this.from);
  final ItemCategoryController controller = Get.put(ItemCategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Item Categories",
        hideLogo: true,
        showBackButton: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: AppColors.whiteColor),
            onPressed: () => Get.to(() => ItemCategoryFormView()),
          )
        ],
      ),
      body: Obx(() => Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0, right: 16.0),
              child: Text(
                "${controller.categories.length} records",
                style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.darkGrey),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.categories.length,
              padding: EdgeInsets.all(20),
              itemBuilder: (context, index) {
                final category = controller.categories[index];
                return InkWell(
                  onTap: () => from == "options"?Get.back(result: category.name.value): Get.to(() => ItemCategoryFormView(category: category)),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child:Obx(()=> ListTile(
                      tileColor: AppStorages.appColor.value.withOpacity(0.1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      title: Text(category.name.value, style: AppTextStyles.regular(fontSize: 16.0,fontColor: AppColors.blackColor)),
                    )),
                  ),
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}

class ItemCategoryFormView extends StatelessWidget {
  final ItemCategory? category;
  final ItemCategoryController controller = Get.find();

  ItemCategoryFormView({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: category?.name.value ?? "");

    return Scaffold(
      backgroundColor: AppColors.whiteColor,

      appBar: CommonAppBarWithTitleAndIcon(
        title: "Item Category",
        hideLogo: true,
        showBackButton: true,
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: AppColors.whiteColor),
            onPressed: () {
              if (category == null) {
                controller.addOrUpdateCategory(ItemCategory(name: nameController.text));
              } else {
                category!.name.value = nameController.text;
              }
              Get.back();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CommonTextFieldWithTitle(label: "Category name", controller: nameController),
      ),
    );
  }
}