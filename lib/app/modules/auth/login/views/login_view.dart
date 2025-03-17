import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/core/app_storage.dart';
import 'package:jumla/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/common_text_field.dart';
import '../../../../common/common_widget.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_styles.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetWidget<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    double fieldWidth = isTablet ? screenWidth * 0.6 : screenWidth; // 60% of screen width on tablets
    double buttonWidth = isTablet ? 180 : Get.width*0.35; // Larger buttons on tablets
    double textSize = isTablet ? 22.0 : 18.0; // Increase text size on tablets

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: Text(
          "Jumla",
          style: AppTextStyles.bold(
            fontSize: isTablet ? 24.0 : 20.0, // Larger title on tablets
            fontColor: AppColors.whiteColor,
          ),
        ),
        backgroundColor:AppStorages.appColor.value,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == "Account") {
                controller.showAccountField.value = !controller.showAccountField.value;
              }
            },
            iconColor: Colors.white70,
            itemBuilder: (context) => [
              PopupMenuItem(
                height: 30,
                value: "Account",
                child: Text(
                  "Account",
                  style: AppTextStyles.regular(
                    fontSize: isTablet ? 18.0 : 16.0,
                    fontColor: AppColors.blackColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Container(
          width: fieldWidth, // Responsive width
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 40 : 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => controller.showAccountField.value
                  ? CommonTextField2(
                label: "Account",
                controller: TextEditingController(),
              )
                  : SizedBox()),
              CommonTextField2(
                label: "Username",
                controller: controller.usernameController,
              ),
              CommonTextField2(
                label: "Password",
                controller: controller.passwordController,
                isPassword: true,
              ),
              SizedBox(height: isTablet ? 30 : 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton(
                    text: "Sign In",
                    onTap: () {
                      Get.toNamed(Routes.COMPANY_INFO_NOTE);
                    },
                    buttonWidth: buttonWidth,
                    fontSize: textSize,
                  ),
                  SizedBox(width: isTablet ? 40 : 18), // Increased spacing for tablets
                  _buildButton(
                    text: "Reset",
                    onTap: () {
                      controller.usernameController.clear();
                      controller.passwordController.clear();
                    },
                    buttonWidth: buttonWidth,
                    fontSize: textSize,
                  ),
                ],
              ),
              SizedBox(height: isTablet ? 30 : 20),

// "Create an account" - Looks like a soft button
              _buildLiteButton("Create an account", textSize, () {
                // Handle Create Account
                launchUrls(Uri.parse("https://system.mobilebizco.com/app/signup"));
              }, isBold: true),

              SizedBox(height: 20),

// "Forgot password" - Same button style
              _buildLiteButton("Forgot password", textSize, () {
                // Handle Forgot Password
                launchUrls(Uri.parse("https://system.mobilebizco.com/app/password?ccd=17788"));
              }),
            ],
          ),
        ),
      ),
    );
  }

  /// Custom button widget with dynamic scaling
  Widget _buildButton({
    required String text,
    required VoidCallback onTap,
    required double buttonWidth,
    required double fontSize,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppStorages.appColor.value,
        minimumSize: Size(buttonWidth, 50), // Increased button size
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
        textStyle: TextStyle(color: Colors.white, fontSize: fontSize),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // Softer corners
      ),
      child: Text(
        text,
        style: AppTextStyles.regular(
          fontSize: fontSize,
          fontColor: AppColors.whiteColor,
        ),
      ),
    );
  }

  Widget _buildLinkText(String text, double fontSize, VoidCallback onTap, {bool isBold = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4), // Balanced spacing
        child: Text(
          text,
          style: AppTextStyles.semiBold( // SemiBold for better emphasis
            fontSize: fontSize,
            fontColor: AppStorages.appColor.value,
            isUnderLine: true,
          ).copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal, // Bold if needed
          ),
        ),
      ),
    );
  }
  Widget _buildLiteButton(String text, double fontSize, VoidCallback onTap, {bool isBold = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20), // Button padding
        decoration: BoxDecoration(
          color: Colors.transparent, // Light look with no solid color
          borderRadius: BorderRadius.circular(8), // Rounded edges
          border: Border.all(color: Colors.blue, width: 1), // Border for button effect
        ),
        child: Text(
          text,
          style: AppTextStyles.semiBold(
            fontSize: fontSize,
            fontColor: Colors.blue,
          ).copyWith(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }



}
