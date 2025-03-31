import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jumla/app/common/common_appbar.dart';
import 'package:jumla/app/core/app_storage.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:jumla/app/resources/app_styles.dart';
import '../../../../common/common_text_field.dart';

class PriceLevelController extends GetxController {
  var priceLevels = <PriceLevel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDummyData();
  }

  void _loadDummyData() {
    priceLevels.addAll([
      PriceLevel(name: "Base Price", percentage: 0, description: ""),
      PriceLevel(name: "Custom Price", percentage: 0, description: ""),
    ]);
  }

  void addOrUpdatePriceLevel(PriceLevel level) {
    int index = priceLevels.indexWhere((s) => s.id == level.id);
    if (index != -1) {
      priceLevels[index] = level;
    } else {
      priceLevels.add(level);
    }
  }
}

class PriceLevel {
  final String id;
  RxString name;
  RxInt percentage;
  RxString description;

  PriceLevel({
    String? id,
    required String name,
    required int percentage,
    required String description,
  })  : id = id ?? DateTime.now().toString(),
        name = name.obs,
        percentage = percentage.obs,
        description = description.obs;
}

class PriceLevelListView extends StatelessWidget {
  var from;
  PriceLevelListView(this.from);
  final PriceLevelController controller = Get.put(PriceLevelController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Price Levels",
        hideLogo: true,
        showBackButton: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: AppColors.whiteColor),
            onPressed: () => Get.to(() => PriceLevelFormView()),
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
                "${controller.priceLevels.length} records",
                style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.darkGrey),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.priceLevels.length,
              padding: EdgeInsets.all(20),
              itemBuilder: (context, index) {
                final level = controller.priceLevels[index];
                return InkWell(
                  onTap: () =>from == "customer"?Get.back(result:  "${level.name.value}  ${level.percentage.value} %") :Get.to(() => PriceLevelFormView(level: level)),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Obx(()=>ListTile(
                      tileColor: AppStorages.appColor.value.withOpacity(0.1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      title: Text(
                        "${level.name.value}  ${level.percentage.value} %",
                        style: AppTextStyles.regular(fontSize: 16.0,fontColor: AppColors.blackColor),
                      ),
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

class PriceLevelFormView extends StatelessWidget {
  final PriceLevel? level;
  final PriceLevelController controller = Get.find();

  PriceLevelFormView({super.key, this.level});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: level?.name.value ?? "");
    TextEditingController percentageController = TextEditingController(text: level?.percentage.value.toString() ?? "");
    TextEditingController descriptionController = TextEditingController(text: level?.description.value ?? "");

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Price Level",
        hideLogo: true,
        showBackButton: true,
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: AppColors.whiteColor),
            onPressed: () {
              if (level == null) {
                controller.addOrUpdatePriceLevel(
                  PriceLevel(
                    name: nameController.text,
                    percentage: int.tryParse(percentageController.text) ?? 0,
                    description: descriptionController.text,
                  ),
                );
              } else {
                level!.name.value = nameController.text;
                level!.percentage.value = int.tryParse(percentageController.text) ?? 0;
                level!.description.value = descriptionController.text;
              }
              Get.back();
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CommonTextFieldWithTitle(
              label: "Name",
              controller: nameController,
              hint: "eg. Alternate Price",
            ),
            CommonTextFieldWithTitle(
              label: "Discount/Markup (%)",
              controller: percentageController,
              hint: "eg. -10 or 10",
            ),
            CommonTextFieldWithTitle(
              label: "Description",
              controller: descriptionController,
            ),
          ],
        ),
      ),
    );
  }
}
