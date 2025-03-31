import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/common_appbar.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_styles.dart';
import 'filter_view.dart';

class SavedReports extends StatelessWidget {
  const SavedReports({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(title: "Saved Report",hideLogo: true,
        actions: [
          IconButton(onPressed: (){}, icon: Text("SCROLL",style: AppTextStyles.bold(fontSize: 12.0, fontColor: AppColors.whiteColor),)),
          IconButton(onPressed: (){
            Get.to(()=>FilterSortScreen());
          }, icon: Icon(Icons.filter_list,color: AppColors.whiteColor,)),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.white),
            color: AppColors.whiteColor,
            onSelected: (value) {
              if (value == 'export') {
                showDialog(
                  context: context,

                  builder: (_) => SimpleDialog(
                    backgroundColor: AppColors.whiteColor,
                    title: Text("Export Results"),
                    children: [
                      ListTile(title: Text("CSV Format"), onTap: () => Get.back()),
                      ListTile(title: Text("CSV Format"), onTap: () => Get.back()),
                    ],
                  ),
                );
              } else if (value == 'email') {
                showDialog(
                  context: context,
                  builder: (_) => SimpleDialog(
                    backgroundColor: AppColors.whiteColor,

                    title: Text("Email Results"),
                    children: [
                      ListTile(title: Text("CSV Format"), onTap: () => Get.back()),
                      ListTile(title: Text("CSV Format"), onTap: () => Get.back()),
                    ],
                  ),
                );
              }

            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'copy',
                child: Text('Copy'),
              ),
              PopupMenuItem<String>(
                value: 'export',
                child: Text('Export Results'),
              ),

              PopupMenuItem<String>(
                value: 'email',
                child: Text('Email Results'),
              ),
              PopupMenuItem<String>(
                value: 'all_reports',
                child: Text('List all reports'),
              ),
              PopupMenuItem<String>(
                value: 'hide_on',
                child: Text('Show/hide report on dashboard'),
              ),
              PopupMenuItem<String>(
                value: 'hide_on',
                child: Text('Show/hide results on dashboard'),
              ),
            ],
          )

        ],),
      body: Center(child: Text("No Report Available",style: AppTextStyles.bold(fontSize: 14.0, fontColor: AppColors.blackColor),),),
    );
  }
}
