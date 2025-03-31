import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/modules/auth/add_company_name_address/views/add_company_name_address_view.dart';
import 'package:jumla/app/resources/app_colors.dart';
import '../../../../../common/common_appbar.dart';
import '../../../../../resources/app_styles.dart';
import '../../../../../core/app_storage.dart';
import '../controllers/app_settings_controller.dart';
import 'company_name_and_address.dart';

class ManageCompaniesScreen extends GetView<AppSettingsController> {
  const ManageCompaniesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    double textSize = isTablet ? 25.0 : 18.0;
    double paddingSize = isTablet ? 40.0 : 20.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "Manage Companies",
        showBackButton: true,
        hideLogo: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: AppColors.whiteColor),
            onPressed: () => Get.to(()=>CompanyInfoView()),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Get.width,
            color: AppColors.blackColor,
            child: Center(
              child: Text(
                "To see more options, long-hold on one line.",
                style: AppTextStyles.regular(fontSize: textSize * 0.8, fontColor: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child:ListView.builder(
                itemCount: 1,
                padding: EdgeInsets.all(20),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: ()=>Get.to(()=>CompanyInfoView()),
                    child: Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),

                      child: ListTile(
                        tileColor: AppStorages.appColor.value.withOpacity(0.1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),

                        title: Text(
                          "test",
                          style: AppTextStyles.bold(fontSize: textSize, fontColor: Colors.black),
                        ),
                      ),
                    ),
                  );
                },

            ),
          ),
        ],
      ),
    );
  }
}
