import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jumla/app/core/app_storage.dart';

import '../../../../common/common_appbar.dart';
import '../../../../common/common_text_field.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_styles.dart';

class SimpleStatus {
  final String id;
  RxString name;
  RxInt? probability;

  SimpleStatus({
    String? id,
    required String name,
    int? probability,
  })  : id = id ?? DateTime.now().toString(),
        name = name.obs,
        probability = probability?.obs;
}

class SimpleStatusController extends GetxController {
  final String title;
  final bool showProbability;
  var items = <SimpleStatus>[].obs;

  SimpleStatusController(this.title, {this.showProbability = false});

  @override
  void onInit() {
    super.onInit();
    _loadPresetData();
  }

  void _loadPresetData() {
    switch (title) {
      case "Quote Status":
        items.addAll([
          SimpleStatus(name: "Closed Lost", probability: 0),
          SimpleStatus(name: "Proposal", probability: 50),
          SimpleStatus(name: "In Negotiation", probability: 75),
          SimpleStatus(name: "Purchasing", probability: 90),
          SimpleStatus(name: "Closed Won", probability: 100),
        ]);
        break;
      case "Sales Order Status":
        items.addAll([
          SimpleStatus(name: "Cancelled"),
          SimpleStatus(name: "Pending Billing"),
        ]);
        break;
      case "Invoice Status":
        items.addAll([
          SimpleStatus(name: "Closed"),
          SimpleStatus(name: "Fully Paid"),
          SimpleStatus(name: "Partially Paid"),
          SimpleStatus(name: "Pending Payment"),
          SimpleStatus(name: "Void"),
        ]);
        break;
      case "Cash Sale Status":
        items.addAll([
          SimpleStatus(name: "Fully Paid"),
          SimpleStatus(name: "Partially Paid"),
          SimpleStatus(name: "Pending Payment"),
        ]);
        break;
      case "Purchase Order Status":
        items.addAll([
          SimpleStatus(name: "Fully Paid"),
          SimpleStatus(name: "Partially Paid"),
          SimpleStatus(name: "Pending Payment"),
        ]);
        break;
    }
  }

  void addOrUpdate(SimpleStatus status) {
    int index = items.indexWhere((e) => e.id == status.id);
    if (index != -1) {
      items[index] = status;
    } else {
      items.add(status);
    }
  }
}
class StatusListScreen extends StatelessWidget {
  final String title;
  final bool showProbability;

  const StatusListScreen({super.key, required this.title, this.showProbability = false});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SimpleStatusController(title, showProbability: showProbability));

    return Scaffold(
      backgroundColor: AppColors.whiteColor,

      appBar: CommonAppBarWithTitleAndIcon(
        title: title,
        hideLogo: true,
        showBackButton: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: AppColors.whiteColor),
            onPressed: () => Get.to(() => StatusFormScreen(controller: controller)),
          )
        ],
      ),
      body: Obx(() => ListView.builder(
        itemCount: controller.items.length,
        padding: EdgeInsets.all(20),
        itemBuilder: (context, index) {
          final item = controller.items[index];
          return InkWell(
            onTap: () => Get.to(() => StatusFormScreen(controller: controller, item: item)),
            child:Obx(()=> Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: ListTile(
                tileColor: AppStorages.appColor.value.withOpacity(0.1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                title: Text(
                  controller.showProbability
                      ? "${item.name.value} (${item.probability?.value ?? 0} %)"
                      : item.name.value,
                  style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor),
                ),
              ),
            )),
          );
        },
      )),
    );
  }
}
class StatusFormScreen extends StatelessWidget {
  final SimpleStatusController controller;
  final SimpleStatus? item;

  StatusFormScreen({super.key, required this.controller, this.item});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameCtrl = TextEditingController(text: item?.name.value ?? "");
    TextEditingController probCtrl = TextEditingController(text: item?.probability?.value.toString() ?? "");

    return Scaffold(
      backgroundColor: AppColors.whiteColor,

      appBar: CommonAppBarWithTitleAndIcon(
        title: controller.title,
        hideLogo: true,
        showBackButton: true,
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: AppColors.whiteColor),
            onPressed: () {
              if (item == null) {
                controller.addOrUpdate(SimpleStatus(
                  name: nameCtrl.text,
                  probability: controller.showProbability ? int.tryParse(probCtrl.text) ?? 0 : 0,
                ));
              } else {
                item!.name.value = nameCtrl.text;
                if (controller.showProbability) {
                  item!.probability?.value = int.tryParse(probCtrl.text) ?? 0;
                }
              }
              Get.back();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(child: CommonTextFieldWithTitle(label: "Name", controller: nameCtrl)),
            if (controller.showProbability) ...[
              SizedBox(width: 10),
              Expanded(child: CommonTextFieldWithTitle(label: "Probability (%)", controller: probCtrl)),
            ]
          ],
        ),
      ),
    );
  }
}
