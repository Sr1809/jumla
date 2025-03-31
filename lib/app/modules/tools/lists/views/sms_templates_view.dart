import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/common/common_appbar.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:jumla/app/resources/app_styles.dart';

import '../../../../common/common_text_field.dart';
import '../../../../core/app_storage.dart';

// Controller for SMS Templates
class SmsTemplatesController extends GetxController {
  var smsTemplates = <SmsTemplateModel>[].obs;
  @override
  void onInit() {
    super.onInit();
    _loadDummyData(); // Load dummy data on initialization
  }

  void _loadDummyData() {
    smsTemplates.addAll([
      SmsTemplateModel(
        id: "1",
        name: "Test Template",
        applyTo: "Cash Sale",
        message: "Thank you for your cash purchase!",
        isDefault: true,
      ),
      SmsTemplateModel(
        id: "2",
        name: "Order Confirmation",
        applyTo: "Sales Order",
        message: "Your order has been received. We will process it soon.",
        isDefault: false,
      ),
    ]);
  }
  void addOrUpdateTemplate(SmsTemplateModel template) {
    int index = smsTemplates.indexWhere((t) => t.id == template.id);
    if (index >= 0) {
      smsTemplates[index] = template; // Update
    } else {
      smsTemplates.add(template); // Add new
    }
  }

  void deleteTemplate(String id) {
    smsTemplates.removeWhere((t) => t.id == id);
  }
}

// SMS Template Model
class SmsTemplateModel {
  final String id;
  final String name;
  final String applyTo;
  final String message;
  bool isDefault;

  SmsTemplateModel({
    required this.id,
    required this.name,
    required this.applyTo,
    required this.message,
    this.isDefault = false,
  });
}

// SMS Templates List Screen
class SmsTemplatesView extends StatelessWidget {
  final SmsTemplatesController controller = Get.put(SmsTemplatesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(title: "SMS Templates",hideLogo: true,showBackButton: true,actions: [
        IconButton(
          onPressed: () => Get.to(() => AddOrEditSmsTemplatesView()),
            icon: Icon(Icons.add,color: AppColors.whiteColor,))
      ],),

      body: Obx(() => ListView.builder(
        itemCount: controller.smsTemplates.length,
        padding: EdgeInsets.all(10),
        itemBuilder: (context, index) {
          var template = controller.smsTemplates[index];
          return Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: ListTile(
              tileColor: AppStorages.appColor.value.withOpacity(0.1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              title: Text(template.name, style: AppTextStyles.bold(fontSize: 16.0, fontColor: AppColors.blackColor)),
              subtitle: Text(template.applyTo, style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.darkGrey)),
              trailing:  Icon(Icons.star, color: Colors.amber),
              onTap: () => Get.to(() => AddOrEditSmsTemplatesView(template: template)),
            ),
          );
        },
      )),
    );
  }
}

// Add/Edit SMS Template Screen
class AddOrEditSmsTemplatesView extends StatelessWidget {
  final SmsTemplatesController controller = Get.find();
  final SmsTemplateModel? template;

  AddOrEditSmsTemplatesView({this.template});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final RxString selectedApplyTo = "Quote".obs;
  final RxBool isDefault = false.obs;

  final List<String> applyToOptions = [
    "Quote", "Sales Order", "Cash Sale", "Invoice", "Payment", "Statement", "Purchase Order"
  ];

  @override
  Widget build(BuildContext context) {
    if (template != null) {
      nameController.text = template!.name;
      messageController.text = template!.message;
      selectedApplyTo.value = template!.applyTo;
      isDefault.value = template!.isDefault;
    }

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(title: "SMS Template",hideLogo: true,showBackButton: true,actions: [
        IconButton(onPressed: (){
          var newTemplate = SmsTemplateModel(
            id: template?.id ?? DateTime.now().toString(),
            name: nameController.text,
            applyTo: selectedApplyTo.value,
            message: messageController.text,
            isDefault: isDefault.value,
          );
          controller.addOrUpdateTemplate(newTemplate);
          Get.back();
        }, icon: Icon(Icons.save,color: AppColors.whiteColor,))
      ],),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTextFieldWithTitle(
                label: "Template Name",
                controller: nameController,
              ),
              SizedBox(height: 10),
              Obx(() => Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: DropdownButtonFormField<String>(
                  value: selectedApplyTo.value,
                  items: applyToOptions
                      .map((option) => DropdownMenuItem(
                    value: option,
                    child: Text(
                      option,
                      style: AppTextStyles.regular(
                          fontSize: 16.0, fontColor: AppColors.blackColor),
                    ),
                  ))
                      .toList(),
                  onChanged: (value) => selectedApplyTo.value = value!,
                  decoration: InputDecoration(
                    labelText: "Apply To",
                    labelStyle:
                    AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.darkGrey),
                    contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // ✅ Rounded Borders
                      borderSide: BorderSide(color: AppStorages.appColor.value, width: 1.2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0), // ✅ Rounded Borders
                      borderSide: BorderSide(color: AppStorages.appColor.value, width: 1.5),
                    ),
                  ),
                  dropdownColor: Colors.white, // ✅ Dropdown background color
                  alignment: Alignment.bottomLeft, // ✅ Opens below
                ),
              )),

              SizedBox(height: 10),
              Obx(() => CheckboxListTile(
                title: Text("Use as default?"),
                value: isDefault.value,
                onChanged: (value) => isDefault.value = value!,
              )),
              SizedBox(height: 10),
              CommonTextFieldWithTitle(
                label: "SMS Message",
                controller: messageController,
              ),
              SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}