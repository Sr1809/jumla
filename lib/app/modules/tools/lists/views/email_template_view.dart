import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:jumla/app/resources/app_styles.dart';
import '../../../../common/common_appbar.dart';
import '../../../../common/common_text_field.dart';
import '../../../../core/app_storage.dart';
// Email Template Model
class EmailTemplateModel {
  final String id;
  final String name;
  final String applyTo;
  final String emailTitle;
  final String emailCC;
  final String emailBCC;
  final String emailBody;
  bool sendAsHtml;
  bool isDefault;

  EmailTemplateModel({
    required this.id,
    required this.name,
    required this.applyTo,
    required this.emailTitle,
    required this.emailCC,
    required this.emailBCC,
    required this.emailBody,
    this.sendAsHtml = false,
    this.isDefault = false,
  });
}

// Controller for Email Templates
class EmailTemplatesController extends GetxController {
  var emailTemplates = <EmailTemplateModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDummyData();
  }

  void _loadDummyData() {
    emailTemplates.addAll([
      EmailTemplateModel(
        id: "1",
        name: "Cash Sale Emails",
        applyTo: "Cash Sale",
        emailTitle: "Thank you for your purchase!",
        emailCC: "test12@yopmail.com",
        emailBCC: "test12@yopmail.com",
        emailBody: "Thank you for your cash purchase!",
        sendAsHtml: false,
        isDefault: true,
      ),
      EmailTemplateModel(
        id: "2",
        name: "Statement Emails",
        applyTo: "Statement",
        emailTitle: "Monthly Statement",
        emailCC: "test12@yopmail.com",
        emailBCC: "test12@yopmail.com",
        emailBody: "Your monthly statement is attached.",
        sendAsHtml: true,
        isDefault: false,
      ),
    ]);
  }

  void addOrUpdateTemplate(EmailTemplateModel template) {
    int index = emailTemplates.indexWhere((t) => t.id == template.id);
    if (index >= 0) {
      emailTemplates[index] = template; // Update
    } else {
      emailTemplates.add(template); // Add new
    }
  }

  void deleteTemplate(String id) {
    emailTemplates.removeWhere((t) => t.id == id);
  }
}





class EmailTemplatesView extends StatelessWidget {
  final EmailTemplatesController controller = Get.put(EmailTemplatesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Email Templates",
        hideLogo: true,
        showBackButton: true,
        actions: [
          IconButton(
            onPressed: () => Get.to(() => AddOrEditEmailTemplateView()),
            icon: Icon(Icons.add, color: AppColors.whiteColor),
          )
        ],
      ),
      body: Obx(() => ListView.separated(
        itemCount: controller.emailTemplates.length,
        padding: EdgeInsets.all(10),
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          var template = controller.emailTemplates[index];
          return ListTile(
            title: Text(template.name, style: AppTextStyles.bold(fontSize: 16.0, fontColor: AppColors.blackColor)),
            subtitle: Text(template.applyTo, style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.darkGrey)),
            trailing: Icon(Icons.star, color: template.isDefault ? Colors.amber : AppColors.darkGrey),
            onTap: () => Get.to(() => AddOrEditEmailTemplateView(template: template)),
          );
        },
      )),
    );
  }
}




class AddOrEditEmailTemplateView extends StatelessWidget {
  final EmailTemplatesController controller = Get.find();
  final EmailTemplateModel? template;

  AddOrEditEmailTemplateView({this.template});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailTitleController = TextEditingController();
  final TextEditingController emailCCController = TextEditingController();
  final TextEditingController emailBCCController = TextEditingController();
  final TextEditingController emailBodyController = TextEditingController();
  final TextEditingController fileNameController = TextEditingController();

  final RxString selectedApplyTo = "Quote".obs;
  final RxBool isDefault = false.obs;
  final RxBool sendAsHtml = false.obs;
  final RxBool useFile = false.obs;

  final List<String> applyToOptions = [
    "Quote", "Sales Order", "Cash Sale", "Invoice", "Payment", "Statement", "Purchase Order"
  ];

  @override
  Widget build(BuildContext context) {
    if (template != null) {
      nameController.text = template!.name;
      emailTitleController.text = template!.emailTitle;
      emailCCController.text = template!.emailCC;
      emailBCCController.text = template!.emailBCC;
      emailBodyController.text = template!.emailBody;
      selectedApplyTo.value = template!.applyTo;
      isDefault.value = template!.isDefault;
      sendAsHtml.value = template!.sendAsHtml;
    }

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Email Template",
        hideLogo: true,
        showBackButton: true,
        actions: [
          IconButton(
            onPressed: () {
              var newTemplate = EmailTemplateModel(
                id: template?.id ?? DateTime.now().toString(),
                name: nameController.text,
                applyTo: selectedApplyTo.value,
                emailTitle: emailTitleController.text,
                emailCC: emailCCController.text,
                emailBCC: emailBCCController.text,
                emailBody: emailBodyController.text,
                sendAsHtml: sendAsHtml.value,
                isDefault: isDefault.value,
              );
              controller.addOrUpdateTemplate(newTemplate);
              Get.back();
            },
            icon: Icon(Icons.save, color: AppColors.whiteColor),
          )
        ],
      ),
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
                    child: Text(option, style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor)),
                  ))
                      .toList(),
                  onChanged: (value) => selectedApplyTo.value = value!,
                  decoration: InputDecoration(
                    labelText: "Apply To",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
                  ),
                  dropdownColor: Colors.white,
                  alignment: Alignment.bottomLeft,
                ),
              )),
              SizedBox(height: 10),
              Obx(() => CheckboxListTile(
                title: Text("Use as default?"),
                value: isDefault.value,
                onChanged: (value) => isDefault.value = value!,
                activeColor: AppStorages.appColor.value,
              )),
              SizedBox(height: 10),
              CommonTextFieldWithTitle(
                label: "Email Title",
                controller: emailTitleController,
              ),
              CommonTextFieldWithTitle(
                label: "Email CC",
                controller: emailCCController,
              ),
              CommonTextFieldWithTitle(
                label: "Email BCC",
                controller: emailBCCController,
              ),
              Obx(() => CheckboxListTile(
                title: Text("Send email as HTML"),
                value: sendAsHtml.value,
                onChanged: (value) => sendAsHtml.value = value!,
                activeColor: AppStorages.appColor.value,
              )),
              SizedBox(height: 10),
              CommonTextFieldWithTitle(
                label: "Email Body",
                controller: emailBodyController,
              ),
              SizedBox(height: 20),

              Divider(height: 30, thickness: 1),

              // ✅ Checkbox for File Selection
              Obx(() => CheckboxListTile(
                title: Text("Create from file"),
                value: useFile.value,
                onChanged: (value) => useFile.value = value!,
                activeColor: AppStorages.appColor.value,
              )),

              // ✅ File Name Input Field (Only show when checkbox is checked)
              Obx(() => useFile.value
                  ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CommonTextFieldWithTitle(
                  label: "Enter filename (e.g. invoice-email.txt)",
                  controller: fileNameController,
                ),
              )
                  : SizedBox.shrink()),

              // ✅ Explanatory Text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Text(
                  "Check the box above and enter the filename (e.g. invoice-email.txt). This file should exist in /sdcard/mobilebiz-pro/templates/email folder.",
                  style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.darkGrey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


