import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/common/common_appbar.dart';
import 'package:jumla/app/common/common_button.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:jumla/app/resources/app_styles.dart';
import '../../../../common/common_text_field.dart';
import '../../../../core/app_storage.dart';

class PrintTemplatesController extends GetxController {
  var templates = <TemplateModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDummyData();
  }

  void _loadDummyData() {
    templates.addAll([
      TemplateModel(id: "1", name: "MobileBiz Payment Template".obs, company: "MobileBiz Co", applyToTags: ["Quote", "Sales Order"]),
      TemplateModel(id: "2", name: "MobileBiz Sales Template".obs, company: "MobileBiz Co", applyToTags: []),
    ]);
  }

  void addTemplate(TemplateModel template) {
    templates.add(template);
  }

  void updateTemplate(TemplateModel template) {
    int index = templates.indexWhere((t) => t.id == template.id);
    if (index != -1) {
      templates[index] = template;
      update();
    }
  }
}

class TemplateModel {
  final String id;
   RxString name;
   String company;
  RxList<String> applyToTags;

  TemplateModel({required this.id, required this.name, required this.company,    List<String>? applyToTags,
  }): applyToTags = RxList<String>(applyToTags ?? []);
}

class PrintTemplatesView extends StatelessWidget {
  final PrintTemplatesController controller = Get.put(PrintTemplatesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Print Templates",
        hideLogo: true,
        showBackButton: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'upload') {
                _showUploadDialog();
              } else if (value == 'reset') {
                _showResetDialog();
              }
            },
           iconColor: AppColors.whiteColor,
            color: AppColors.whiteColor,
            itemBuilder: (context) => [
              PopupMenuItem(value: 'upload', child: Text("Upload all")),
              PopupMenuItem(value: 'reset', child: Text("Reset")),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            width: Get.width,
            decoration: BoxDecoration(
            color: AppColors.blackColor
          ),
          child: Center(child: Text("To see more options, long-hold on one line.",style: AppTextStyles.regular(fontSize: 13.0, fontColor: AppColors.whiteColor),)),
          ),
          Expanded(
            child:  Obx(()=>ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: controller.templates.length,
              itemBuilder: (context, index) {
                var template = controller.templates[index];
                return GestureDetector(
                  onLongPress: () {
                    _showTemplateMenu(context, template);
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(
                        template.name.value,
                        style: AppTextStyles.bold(fontSize: 16.0, fontColor: AppColors.blackColor),
                      ),
                      subtitle: Text(
                        template.company,
                        style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.darkGrey),
                      ),
                      tileColor: AppStorages.appColor.value.withOpacity(0.1),

                      trailing: template.applyToTags.isNotEmpty
                          ? Wrap(
                        direction: Axis.vertical,
                        spacing: 6.0, // Adds spacing between tags
                        children: template.applyToTags
                            .map((tag) => Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppStorages.appColor.value,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ))
                            .toList(),
                      )
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
          )
        ],
      ),
    );
  }

  void _showUploadDialog() {
    Get.defaultDialog(
      title: "Upload all templates",
      middleText: "This will upload your latest templates to the server.",
titleStyle: AppTextStyles.bold(fontSize: 18.0, fontColor: AppStorages.appColor.value),
      backgroundColor: AppColors.whiteColor,
      buttonColor: AppStorages.appColor.value,
cancel: CommonElevatedButton(text: "Cancel", onPressed: ()=>Get.back(),backgroundColor: AppColors.darkGrey,),
      confirm: CommonElevatedButton(text: "Continue", onPressed: ()=>Get.back()),
    );
  }

  void _showResetDialog() {
    Get.defaultDialog(
      title: "Reload default templates",
      middleText: "This will re-install and overwrite the MobileBiz Sales and Payment Templates.",
      titleStyle: AppTextStyles.bold(fontSize: 18.0, fontColor: AppStorages.appColor.value),
      backgroundColor: AppColors.whiteColor,
      buttonColor: AppStorages.appColor.value,
      cancel: CommonElevatedButton(text: "Cancel", onPressed: ()=>Get.back(),backgroundColor: AppColors.darkGrey,),
      confirm: CommonElevatedButton(text: "Continue", onPressed: ()=>Get.back()),
    );
  }

  void _showTemplateMenu(BuildContext context, TemplateModel template) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
      ),
      backgroundColor: AppColors.whiteColor,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8),
            _buildMenuItem(
              icon: Icons.visibility,
              text: "View",
              onTap: () => Get.back(),
            ),
            _buildMenuItem(
              icon: Icons.assignment_return,
              text: "Apply to",
              onTap: () {
                Get.back();
                _showApplyToDialog(context, template);
              },
            ),
            _buildMenuItem(
              icon: Icons.content_copy,
              text: "Make a copy",
              onTap: () { Get.back();
              showMakeCopyPopup(template);
              }
            ),
            _buildMenuItem(
              icon: Icons.edit,
              text: "Rename",
              onTap: ()  { Get.back();
              showRenamePopup(template);
              }
            ),
            _buildMenuItem(
              icon: Icons.cloud_upload,
              text: "Upload to company",
              onTap: (){ Get.back();
              _showUploadToCompanyDialog(template.name.value);
              }
            ),

            _buildMenuItem(
              icon: Icons.delete_forever,
              text: "Remove from company",
                onTap: (){ Get.back();
                _showRemoveFromCompanyDialog(template.name.value);
                }
            ),
            _buildMenuItem(
              icon: Icons.delete,
              text: "Remove from device",
                onTap: (){ Get.back();
                _showRemoveFromDeviceDialog(template);
                }
            ),

            SizedBox(height: 10),
          ],
        );
      },
    );
  }

  Widget _buildMenuItem({required IconData icon, required String text, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: AppStorages.appColor.value),
      title: Text(
        text,
        style: AppTextStyles.regular(
          fontSize: 16.0,
          fontColor: AppColors.blackColor,
        ),
      ),
      onTap: onTap,
    );
  }
  void _showApplyToDialog(BuildContext context, TemplateModel template) {
    List<String> applyToOptions = [
      "Quote", "Sales Order", "Cash Sale", "Invoice", "Payment", "Purchase Order"
    ];

    RxList<String> selectedOptions = template.applyToTags;

    Get.defaultDialog(
      title: "Apply to sale type",
      titleStyle: AppTextStyles.bold(fontSize: 18.0, fontColor: AppStorages.appColor.value),
      backgroundColor: AppColors.whiteColor,
      content: Obx(() => Column(
        children: applyToOptions.map((option) {
          return CheckboxListTile(
            title: Text(option, style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor)),
            value: selectedOptions.contains(option),
            activeColor: AppStorages.appColor.value,
            onChanged: (bool? value) {
              if (value == true) {
                selectedOptions.add(option);
              } else {
                selectedOptions.remove(option);
              }
            },
          );
        }).toList(),
      )),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CommonElevatedButton(
              text: "Cancel",
              onPressed: () => Get.back(),
              backgroundColor: AppColors.darkGrey,
            ),
            CommonElevatedButton(
              text: "Save",
              onPressed: () {
                template.applyToTags.value = List<String>.from(selectedOptions);
                Get.back();
              },
            ),
          ],
        ),
      ],
    );
  }

  void showMakeCopyPopup(TemplateModel template) {
    TextEditingController nameController =
    TextEditingController(text: "${template.name} Copy");

    Get.defaultDialog(
      title: "Name of copied template",
      titleStyle: AppTextStyles.bold(
          fontSize: 18.0, fontColor: AppStorages.appColor.value),
      backgroundColor: AppColors.whiteColor,
      content: Padding(
        padding: EdgeInsets.all(16.0),
        child: CommonTextFieldWithTitle(
          label: "Template Name",
          controller: nameController,
        ),
      ),
      confirm: CommonElevatedButton(
        text: "Done",
        onPressed: () {
          var copiedTemplate = TemplateModel(
            id: DateTime.now().toString(),
            name: nameController.text.obs,
            company: template.company,
            applyToTags: List.from(template.applyToTags),
          );
          controller.addTemplate(copiedTemplate);
          Get.back();
        },
      ),
      cancel: CommonElevatedButton(
        text: "Cancel",
        onPressed: () => Get.back(),
        backgroundColor: AppColors.darkGrey,
      ),
    );
  }

  void showRenamePopup(TemplateModel template) {
    TextEditingController nameController =
    TextEditingController(text: template.name.value);

    Get.defaultDialog(
      title: "Rename Template",
      titleStyle: AppTextStyles.bold(
          fontSize: 18.0, fontColor: AppStorages.appColor.value),
      backgroundColor: AppColors.whiteColor,
      content: Padding(
        padding: EdgeInsets.all(16.0),
        child: CommonTextFieldWithTitle(
          label: "New Name",
          controller: nameController,
        ),
      ),
      confirm: CommonElevatedButton(
        text: "Rename",
        onPressed: () {
          template.name.value = nameController.text;
          controller.update();
          Get.back();
        },
      ),
      cancel: CommonElevatedButton(
        text: "Cancel",
        onPressed: () => Get.back(),
        backgroundColor: AppColors.darkGrey,
      ),
    );
  }

  void _showUploadToCompanyDialog(String templateName) {
    Get.defaultDialog(
      title: "Upload to company",
      middleText: "This will upload $templateName (including its settings) to your online company.\n\n"
          "Other users can access changes made to this template by going to Home > Menu > Cloud Account > Reset DEVICE Data > Download Files.\n\nContinue?",
      titleStyle: AppTextStyles.bold(fontSize: 18.0, fontColor: AppStorages.appColor.value),
      backgroundColor: AppColors.whiteColor,
      cancel: CommonElevatedButton(
        text: "No",
        onPressed: () => Get.back(),
        backgroundColor: AppColors.darkGrey,
      ),
      confirm: CommonElevatedButton(
        text: "Yes",
        onPressed: () {
          // Call upload function
          Get.back();
        },
      ),
    );
  }

  void _showRemoveFromCompanyDialog(String templateName) {
    Get.defaultDialog(
      title: "Confirmation",
      middleText: "This will remove $templateName (and its settings) from your online company.\n\nAre you sure you want to do this?",
      titleStyle: AppTextStyles.bold(fontSize: 18.0, fontColor: AppStorages.appColor.value),
      backgroundColor: AppColors.whiteColor,
      cancel: CommonElevatedButton(
        text: "No",
        onPressed: () => Get.back(),
        backgroundColor: AppColors.darkGrey,
      ),
      confirm: CommonElevatedButton(
        text: "Yes",
        onPressed: () {
          // Call remove from company function
          Get.back();
        },
      ),
    );
  }

  void _showRemoveFromDeviceDialog(TemplateModel template) {
    Get.defaultDialog(
      title: "Confirmation",
      middleText: "This will uninstall ${template.name.value} on this device.\n\nContinue?",
      titleStyle: AppTextStyles.bold(fontSize: 18.0, fontColor: AppStorages.appColor.value),
      backgroundColor: AppColors.whiteColor,
      cancel: CommonElevatedButton(
        text: "No",
        onPressed: () => Get.back(),
        backgroundColor: AppColors.darkGrey,
      ),
      confirm: CommonElevatedButton(
        text: "Yes",
        onPressed: () {
        controller.templates.remove(template);
          Get.back();
        },
      ),
    );
  }

}
