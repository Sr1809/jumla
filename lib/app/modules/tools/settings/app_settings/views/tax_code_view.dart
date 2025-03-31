import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/common_appbar.dart';
import '../../../../../resources/app_styles.dart';
import '../../../../../core/app_storage.dart';
import '../../../../../routes/app_pages.dart';
import '../controllers/app_settings_controller.dart';

class TaxCodesScreen extends GetView<AppSettingsController> {
  const TaxCodesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    double textSize = isTablet ? 30.0 : 18.0;
    double paddingSize = isTablet ? 40.0 : 20.0;
var controller = Get.put(AppSettingsController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Tax Codes",
        showBackButton: true,
        hideLogo: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () =>Get.toNamed(Routes.ADD_TAX_SETUP,arguments: "setting"),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(paddingSize),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text("${controller.taxCodes.length} records", style: AppTextStyles.regular(fontSize: textSize * 0.7, fontColor: Colors.grey)),
            ),
            Expanded(
              child: Obx(
                    () => ListView.builder(
                  itemCount: controller.taxCodes.length,
                  itemBuilder: (context, index) {
                    final tax = controller.taxCodes[index];
                    return ListTile(
                      title: Text(tax.name, style: AppTextStyles.bold(fontSize: textSize, fontColor: Colors.black)),
                      subtitle: Text("${tax.rate}%", style: AppTextStyles.regular(fontSize: textSize * 0.8, fontColor: Colors.grey)),

                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {},
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}