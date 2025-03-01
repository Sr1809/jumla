import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/app_styles.dart';
class CommonTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;

  CommonTextField({
    required this.label,
    required this.controller,
    this.isPassword = false,
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
          hintStyle: AppTextStyles.regular(fontSize: 20.0, fontColor: AppColors.greyColor),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2),
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
                  borderSide: BorderSide(color:  AppColors.blackColor),

                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.blackColor, width: 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}