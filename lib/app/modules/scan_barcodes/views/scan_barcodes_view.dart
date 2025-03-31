import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/common/common_appbar.dart';
import 'package:jumla/app/common/common_button.dart';
import 'package:jumla/app/common/common_text_field.dart';
import 'package:jumla/app/core/app_storage.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import '../../../routes/app_pages.dart';
import '../controllers/scan_barcodes_controller.dart';


class ScanBarcodesView extends GetView<ScanBarcodesController> {
  const ScanBarcodesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Scan barcodes", hideLogo: true,),
      body: Obx(() =>
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CheckboxListTile(
                  title: Text("Use barcodes", style: TextStyle(fontSize: 18)),
                  value: controller.useBarcodes.value,
                  activeColor: AppStorages.appColor.value,
                  onChanged: (value) {
                    controller.useBarcodes.value = value ?? true;
                  },
                ),
                SizedBox(height: 40),
                CommonElevatedButton(text: "SCAN to sale", onPressed: () => Get.toNamed(Routes.INVOICE)),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(child: GestureDetector(
                        onTap: () {
                          _showSaleTypePopup(context);
                        },
                        child: AbsorbPointer(child: CommonTextFieldWithTitle(
                            label: "Invoice", controller: TextEditingController(
                            text: controller.selectedSaleType.value))))),

                    Expanded(child: GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.CUSTOMERS_LIST, arguments: "scan")!
                              .then((v) {
                            if (v != null) {
                              controller.selectedCustomer.value = v;

                            }
                          });
                        },
                        child: AbsorbPointer(child: CommonTextFieldWithTitle(
                            label: "Customer",
                            controller: TextEditingController(
                                text: controller.selectedCustomer.value))))),

                  ],
                ),
                Spacer(),
                CommonElevatedButton(
                    text: "SCAN to inventory", onPressed: () async {
                  String? res = await SimpleBarcodeScanner.scanBarcode(
                    context,
                    barcodeAppBar: const BarcodeAppBar(
                      appBarTitle: 'Test',
                      centerTitle: false,
                      enableBackButton: true,
                      backButtonIcon: Icon(Icons.arrow_back_ios),
                    ),
                    isShowFlashIcon: true,
                    delayMillis: 2000,
                    cameraFace: CameraFace.back,
                  );
                }),

              ],
            ),
          )),
    );
  }


  void _showSaleTypePopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) =>
          SimpleDialog(
            backgroundColor: AppColors.whiteColor,
            title: Text("Select a sale type",
                style: TextStyle(color: AppStorages.appColor.value)),
            children: controller.saleTypes.map((type) =>
                RadioListTile<String>(
                  value: type,
                  groupValue: controller.selectedSaleType.value,
                  onChanged: (value) {
                    controller.selectedSaleType.value = value!;
                    Get.back();
                  },
                  title: Text(type),
                )).toList(),
          ),
    );
  }
}