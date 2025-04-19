import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/core/app_storage.dart';

import '../resources/app_colors.dart';
import '../resources/app_styles.dart';







class CommonTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
   var prefixIcon;
   var suffixIcon;
   var prefix;
  final VoidCallback? onSuffixTap;
  final TextInputType? keyboardType; // ✅ Added keyboard type


  CommonTextField({
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.onSuffixTap,
    this.keyboardType
  });

  @override
  _CommonTextFieldState createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  RxBool _obscureText = true.obs;

  @override
  void initState() {
    super.initState();
    _obscureText.value = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    double fieldWidth = isTablet ? screenWidth * 0.6 : screenWidth * 0.9;
    double fontSize = isTablet ? 18.0 : 16.0;
    double borderRadius = isTablet ? 16.0 : 12.0;
    double paddingVertical = isTablet ? 16.0 : 14.0;
    double iconSize = isTablet ? 26 : 22;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Center(
        child: Container(
          width: fieldWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Obx(()=> TextField(
            controller: widget.controller,
            obscureText: widget.isPassword ? _obscureText.value : false,
            autocorrect: false,
            cursorColor: AppStorages.appColor.value,
            style: AppTextStyles.regular(
              fontSize: fontSize,
              fontColor: AppColors.blackColor,
            ),
            keyboardType: widget.keyboardType, // ✅ Apply keyboard type

            decoration: InputDecoration(
              hintText: widget.label,
              hintStyle: AppTextStyles.light(
                fontSize: fontSize,
                fontColor: AppColors.darkGrey,
              ),
              filled: true,

              fillColor: Colors.white,
              prefix: widget.prefix,
              contentPadding: EdgeInsets.symmetric(vertical: paddingVertical, horizontal: 16),
              prefixIcon: widget.prefixIcon != null
                  ? Icon(widget.prefixIcon, color: AppStorages.appColor.value, size: iconSize)
                  : null,
              suffixIcon: widget.isPassword
                  ? GestureDetector(
                onTap: () =>  _obscureText.value = !_obscureText.value,
                child: Icon(
                  _obscureText.value ? Icons.visibility_off : Icons.visibility,
                  color: AppStorages.appColor.value,
                  size: iconSize,
                ),
              )
                  : (widget.suffixIcon != null
                  ? GestureDetector(
                onTap: widget.onSuffixTap,
                child: Icon(widget.suffixIcon, color: AppStorages.appColor.value, size: iconSize),
              )
                  : null),
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
        )),
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
  var prefix;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType; // ✅ Added keyboard type

  CommonTextFieldWithTitle({
    required this.label,
    this.hint,
    required this.controller,
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon,
    this.prefix,
    this.onSuffixTap,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    double fieldWidth = isTablet ? screenWidth * 0.7 : screenWidth * 0.9;
    double fontSize = isTablet ? 18.0 : 16.0;
    double borderRadius = isTablet ? 16.0 : 12.0;
    double paddingVertical = isTablet ? 16.0 : 14.0;
    double iconSize = isTablet ? 26 : 22;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Center(
        child: Container(
          width: fieldWidth,
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
              const SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(borderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: controller,
                  obscureText: isPassword,
                  validator: validator,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autocorrect: false,
                  autofocus: false,

                  keyboardType: keyboardType, // ✅ Apply keyboard type
                  cursorColor: AppColors.blueColor,
                  style: AppTextStyles.regular(
                    fontSize: fontSize,
                    fontColor: AppColors.blackColor,
                  ),
                  decoration: InputDecoration(
                    hintText: hint ?? "",
                    hintStyle: AppTextStyles.light(
                      fontSize: fontSize,
                      fontColor: AppColors.darkGrey,
                    ),
                    filled: true,
                    prefix: prefix,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: paddingVertical, horizontal: 16),
                    prefixIcon: prefixIcon != null
                        ? Icon(prefixIcon,
                        color: AppStorages.appColor.value, size: iconSize)
                        : null,
                    suffixIcon: suffixIcon != null
                        ? GestureDetector(
                      onTap: onSuffixTap,
                      child: Icon(suffixIcon,
                          color: AppStorages.appColor.value,
                          size: iconSize),
                    )
                        : null,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppStorages.appColor.value, width: 1.2),
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: AppStorages.appColor.value, width: 1.5),
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.2),
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1.5),
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



