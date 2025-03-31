import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/core/app_storage.dart';
import 'package:jumla/app/resources/app_assets.dart';
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


class CommonAppBarWithTitleAndIcon extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool hideLogo;
  final List<Widget>? actions;

  CommonAppBarWithTitleAndIcon({
    required this.title,
    this.showBackButton = true,
    this.hideLogo = false,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: showBackButton,
      title: Row(
        children: [
          hideLogo?SizedBox(): Image.asset(AppAssets.logo, height: 40, width: 50),
          hideLogo?SizedBox(): SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.bold(
                fontSize: 18.0,
                fontColor: AppColors.whiteColor,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
            ),
          ),
        ],
      ),
      backgroundColor: AppStorages.appColor.value,
      leading: showBackButton
          ? IconButton(
        icon: Icon(Icons.arrow_back_ios, color: AppColors.whiteColor),
        onPressed: () {
          Get.back();
        },
      )
          : null,
      actions: actions,
      actionsPadding: EdgeInsets.only(right: 10),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
