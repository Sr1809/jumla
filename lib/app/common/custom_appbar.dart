import 'package:flutter/material.dart';
import 'package:jumla/app/core/app_storage.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:jumla/app/resources/app_styles.dart';

class CustomAppbar extends StatelessWidget {
  CustomAppbar({super.key, this.title, this.actions});
  String? title;
  Widget? actions;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Ensure full width
      color: AppStorages.appColor.value,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ensure spacing
            children: [
              Text(
                title ?? "",
                style: AppTextStyles.medium(
                  fontSize: 20.0,
                  fontColor: AppColors.whiteColor,
                ),
              ),
              if (actions != null)
                actions ?? Text("") // Only show if actions exist
            ],
          ),
        ),
      ),
    );
  }
}
