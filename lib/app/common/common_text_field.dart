import 'package:flutter/material.dart';

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

class CommonTextFieldWithTitle extends StatelessWidget {
  final String label;
   String? hint;
  final TextEditingController controller;
  final bool isPassword;

   CommonTextFieldWithTitle({
    required this.label,
     this.hint,
    required this.controller,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor),),
          SizedBox(
            height: 40,
            child: TextField(
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                hintText: hint??"",
                hintStyle: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.greyColor),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color:  AppColors.blackColor,width: 0.5),

                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.blackColor, width: 0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}