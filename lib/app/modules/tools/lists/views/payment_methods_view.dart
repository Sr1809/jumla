import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jumla/app/common/common_appbar.dart';
import 'package:jumla/app/core/app_storage.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:jumla/app/resources/app_styles.dart';
import '../../../../common/common_text_field.dart';

class PaymentMethodController extends GetxController {
  var methods = <PaymentMethod>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDummyData();
  }

  void _loadDummyData() {
    methods.addAll([
      PaymentMethod(name: "American Express", description: ""),
      PaymentMethod(name: "Cash", description: ""),
      PaymentMethod(name: "Check", description: ""),
      PaymentMethod(name: "Discover", description: ""),
      PaymentMethod(name: "Mastercard", description: ""),
      PaymentMethod(name: "PayPal", description: ""),
      PaymentMethod(name: "Visa", description: ""),
    ]);
  }

  void addOrUpdateMethod(PaymentMethod method) {
    int index = methods.indexWhere((m) => m.id == method.id);
    if (index != -1) {
      methods[index] = method;
    } else {
      methods.add(method);
    }
  }
  void deleteMethod(PaymentMethod method) {
    methods.removeWhere((m) => m.id == method.id);
  }
}

class PaymentMethod {
  final String id;
  RxString name;
  RxString description;

  PaymentMethod({
    String? id,
    required String name,
    required String description,
  })  : id = id ?? DateTime.now().toString(),
        name = name.obs,
        description = description.obs;
}

class PaymentMethodListView extends StatelessWidget {
  final PaymentMethodController controller = Get.put(PaymentMethodController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Payment Methods",
        hideLogo: true,
        showBackButton: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: AppColors.whiteColor),
            onPressed: () => Get.to(() => PaymentMethodFormView()),
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
                "${controller.methods.length} records",
                style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.darkGrey),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.methods.length,
              padding: EdgeInsets.all(20),
              itemBuilder: (context, index) {
                final method = controller.methods[index];
                return InkWell(
                  onTap: () => Get.to(() => PaymentMethodFormView(method: method)),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Obx(()=>ListTile(
                      tileColor: AppStorages.appColor.value.withOpacity(0.1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      title: Text(method.name.value, style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor)),
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

class PaymentMethodFormView extends StatelessWidget {
  final PaymentMethod? method;
  final PaymentMethodController controller = Get.find();

  PaymentMethodFormView({super.key, this.method});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: method?.name.value ?? "");
    TextEditingController descriptionController = TextEditingController(text: method?.description.value ?? "");

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Payment Method",
        hideLogo: true,
        showBackButton: true,
        actions: [
          if (method != null)
            IconButton(
              icon: Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () {
                controller.deleteMethod(method!);
                Get.back();
              },
            ),
          IconButton(
            icon: Icon(Icons.save, color: AppColors.whiteColor),
            onPressed: () {
              if (method == null) {
                controller.addOrUpdateMethod(
                  PaymentMethod(
                    name: nameController.text,
                    description: descriptionController.text,
                  ),
                );
              } else {
                method!.name.value = nameController.text;
                method!.description.value = descriptionController.text;
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
              hint: "eg. Cash",
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
