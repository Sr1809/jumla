import 'package:flutter/material.dart';
import 'package:jumla/app/core/app_storage.dart';

import '../resources/app_colors.dart';
import '../resources/app_styles.dart';
class CommonTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  Color?  underlineColor;

  CommonTextField({
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.underlineColor = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.greyColor),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: underlineColor??Colors.blue,width: 0.5),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: underlineColor??Colors.blue, width: 0.5),
          ),
        ),
      ),
    );
  }
}






class CommonTextField2 extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;

  CommonTextField2({
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600; // Detect if device is a tablet

    double fieldWidth = isTablet ? screenWidth * 0.6 : screenWidth * 0.9; // Adjust width
    double fontSize = isTablet ? 18.0 : 16.0; // Larger font size for tablets
    double borderRadius = isTablet ? 16.0 : 12.0; // Softer edges on tablets
    double paddingVertical = isTablet ? 16.0 : 14.0; // More padding on tablets
    double iconSize = isTablet ? 26 : 22; // Larger icons on tablets

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Center(
        child: Container(
          width: fieldWidth, // Adjusted width based on screen size
          decoration: BoxDecoration(
            color: Colors.white, // Ensuring a good contrast background
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2), // Soft shadow for elevation
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword,
            autocorrect: false,
            cursorColor: AppStorages.appColor.value,
            style: AppTextStyles.regular(
              fontSize: fontSize,
              fontColor: AppColors.blackColor, // Better readability
            ),
            decoration: InputDecoration(
              hintText: label,
              hintStyle: AppTextStyles.light(
                fontSize: fontSize,
                fontColor: AppColors.darkGrey,
              ),
              filled: true,
              fillColor: Colors.white, // Clear contrast against text
              contentPadding: EdgeInsets.symmetric(vertical: paddingVertical, horizontal: 16),
              prefixIcon: prefixIcon != null
                  ? Icon(prefixIcon, color: AppStorages.appColor.value, size: iconSize)
                  : null,
              suffixIcon: suffixIcon != null
                  ? GestureDetector(
                onTap: onSuffixTap,
                child: Icon(suffixIcon, color: AppStorages.appColor.value, size: iconSize),
              )
                  : null,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppStorages.appColor.value, width: 1.2),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppStorages.appColor.value, width: 1.5),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
          ),
        ),
      ),
    );
  }
}




class CommonTextFieldWithTitle extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController controller;
  final bool isPassword;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;

  CommonTextFieldWithTitle({
    required this.label,
    this.hint,
    required this.controller,
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600; // Detect if device is a tablet

    double fieldWidth = isTablet ? screenWidth * 0.7 : screenWidth * 0.9; // Adjust width
    double fontSize = isTablet ? 18.0 : 16.0; // Larger font size for tablets
    double borderRadius = isTablet ? 16.0 : 12.0; // Softer edges on tablets
    double paddingVertical = isTablet ? 16.0 : 14.0; // More padding on tablets
    double iconSize = isTablet ? 26 : 22; // Larger icons on tablets

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Center(
        child: Container(
          width: fieldWidth, // Adjusted width based on screen size
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.regular(
                  fontSize: fontSize,
                  fontColor: AppColors.blackColor,
                ),
              ),
              SizedBox(height: 5), // Space between label and text field
              Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Ensuring a good contrast background
                  borderRadius: BorderRadius.circular(borderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2), // Soft shadow for elevation
                    ),
                  ],
                ),
                child: TextField(
                  controller: controller,
                  obscureText: isPassword,
                  autocorrect: false,
                  cursorColor: AppColors.blueColor,
                  style: AppTextStyles.regular(
                    fontSize: fontSize,
                    fontColor: AppColors.blackColor, // Better readability
                  ),
                  decoration: InputDecoration(
                    hintText: hint ?? "",
                    hintStyle: AppTextStyles.light(
                      fontSize: fontSize,
                      fontColor: AppColors.darkGrey,
                    ),
                    filled: true,
                    fillColor: Colors.white, // Clear contrast against text
                    contentPadding: EdgeInsets.symmetric(vertical: paddingVertical, horizontal: 16),
                    prefixIcon: prefixIcon != null
                        ? Icon(prefixIcon, color: AppColors.blueColor, size: iconSize)
                        : null,
                    suffixIcon: suffixIcon != null
                        ? GestureDetector(
                      onTap: onSuffixTap,
                      child: Icon(suffixIcon, color: AppColors.blueColor, size: iconSize),
                    )
                        : null,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.blueColor, width: 1.2),
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.blueColor, width: 1.5),
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
