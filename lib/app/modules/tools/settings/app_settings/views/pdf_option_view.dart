import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/common/common_button.dart';
import 'package:jumla/app/resources/app_colors.dart';
import '../../../../../common/common_appbar.dart';
import '../../../../../core/app_storage.dart';
import '../../../../../resources/app_styles.dart';

class PdfOptionsController extends GetxController {
  var pageSizeSelections = ["A4", "Letter", "Legal", "Folio", "Executive"];
  var orientationSelections = ["Portrait", "Landscape"];

  RxString selectedPageSizeQuote = "A4".obs;
  RxString selectedPageSizeSalesOrder = "A4".obs;
  RxString selectedPageSizeInvoice = "A4".obs;
  RxString selectedPageSizeCashSale = "A4".obs;
  RxString selectedPageSizePayment = "A4".obs;
  RxString selectedPageSizeStatement = "A4".obs;
  RxString selectedPageSizePurchaseOrder = "A4".obs;

  RxString selectedOrientationQuote = "Portrait".obs;
  RxString selectedOrientationSalesOrder = "Portrait".obs;
  RxString selectedOrientationInvoice = "Portrait".obs;
  RxString selectedOrientationCashSale = "Portrait".obs;
  RxString selectedOrientationPayment = "Portrait".obs;
  RxString selectedOrientationStatement = "Portrait".obs;
  RxString selectedOrientationPurchaseOrder = "Portrait".obs;

  RxBool isPdfPrintRestricted = false.obs;
}

class PdfOptionsScreen extends StatelessWidget {
  final PdfOptionsController controller = Get.put(PdfOptionsController());

  @override
  Widget build(BuildContext context) {
    double paddingSize = MediaQuery.of(context).size.width > 600 ? 40.0 : 20.0;
    double titleFontSize = MediaQuery.of(context).size.width > 600 ? 25.0 : 16.0;
    double checkboxSize = MediaQuery.of(context).size.width > 600 ? 40 : 24;
    double checkboxIconSize = MediaQuery.of(context).size.width > 600 ? 30 : 20;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "PDF Options",
        showBackButton: true,
        hideLogo: true,
      ),
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
            mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTableHeader(),
                _buildTableRow("Quote", controller.selectedPageSizeQuote, controller.selectedOrientationQuote),
                _buildTableRow("Sales Order", controller.selectedPageSizeSalesOrder, controller.selectedOrientationSalesOrder),
                _buildTableRow("Invoice", controller.selectedPageSizeInvoice, controller.selectedOrientationInvoice),
                _buildTableRow("Cash Sale", controller.selectedPageSizeCashSale, controller.selectedOrientationCashSale),
                _buildTableRow("Payment", controller.selectedPageSizePayment, controller.selectedOrientationPayment),
                _buildTableRow("Statement", controller.selectedPageSizeStatement, controller.selectedOrientationStatement),
                _buildTableRow("Purchase Order", controller.selectedPageSizePurchaseOrder, controller.selectedOrientationPurchaseOrder),
                SizedBox(height: 20),
                Obx(() => GestureDetector(
                  onTap: () => controller.isPdfPrintRestricted.value = !controller.isPdfPrintRestricted.value,
                  child: Row(
                    children: [
                      Container(
                        width: checkboxSize,
                        height: checkboxSize,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: controller.isPdfPrintRestricted.value
                            ? Center(
                          child: Icon(Icons.check, color: AppStorages.appColor.value, size: checkboxIconSize),
                        )
                            : null,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "PDF can only be printed (and not copied or edited)",
                        style: AppTextStyles.regular(fontSize: titleFontSize, fontColor: Colors.black),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CommonFullWidthButton(text: "Save", onTap: ()=>Get.back()),
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text("Page Size", style: AppTextStyles.bold(fontSize: 18.0, fontColor: Colors.black)),
          Text("Orientation", style: AppTextStyles.bold(fontSize: 18.0, fontColor: Colors.black)),
        ],
      ),
    );
  }

  Widget _buildTableRow(String title, RxString selectedPageSize, RxString selectedOrientation) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
              width: Get.width/3,
              child: Text(title,style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor),)),
          SizedBox(width: 10,),
          Obx(() => SizedBox(
            width: Get.width/3.33,
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedPageSize.value,
              onChanged: (newValue) {
                selectedPageSize.value = newValue!;
              },
              items: ["A4", "Letter", "Legal", "Folio", "Executive"].map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option, style: AppTextStyles.regular(fontSize: 14.0, fontColor: Colors.black)),
                );
              }).toList(),
            ),
          )),
          SizedBox(width: 10,),
          Obx(() => SizedBox(
            width: Get.width/3.33,
            child: DropdownButton<String>(
              isExpanded: true,
              value: selectedOrientation.value,
              onChanged: (newValue) {
                selectedOrientation.value = newValue!;
              },
              items: ["Portrait", "Landscape"].map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option, style: AppTextStyles.regular(fontSize: 14.0, fontColor: Colors.black)),
                );
              }).toList(),
            ),
          )),
        ],
      ),
    );
  }
}
