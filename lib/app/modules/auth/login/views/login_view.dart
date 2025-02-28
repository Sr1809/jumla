import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mobile_biz/app/common/common_text_field.dart';
import 'package:mobile_biz/app/resources/app_colors.dart';
import 'package:mobile_biz/app/resources/app_styles.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetWidget<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MobileBiz Co"),
        backgroundColor: Colors.green,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == "Account") {
                controller.showAccountField.value = !controller.showAccountField.value;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                height: 30,
              //  padding: EdgeInsets.only(left: 10,right: 10,top: 4,bottom: 4),
                value: "Account",
                child: Text("Account",style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.blackColor),),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => controller.showAccountField.value
                ? CommonTextField(
              label: "Account",
              controller: TextEditingController(),
            )
                : SizedBox()),
            CommonTextField(
              label: "Username",
              controller: controller.usernameController,
            ),
            CommonTextField(
              label: "Password",
              controller: controller.passwordController,
              isPassword: true,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width*0.3,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle Sign In
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[400],
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      textStyle: TextStyle(color: Colors.black,fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Text(
                      "Sign In",
                      style: AppTextStyles.regular(fontSize: 18.0, fontColor: AppColors.blackColor),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                SizedBox(
                  width: Get.width*0.3,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.usernameController.clear();
                      controller.passwordController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[400],
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      textStyle: TextStyle(color: Colors.black,fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: Text(
                      "Reset",
                      style: AppTextStyles.regular(fontSize: 18.0, fontColor: AppColors.blackColor),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Handle Create Account
              },
              child: Text(
                "Create an account",
                style:   AppTextStyles.regular(fontSize: 18.0, fontColor: AppColors.blueColor,isUnderLine: true),
              ),
            ),
            SizedBox(height: 5),
            GestureDetector(
              onTap: () {
                // Handle Forgot Password
              },
              child: Text(
                "Forgot password",
                style:   AppTextStyles.regular(fontSize: 18.0, fontColor: AppColors.blueColor,isUnderLine: true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
