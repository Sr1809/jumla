import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/common_appbar.dart';
import '../../../../../resources/app_colors.dart';
import '../../../../../resources/app_styles.dart';
import '../../../../../core/app_storage.dart';

class DefaultStatusController extends GetxController {
  var selectedQuoteStatus = "Proposal".obs;
  var selectedSalesOrderStatus = "Pending Billing".obs;
}

class DefaultStatusScreen extends StatelessWidget {
  final DefaultStatusController controller = Get.put(DefaultStatusController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    double textSize = isTablet ? 30.0 : 18.0;
    double paddingSize = isTablet ? 40.0 : 20.0;
    double containerWidth = screenWidth;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Default Status",
        showBackButton: true,
        hideLogo: true,
      ),
      body: Center(
        child: Container(
          width: containerWidth,
          padding: EdgeInsets.all(paddingSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatusItem(
                "Quote Status",
                "Set the default status when adding new quotes",
                controller.selectedQuoteStatus,
                    () => _showStatusDialog(context, controller.selectedQuoteStatus, [
                  "Closed Lost",
                  "Proposal",
                  "In Negotiation",
                  "Purchasing",
                  "Closed Won"
                ], "Choose a quote status"),
              ),
              _buildStatusItem(
                "Sales Order Status",
                "Set the default status when adding new orders",
                controller.selectedSalesOrderStatus,
                    () => _showStatusDialog(context, controller.selectedSalesOrderStatus, [
                  "Cancelled",
                  "Pending Billing"
                ], "Choose a sales order status"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusItem(String title, String subtitle, RxString selectedValue, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Obx(() => Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.bold(fontSize: 20.0, fontColor: Colors.black)),
            SizedBox(height: 5),
            Text(subtitle, style: AppTextStyles.regular(fontSize: 16.0, fontColor: Colors.grey)),
            SizedBox(height: 5),
            Text("> ${selectedValue.value}", style: AppTextStyles.bold(fontSize: 18.0, fontColor: AppStorages.appColor.value)),
          ],
        ),
      )),
    );
  }

  void _showStatusDialog(BuildContext context, RxString selectedValue, List<String> options, String title) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title, style: AppTextStyles.bold(fontSize: 22.0, fontColor: AppStorages.appColor.value)),
          backgroundColor: AppColors.whiteColor,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: options.map((option) {
              return Obx(() => RadioListTile<String>(
                title: Text(option, style: AppTextStyles.regular(fontSize: 18.0, fontColor: Colors.black)),
                value: option,
                groupValue: selectedValue.value,
                onChanged: (value) {
                  if (value != null) {
                    selectedValue.value = value;
                    Get.back();
                  }
                },
              ));
            }).toList(),
          ),
        );
      },
    );
  }
}
