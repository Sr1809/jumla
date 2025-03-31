import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jumla/app/common/common_appbar.dart';
import 'package:jumla/app/core/app_storage.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:jumla/app/resources/app_styles.dart';
import '../../../../common/common_text_field.dart';

class PaymentTermController extends GetxController {
  var terms = <PaymentTerm>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDummyData();
  }

  void _loadDummyData() {
    terms.addAll([
      PaymentTerm(term: "Same day", days: 0, description: ""),
      PaymentTerm(term: "7 days", days: 7, description: ""),
      PaymentTerm(term: "14 days", days: 14, description: ""),
      PaymentTerm(term: "21 days", days: 21, description: ""),
      PaymentTerm(term: "30 days", days: 30, description: ""),
      PaymentTerm(term: "45 days", days: 45, description: ""),
      PaymentTerm(term: "60 days", days: 60, description: ""),
      PaymentTerm(term: "180 days", days: 180, description: ""),
      PaymentTerm(term: "365 days", days: 365, description: ""),
    ]);
  }

  void addOrUpdateTerm(PaymentTerm term) {
    int index = terms.indexWhere((t) => t.id == term.id);
    if (index != -1) {
      terms[index] = term;
    } else {
      terms.add(term);
    }
  }

  void deleteTerm(PaymentTerm term) {
    terms.removeWhere((t) => t.id == term.id);
  }
}

class PaymentTerm {
  final String id;
  RxString term;
  RxInt days;
  RxString description;

  PaymentTerm({
    String? id,
    required String term,
    required int days,
    required String description,
  })  : id = id ?? DateTime.now().toString(),
        term = term.obs,
        days = days.obs,
        description = description.obs;
}

class PaymentTermListView extends StatelessWidget {
  final PaymentTermController controller = Get.put(PaymentTermController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Payment Terms",
        hideLogo: true,
        showBackButton: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: AppColors.whiteColor),
            onPressed: () => Get.to(() => PaymentTermFormView()),
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
                "${controller.terms.length} records",
                style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.darkGrey),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.terms.length,
              padding: EdgeInsets.all(20),
              itemBuilder: (context, index) {
                final term = controller.terms[index];
                return InkWell(
                  onTap: () => Get.to(() => PaymentTermFormView(term: term)),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Obx(()=>ListTile(
                      tileColor: AppStorages.appColor.value.withOpacity(0.1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      title: Text(term.term.value, style: AppTextStyles.regular(fontSize: 16.0,fontColor: AppColors.blackColor)),
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

class PaymentTermFormView extends StatelessWidget {
  final PaymentTerm? term;
  final PaymentTermController controller = Get.find();

  PaymentTermFormView({super.key, this.term});

  @override
  Widget build(BuildContext context) {
    TextEditingController termController = TextEditingController(text: term?.term.value ?? "");
    TextEditingController daysController = TextEditingController(text: term?.days.value.toString() ?? "");
    TextEditingController descriptionController = TextEditingController(text: term?.description.value ?? "");

    return Scaffold(

      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Payment Term",
        hideLogo: true,
        showBackButton: true,
        actions: [
          // if (term != null)
          //   IconButton(
          //     icon: Icon(Icons.delete, color: Colors.redAccent),
          //     onPressed: () {
          //       controller.deleteTerm(term!);
          //       Get.back();
          //     },
          //   ),
          IconButton(
            icon: Icon(Icons.save, color: AppColors.whiteColor),
            onPressed: () {
              if (term == null) {
                controller.addOrUpdateTerm(
                  PaymentTerm(
                    term: termController.text,
                    days: int.tryParse(daysController.text) ?? 0,
                    description: descriptionController.text,
                  ),
                );
              } else {
                term!.term.value = termController.text;
                term!.days.value = int.tryParse(daysController.text) ?? 0;
                term!.description.value = descriptionController.text;
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
              label: "Terms",
              controller: termController,
            ),
            CommonTextFieldWithTitle(
              label: "Days",
              controller: daysController,
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
