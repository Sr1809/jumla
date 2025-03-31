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
      CompanyField(
        id: "1",
        name: "Customer Code",
        code: "CUSTC01",
        inputType: "Text",
        isActive: true,
        applyToOptions: {
          "Vendor": false,
          "Customer": true,

        },
      ),
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
}

class CompanyField {
  final String id;
  RxString name;
  RxString code;
  RxString inputType;
  RxString defaultValue;
  RxBool isActive;
  Map<String, RxBool> applyToOptions;

  CompanyField({
    required this.id,
    required String name,
    required String code,
    required String inputType,
    String defaultValue = "",
    required bool isActive,
    required Map<String, bool> applyToOptions,
  })  : name = name.obs,
        code = code.obs,
        inputType = inputType.obs,
        defaultValue = defaultValue.obs,
        isActive = isActive.obs,
        applyToOptions = applyToOptions.map((key, value) => MapEntry(key, value.obs));
}

class CustomerFieldsListView extends StatelessWidget {
  final ProjectFieldController controller = Get.put(ProjectFieldController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Customer Fields",
        hideLogo: true,
        showBackButton: true,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.filter_list, color: AppColors.whiteColor),
            onSelected: (value) {
              controller.selectedFilter.value = value;
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
      body: Obx(() => ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: controller.fields.length,
        itemBuilder: (context, index) {
          var field = controller.fields[index];
          var appliedTo = field.applyToOptions.entries.where((entry) => entry.value.value).map((e) => e.key).join(", ");
          return GestureDetector(
              onLongPress: () => _showFieldOptions(context, field),
              onTap: () => Get.to(() => CompanyFieldFormView(field: field)),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0), // ✅ Better padding for readability
                  child: Obx(()=>Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ✅ Title
                      Text(
                        field.name.value,
                        style: AppTextStyles.bold(fontSize: 16.0, fontColor: AppColors.blackColor),
                      ),

                      // ✅ Subtitle with Code & Input Type
                      SizedBox(height: 4), // ✅ Adds small spacing
                      Text(
                        field.code.value,
                        style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.darkGrey),
                      ),
                      Text(
                        "Input Type: ${field.inputType.value}",
                        style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.darkGrey),
                      ),

                      // ✅ Applied Tags (Checkboxes)
                      if (appliedTo.isNotEmpty) ...[
                        SizedBox(height: 6), // ✅ Small spacing before tags
                        Wrap(
                          spacing: 6.0, // ✅ Spacing between tags
                          runSpacing: 4.0, // ✅ Allows tags to wrap properly
                          children: appliedTo.split(",").map((tag) {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppStorages.appColor.value,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                tag.trim(), // ✅ Trim spaces to avoid UI issues
                                style: TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
                  ),
                ),
              ));

        },
      )),
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
              field.isActive.value ? "Do not apply to transaction" : "Apply to transaction",
              field.isActive.value ? Icons.block : Icons.check_circle,
                  () => _toggleFieldApplication(field),
            ),
            _buildOption("Inactivate", Icons.cancel, () => _inactivateField(field)),
          ],
        ),
      ),
    );
  }

  void _toggleFieldApplication(CompanyField field) {
    field.isActive.value = !field.isActive.value;
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
}
Widget _buildOption(String text, IconData icon, VoidCallback onTap) {
  return ListTile(
    leading: Icon(icon, color: AppStorages.appColor.value),
    title: Text(text, style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor)),
    onTap: onTap,
  );
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

    // ✅ Initialize applyToOptions
    RxMap<String, RxBool> applyToOptions = {
      "Customer": false.obs,
      "Vendor": false.obs,

    }.obs;

    // ✅ Preload selected options if editing
    if (field != null) {
      for (var key in field!.applyToOptions.keys) {
        if (applyToOptions.containsKey(key)) {
          applyToOptions[key]!.value = field!.applyToOptions[key]!.value;
        }
      }
    }

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: field == null ? "Add Custom Field" : "Edit Custom Field",
        hideLogo: true,
        showBackButton: true,
        actions: [
          IconButton(
            onPressed: () {
              // ✅ Collect selected checkboxes
              Map<String, bool> selectedApplyTo = applyToOptions.map(
                    (key, value) => MapEntry(key, value.value),
              );

              if (field == null) {
                // ✅ Add new field
                controller.addField(CompanyField(
                  id: DateTime.now().toString(),
                  name: nameController.text,
                  code: codeController.text,
                  inputType: selectedInputType.value,
                  defaultValue: defaultValueController.text,
                  isActive: true,
                  applyToOptions: selectedApplyTo, // ✅ Fixed field property
                ));
              } else {
                // ✅ Update existing field
                field!.name.value = nameController.text;
                field!.code.value = codeController.text;
                field!.inputType.value = selectedInputType.value;
                field!.defaultValue.value = defaultValueController.text;
                field!.applyToOptions.forEach((key, value) {
                  if (applyToOptions.containsKey(key)) {
                    field!.applyToOptions[key]!.value = applyToOptions[key]!.value;
                  }
                });
                controller.fields.refresh();
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
              Text("Apply To", style: AppTextStyles.bold(fontSize: 16.0, fontColor: AppColors.blackColor)),
              Obx(() => Column(
                children: applyToOptions.entries.map((entry) {
                  return CheckboxListTile(
                    title: Text(entry.key, style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.blackColor)),
                    value: entry.value.value,
                    dense: true,
                    onChanged: (val) => applyToOptions[entry.key]!.value = val!,
                  );
                }).toList(),
              )),
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


