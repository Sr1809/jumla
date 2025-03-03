import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/core/app_storage.dart';

import '../resources/app_colors.dart';
import '../resources/app_styles.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;

  CommonAppBar({
    required this.title,
    this.showBackButton = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: InkWell(
        onTap: () {
          Get.back();
        },
        child: Text(
          title,
          style: AppTextStyles.bold(
            fontSize: 18.0,
            fontColor: AppColors.whiteColor,
          ),
        ),
      ),
      backgroundColor: AppStorages.appColor.value,
      leadingWidth: showBackButton ? null : 0,
      leading: showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back_ios, color: AppColors.whiteColor),
              onPressed: () {
                Get.back();
              },
            )
          : SizedBox.shrink(),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
