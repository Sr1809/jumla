import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jumla/app/modules/tools/manage_data/views/restore_database.dart';

import '../../../../common/common_appbar.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_styles.dart';
import '../controllers/manage_data_controller.dart';
import 'backup_database_view.dart';

class ManageDataView extends GetView<ManageDataController> {
  const ManageDataView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(title: "Manage data",showBackButton: false,actions: [
        InkWell(
            onTap: ()=>Get.back(),
            child: Icon(Icons.close,color: AppColors.whiteColor,))
      ],),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection("DATABASE", [
              {"label": "Backup database", "onTap": () => Get.to(()=>BackupDatabaseView())},
              {"label": "Restore database", "onTap": () => Get.to(()=>RestoreDatabaseScreen())},
              {"label": "Delete all data", "onTap": () => showConfirmDeletePopup(context)},
            ]),
            SizedBox(height: 20),
            _buildSection("IMPORT/EXPORT", [
              {"label": "Export CSV", "onTap": () => print("Export CSV tapped")},
              {"label": "Import CSV", "onTap": () => print("Import CSV tapped")},
              {"label": "Import IIF (Quickbooks)", "onTap": () => print("Import IIF tapped")},
            ]),
          ],
        ),
      ),
    );
  }


  void showConfirmDeletePopup(context) {
    List<String> actions = ["No", "Yes"];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Confirm",
                style: AppTextStyles.bold(
                  fontSize: 18.0,
                  fontColor: AppColors.blueColor,
                ),
              ),
              SizedBox(height: 5),
              Divider(color: AppColors.blueColor, thickness: 2),
              Text(
                "You are about to delete all data of Test on this device. Are you sure?",
                style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor),
              ),
              SizedBox(height: 5),
            ],
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Container(
                  width: Get.width,
                  height: 1,
                  color: AppColors.greyColor,
                ),
                SizedBox(
                  height: 50,
                  child: Row(
                    children: List.generate(actions.length, (index) {
                      return Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              right:
                              index < actions.length - 1
                                  ? BorderSide(
                                color: AppColors.greyColor,
                                width: 1,
                              )
                                  : BorderSide.none,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                             Get.back();
                            },
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                            child: Text(
                              actions[index],
                              style: AppTextStyles.regular(
                                fontSize: 16.0,
                                fontColor: AppColors.blackColor,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

  }

  Widget _buildSection(String title, List<Map<String, dynamic>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            title,
            style: AppTextStyles.bold(fontSize: 16.0, fontColor: AppColors.blueColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Divider(color: AppColors.blueColor, thickness: 2),
        ),
        ...items.map((item) => ListTile(
          title: Text(
            item["label"],
            style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor),
          ),
          onTap: item["onTap"],
        )),
      ],
    );
  }
}
