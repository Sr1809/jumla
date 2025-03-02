import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      title: Text(
        title,
        style: AppTextStyles.bold(
          fontSize: 18.0,
          fontColor: AppColors.whiteColor,
        ),
      ),
      backgroundColor: AppColors.blueColor,
      leading: showBackButton
          ? IconButton(
        icon: Icon(Icons.arrow_back_ios, color: AppColors.whiteColor),
        onPressed: () {
          Get.back();
        },
      )
          : null,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
