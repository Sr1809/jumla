import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/core/app_storage.dart';
import '../resources/app_colors.dart';
import '../resources/app_styles.dart';

class CommonFullWidthButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? textColor;

  CommonFullWidthButton({
    required this.text,
    required this.onTap,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppStorages.appColor.value,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: double.infinity,
          height: 35,
          child: Center(
            child: Text(
              text,
              style: AppTextStyles.bold(
                fontSize: 18.0,
                fontColor: textColor ?? AppColors.whiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}