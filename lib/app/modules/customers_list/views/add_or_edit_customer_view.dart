import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get/get.dart';
import 'package:jumla/app/common/common_button.dart';
import 'package:jumla/app/modules/tools/lists/views/price_levels_view.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../common/common_appbar.dart';
import '../../../common/common_text_field.dart';
import '../../../core/app_storage.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_styles.dart';
import '../../tools/lists/views/item_fields_view.dart';
import '../controllers/customers_list_controller.dart';
import '../model/customer_model.dart';

class AddOrEditCustomerScreen extends StatelessWidget {
  String? title ;

  AddOrEditCustomerScreen({this.title});
  var controller = Get.put(CustomersListController());
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final address1Controller = TextEditingController();
  final address2Controller = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();
  final postcodeController = TextEditingController();
  final termsController = TextEditingController();
  final selectedItems = <CompanyField>[].obs;
  final RxBool isCompany = false.obs;
  final RxBool isPublic = false.obs;
  final RxBool isTaxable = true.obs;
  final RxString selectedTaxCode = "Not Set".obs;
  final RxString priceLevel = "Best Price 0%".obs;

  @override
  Widget build(BuildContext context) {
    final customer = controller.selectedItem.value;
    if (customer != null) {
      nameController.text = customer.name.value;
      emailController.text = customer.email.value;
      phoneController.text = customer.phone.value;
      address1Controller.text = customer.address1.value;
      address2Controller.text = customer.address2.value;
      cityController.text = customer.city.value;
      stateController.text = customer.state.value;
      countryController.text = customer.country.value;
      postcodeController.text = customer.postcode.value;
      selectedTaxCode.value = customer.taxCode.value;
      termsController.text = customer.terms.value;
      priceLevel.value = customer.priceLevel.value;
      isCompany.value = customer.isCompany.value;
      isPublic.value = customer.isPublic.value;
      isTaxable.value = customer.isTaxable.value;
    }

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: title != null? title! :customer == null ? "New Customer" : "Edit Customer",
        hideLogo: true,
        showBackButton: true,
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: Colors.white),
            onPressed: () {
              final newCustomer = Customer(
                id: customer?.id,
                name: nameController.text,
                email: emailController.text,
                phone: phoneController.text,
                address1: address1Controller.text,
                address2: address2Controller.text,
                city: cityController.text,
                state: stateController.text,
                country: countryController.text,
                postcode: postcodeController.text,
                taxCode: selectedTaxCode.value,
                terms: termsController.text,
                priceLevel: priceLevel.value,
                isCompany: isCompany.value,
                isPublic: isPublic.value,
                isTaxable: isTaxable.value,
              );
              controller.addOrUpdateCustomer(newCustomer);
              Get.back();
            },
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: CommonElevatedButton(
                text: "Link to phone contact",
                onPressed: () async {
                  // Request permission
                  if (await Permission.contacts.request().isGranted) {
                    final contacts =
                        await FlutterContacts.getContacts(withProperties: true);

                    final selected = await showDialog<Contact>(
                      context: context,
                      builder: (context) => SimpleDialog(
                        title: Text('Select a contact'),
                        children: contacts
                            .where((c) => c.phones.isNotEmpty)
                            .map((contact) => SimpleDialogOption(
                                  onPressed: () =>
                                      Navigator.pop(context, contact),
                                  child: Text(
                                      '${contact.displayName} (${contact.phones.first.normalizedNumber})'),
                                ))
                            .toList(),
                      ),
                    );

                    if (selected != null) {
                      // Autofill the selected name and number
                      nameController.text = selected.displayName;
                      phoneController.text =
                          selected.phones.first.normalizedNumber ?? '';
                    }
                  } else {
                    // Permission denied
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Contacts permission denied'),
                    ));
                  }
                }),
          ),
          CommonTextFieldWithTitle(label: "Name", controller: nameController),
          Obx(() => Row(
                children: [
                  Checkbox(
                      value: isCompany.value,
                      onChanged: (val) => isCompany.value = val!),
                  Text("Is Company"),
                  SizedBox(width: 16),
                  Checkbox(
                      value: isPublic.value,
                      onChanged: (val) => isPublic.value = val!),
                  Text("Is Public")
                ],
              )),
          CommonTextFieldWithTitle(
              label: "Email",
              controller: emailController,
              hint: "email@company.com"),
          CommonTextFieldWithTitle(
              label: "Phone",
              controller: phoneController,
              hint: "Phone number"),
          CommonTextFieldWithTitle(
              label: "Address 1", controller: address1Controller),
          CommonTextFieldWithTitle(
              label: "Address 2", controller: address2Controller),
          Row(
            children: [
              Expanded(
                  child: CommonTextFieldWithTitle(
                      label: "City", controller: cityController)),
              SizedBox(width: 10),
              Expanded(
                  child: CommonTextFieldWithTitle(
                      label: "State", controller: stateController)),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: CommonTextFieldWithTitle(
                      label: "Country", controller: countryController)),
              SizedBox(width: 10),
              Expanded(
                  child: CommonTextFieldWithTitle(
                      label: "Post code", controller: postcodeController)),
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(8),
            color: AppStorages.appColor.value,
            child: Text("Financial Setup > Customer",
                style: AppTextStyles.bold(
                    fontColor: AppColors.whiteColor, fontSize: 13.0)),
          ),
          Row(
            children: [
              Expanded(
                  child: InkWell(
                      onTap: () {
                        showTaxCodeDialog(
                          context: context,
                          taxCodes: ["Rrr", "Trgtg", "Tax"],
                          // Replace with your dynamic list
                          selectedTaxCode: selectedTaxCode, // Your RxString
                        );
                      },
                      child: AbsorbPointer(
                          child: Obx(() => CommonTextFieldWithTitle(
                              label: "Tax Code",
                              controller: TextEditingController(
                                  text: selectedTaxCode.value)))))),
              SizedBox(width: 10),
              Obx(() => Checkbox(
                  value: isTaxable.value,
                  onChanged: (val) => isTaxable.value = val!)),
              Text("Taxable?")
            ],
          ),
          CommonTextFieldWithTitle(label: "Terms", controller: termsController),
          InkWell(
              onTap: () {
                Get.to(() => PriceLevelListView("customer"))!.then((v) {
                  if (v != null) {
                    priceLevel.value = v;
                  }
                });
              },
              child: AbsorbPointer(
                  child: Obx(() => CommonTextFieldWithTitle(
                        label: "Price Level",
                        controller:
                            TextEditingController(text: priceLevel.value),
                        hint: "Base Price 0%",
                      )))),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppStorages.appColor.value,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("CUSTOM FIELDS",
                    style: AppTextStyles.bold(
                        fontColor: AppColors.whiteColor, fontSize: 16.0)),
                GestureDetector(
                  onTap: () {
                    Get.to(() => ItemFieldListView("item"))!.then((v) {
                      if (v != null) {
                        selectedItems.value = v;
                      }
                    });
                  },
                  child: Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      color: Colors.white,
                      child: Text("Add / Edit")),
                )
              ],
            ),
          ),
          Obx(() => ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(10),
                shrinkWrap: true,
                itemCount: selectedItems.length,
                itemBuilder: (context, index) {
                  var field = selectedItems[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 1,
                    child: Obx(() => ListTile(
                          dense: true,
                      tileColor: AppStorages.appColor.value.withOpacity(0.1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          title: Text(
                            field.name.value,
                            style: AppTextStyles.bold(
                                fontSize: 16.0,
                                fontColor: !field.isActive.value
                                    ? Colors.red
                                    : AppColors.blackColor),
                          ),
                          subtitle: Text(
                            field.code.value,
                            style: AppTextStyles.regular(
                                fontSize: 14.0, fontColor: AppColors.darkGrey),
                          ),

                        )),
                  );
                },
              )),
        ],
      ),
    );
  }

  Future<void> showTaxCodeDialog({
    required BuildContext context,
    required List<String> taxCodes,
    required RxString selectedTaxCode,
  }) async {
    String? tempSelection = selectedTaxCode.value;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select a tax code"),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: taxCodes.length,
              itemBuilder: (context, index) {
                final code = taxCodes[index];
                return RadioListTile<String>(
                  title: Text(code),
                  value: code,
                  groupValue: tempSelection,
                  onChanged: (value) {
                    tempSelection = value!;
                    selectedTaxCode.value = value;
                    Get.back();
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                selectedTaxCode.value = "Not Set";
                Get.back();
              },
              child: Text("Not Set"),
            ),
          ],
        );
      },
    );
  }
}
