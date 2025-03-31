import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/common/common_appbar.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:jumla/app/resources/app_styles.dart';

class SummaryReport extends StatelessWidget {
  const SummaryReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(title: "Summary Report",hideLogo: true,
      actions: [
        IconButton(onPressed: (){}, icon: Text("SCROLL",style: AppTextStyles.bold(fontSize: 12.0, fontColor: AppColors.whiteColor),)),
        IconButton(onPressed: (){}, icon: Text("YEAR",style: AppTextStyles.bold(fontSize: 12.0, fontColor: AppColors.whiteColor),)),
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
              value: 'export',
              child: Text('Export Results'),
            ),

            PopupMenuItem<String>(
              value: 'email',
              child: Text('Email Results'),
            ),
          ],
        )

      ],),
      body: Center(child: Text("No Report Available",style: AppTextStyles.bold(fontSize: 14.0, fontColor: AppColors.blackColor),),),
    );
  }
}
