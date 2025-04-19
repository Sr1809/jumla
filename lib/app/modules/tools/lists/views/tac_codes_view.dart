import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jumla/app/common/common_appbar.dart';
import 'package:jumla/app/core/app_storage.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:jumla/app/resources/app_styles.dart';
import '../../../../common/common_text_field.dart';

class TaxCodeController extends GetxController {
  var taxCodes = <TaxCode>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDummyData();
  }

  void _loadDummyData() {
    taxCodes.addAll([
      TaxCode(name: "0", rate: 0.0, description: ""),
      TaxCode(name: "Rrr", rate: 0.0, description: ""),
      TaxCode(name: "Trgtg", rate: 25.0, description: ""),
      TaxCode(name: "Tax", rate: 5.0, description: ""),
    ]);
  }

  void addOrUpdateTaxCode(TaxCode taxCode) {
    int index = taxCodes.indexWhere((t) => t.id == taxCode.id);
    if (index != -1) {
      taxCodes[index] = taxCode;
    } else {
      taxCodes.add(taxCode);
    }
  }

  void deleteTaxCode(TaxCode taxCode) {
    taxCodes.removeWhere((t) => t.id == taxCode.id);
  }
}

class TaxCode {
  final String id;
  RxString name;
  RxDouble rate;
  RxString description;

  TaxCode({
    String? id,
    required String name,
    required double rate,
    required String description,
  })  : id = id ?? DateTime.now().toString(),
        name = name.obs,
        rate = rate.obs,
        description = description.obs;
}

class TaxCodeListView extends StatelessWidget {
  var from;
  TaxCodeListView(this.from);
  final TaxCodeController controller = Get.put(TaxCodeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Tax Codes",
        hideLogo: true,
        showBackButton: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: AppColors.whiteColor),
            onPressed: () => Get.to(() => TaxCodeFormView()),
          )
        ],
      ),
      body: Obx(() => ListView.builder(
        itemCount: controller.taxCodes.length,
        padding: EdgeInsets.all(20),
        itemBuilder: (context, index) {
          final tax = controller.taxCodes[index];
          return InkWell(
            onTap: () => from == "item"?Get.back(result: "${tax.name} ${tax.rate}%"):Get.to(() => TaxCodeFormView(taxCode: tax)),
            child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Obx(()=>ListTile(
                tileColor: AppStorages.appColor.value.withOpacity(0.1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                title: Text(tax.name.value, style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor)),
                subtitle: Text("${tax.rate.value.toString()} %",style: AppTextStyles.bold(fontSize: 14.0, fontColor: AppColors.blackColor),),
              ),
            )),
          );
        },
      )),
    );
  }
}

class TaxCodeFormView extends StatelessWidget {
  final TaxCode? taxCode;
  final TaxCodeController controller = Get.find();

  TaxCodeFormView({super.key, this.taxCode});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: taxCode?.name.value ?? "");
    TextEditingController rateController = TextEditingController(text: taxCode?.rate.value.toString() ?? "");
    TextEditingController descriptionController = TextEditingController(text: taxCode?.description.value ?? "");

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Tax Code",
        hideLogo: true,
        showBackButton: true,
        actions: [
          if (taxCode != null)
            IconButton(
              icon: Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () {
                controller.deleteTaxCode(taxCode!);
                Get.back();
              },
            ),
          IconButton(
            icon: Icon(Icons.save, color: AppColors.whiteColor),
            onPressed: () {
              if (taxCode == null) {
                controller.addOrUpdateTaxCode(
                  TaxCode(
                    name: nameController.text,
                    rate: double.tryParse(rateController.text) ?? 0.0,
                    description: descriptionController.text,
                  ),
                );
              } else {
                taxCode!.name.value = nameController.text;
                taxCode!.rate.value = double.tryParse(rateController.text) ?? 0.0;
                taxCode!.description.value = descriptionController.text;
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
            Row(
              children: [
                Expanded(
                  child: CommonTextFieldWithTitle(
                    label: "Name",
                    controller: nameController,
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: CommonTextFieldWithTitle(
                    label: "Rate(%)",
                    hint: "10%",
                    controller: rateController,
                    keyboardType: TextInputType.number, // Show number keyboard
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Rate is required';
                      }

                      final parsed = double.tryParse(value.replaceAll('%', '').trim());
                      if (parsed == null) {
                        return 'Enter a valid number';
                      }

                      if (parsed < 0 || parsed > 100) {
                        return 'Rate must be between 0 and 100';
                      }

                      return null;
                    },
                  ),
                ),

              ],
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