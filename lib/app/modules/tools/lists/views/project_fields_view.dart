import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:jumla/app/common/common_appbar.dart';
import 'package:jumla/app/core/app_storage.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:jumla/app/resources/app_styles.dart';
import '../../../../common/common_text_field.dart';


class ProjectFieldController extends GetxController {
  var fields = <CompanyField>[].obs;
  var inputTypes = [
    "Text", "Long text", "Number", "Decimal", "Currency",
    "Checkbox", "Date", "Time", "Email", "Phone no", "Barcode", "URL"
  ];
  var filteredFields = <CompanyField>[].obs;
  var selectedFilter = 'Show all'.obs;
  @override
  void onInit() {
    super.onInit();
    _loadDummyData();
  }

  void _loadDummyData() {
    fields.addAll([
      CompanyField(id: "1", name: "Customer Code", code: "CUSTC01", inputType: "Text", isActive: true, isAppliedToCompany: false),
      CompanyField(id: "2", name: "Customer Category", code: "CUSTC02", inputType: "Number", isActive: true, isAppliedToCompany: true),
    ]);
  }

  void addField(CompanyField field) {
    fields.add(field);
  }

  void updateField(CompanyField field) {
    int index = fields.indexWhere((f) => f.id == field.id);
    if (index != -1) {
      fields[index] = field;
      update();
    }
  }

  void removeField(CompanyField field) {
    fields.remove(field);
  }

  void applyFilter() {
    if (selectedFilter.value == 'Show all') {
      filteredFields.assignAll(fields);
    } else if (selectedFilter.value == 'Show activated') {
      filteredFields.assignAll(fields.where((f) => f.isActive.value));
    } else if (selectedFilter.value == 'Show inactivated') {
      filteredFields.assignAll(fields.where((f) => !f.isActive.value));
    }
  }
}
class CompanyField {
  final String id;
  RxString name;
  RxString code;
  RxString inputType;
  RxString defaultValue;
  RxBool isActive;
  RxBool isAppliedToCompany; // ✅ New Variable for Apply to Company

  CompanyField({
    required this.id,
    required String name,
    required String code,
    required String inputType,
    String defaultValue = "",
    required bool isActive,
    required bool isAppliedToCompany, // ✅ Initialize variable
  })  : name = name.obs,
        code = code.obs,
        inputType = inputType.obs,
        defaultValue = defaultValue.obs,
        isActive = isActive.obs,
        isAppliedToCompany = isAppliedToCompany.obs; // ✅ Observable state
}




class ProjectFieldListView extends StatelessWidget {
  final ProjectFieldController controller = Get.put(ProjectFieldController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Project Fields",
        hideLogo: true,
        showBackButton: true,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.filter_list, color: AppColors.whiteColor),
            onSelected: (value) {
              controller.selectedFilter.value = value;
              controller.applyFilter();
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'Show all', child: Text("Show all")),
              PopupMenuItem(value: 'Show activated', child: Text("Show activated")),
              PopupMenuItem(value: 'Show inactivated', child: Text("Show inactivated")),
            ],
          ),
          IconButton(
            icon: Icon(Icons.add, color: AppColors.whiteColor),
            onPressed: () => Get.to(() => CompanyFieldFormView()),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            width: Get.width,
            color: AppColors.blackColor,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: Text(
                "To see more options, long-hold on one line.",
                style: AppTextStyles.regular(fontSize: 13.0, fontColor: AppColors.whiteColor),
              ),
            ),
          ),
          Obx(() => Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: controller.fields.length,
              itemBuilder: (context, index) {
                var field = controller.fields[index];
                return GestureDetector(
                  onLongPress: () => _showFieldOptions(context, field),
                  onTap: () {
                    Get.to(() => CompanyFieldFormView(field: field));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 1,
                    child: Obx(() => ListTile(
                      tileColor: AppStorages.appColor.value.withOpacity(0.1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      dense: true,
                      title: Text(
                        field.name.value,
                        style: AppTextStyles.bold(fontSize: 16.0, fontColor:!field.isActive.value?Colors.red: AppColors.blackColor),
                      ),
                      subtitle: Text(
                        field.code.value,
                        style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.darkGrey),
                      ),
                      // ✅ Show "Company" if `isAppliedToCompany` is TRUE
                      trailing: Text(
                        field.isAppliedToCompany.value ? "Project" : "",
                        style: AppTextStyles.regular(
                          fontSize: 14.0,
                          fontColor: AppColors.blackColor,
                        ),
                      ),
                    )),
                  ),
                );
              },
            ),
          )),
        ],
      ),
    );
  }

  void _showFieldOptions(BuildContext context, CompanyField field) {
    Get.bottomSheet(
      Container(
        color: AppColors.whiteColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildOption("Edit", Icons.edit, () => Get.to(() => CompanyFieldFormView(field: field))),
            _buildOption("Move up", Icons.arrow_upward, () => _moveFieldUp(field)),
            _buildOption("Move down", Icons.arrow_downward, () => _moveFieldDown(field)),
            _buildOption(
              field.isAppliedToCompany.value ? "Do not apply to company" : "Apply to company",
              field.isAppliedToCompany.value ? Icons.block : Icons.check_circle,
                  () => _toggleFieldApplication(field),
            ),
            _buildOption("Inactivate", Icons.cancel, () => _inactivateField(field)),
          ],
        ),
      ),
    );
  }

  void _toggleFieldApplication(CompanyField field) {
    field.isAppliedToCompany.value = !field.isAppliedToCompany.value;
    controller.fields.refresh();
    Get.back();
  }

  void _moveFieldUp(CompanyField field) {
    int index = controller.fields.indexOf(field);
    if (index > 0) {
      var temp = controller.fields[index];
      controller.fields[index] = controller.fields[index - 1];
      controller.fields[index - 1] = temp;
      controller.fields.refresh();
    }
    Get.back();
  }

  void _moveFieldDown(CompanyField field) {
    int index = controller.fields.indexOf(field);
    if (index < controller.fields.length - 1) {
      var temp = controller.fields[index];
      controller.fields[index] = controller.fields[index + 1];
      controller.fields[index + 1] = temp;
      controller.fields.refresh();
    }
    Get.back();
  }

  void _inactivateField(CompanyField field) {
    field.isActive.value = false;
    controller.fields.refresh();
    Get.back();
  }

  Widget _buildOption(String text, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppStorages.appColor.value),
      title: Text(text, style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor)),
      onTap: onTap,
    );
  }
}




class CompanyFieldFormView extends StatelessWidget {
  final ProjectFieldController controller = Get.find();
  final CompanyField? field;

  CompanyFieldFormView({this.field});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController(text: field?.name.value ?? "");
    TextEditingController codeController = TextEditingController(text: field?.code.value ?? "");
    RxString selectedInputType = field?.inputType ?? "Text".obs;
    TextEditingController defaultValueController = TextEditingController(text: field?.defaultValue.value ?? "");
    RxBool isAppliedToCompany = field?.isAppliedToCompany ?? false.obs; // ✅ New checkbox state

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: field == null ? "Add Custom Field" : "Edit Custom Field",
        hideLogo: true,
        showBackButton: true,
        actions: [
          IconButton(
            onPressed: () {
              if (field == null) {
                controller.addField(CompanyField(
                  id: DateTime.now().toString(),
                  name: nameController.text,
                  code: codeController.text,
                  inputType: selectedInputType.value,
                  isActive: true,
                  isAppliedToCompany: isAppliedToCompany.value,
                ));
              } else {
                field!.name.value = nameController.text;
                field!.code.value = codeController.text;
                field!.inputType.value = selectedInputType.value;
                field!.defaultValue.value = defaultValueController.text;
                field!.isAppliedToCompany.value = isAppliedToCompany.value;
                controller.update();
              }
              Get.back();
            },
            icon: Icon(Icons.save, color: AppColors.whiteColor),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // ✅ Checkbox for "Apply to Company"
              Obx(() => CheckboxListTile(
                title: Text(
                  "Apply to Project",
                  style: AppTextStyles.bold(fontSize: 16.0, fontColor: AppColors.blackColor),
                ),
                value: isAppliedToCompany.value,
                activeColor: AppStorages.appColor.value,
                onChanged: (bool? value) {
                  isAppliedToCompany.value = value!;
                },
              )),
              SizedBox(height: 20),
              CommonTextFieldWithTitle(label: "Name", controller: nameController),
              CommonTextFieldWithTitle(label: "Code", controller: codeController),

              // ✅ Dropdown for Input Type
              Obx(() => ListTile(
                title: Text(
                  "Input Type",
                  style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor),
                ),
                subtitle: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                  margin: EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: AppStorages.appColor.value, width: 1),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedInputType.value,
                      isExpanded: true,
                      dropdownColor: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                      icon: Icon(Icons.arrow_drop_down, color: AppStorages.appColor.value),
                      style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor),
                      onChanged: (newValue) {
                        selectedInputType.value = newValue!;
                      },
                      items: controller.inputTypes.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              )),

              // ✅ Default Value Field
              CommonTextFieldWithTitle(label: "Default Value (Optional)", controller: defaultValueController),
            ],
          ),
        ),
      ),
    );
  }
}

