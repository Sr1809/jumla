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
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    return Container(
      color: AppStorages.appColor.value,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: double.infinity,
          height: isTablet?50:30,
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


class CommonElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? fontSize;
  final double? borderRadius;

  CommonElevatedButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.fontSize,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,

      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.blueColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 5),

        ),
        elevation: 0.2
      ),
      child: Text(
        text,
        style: AppTextStyles.bold(
          fontSize: fontSize ?? 16.0,
          fontColor: textColor ?? AppColors.whiteColor,
        ),
      ),
    );
  }
}
