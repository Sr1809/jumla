import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/resources/app_assets.dart';
import 'package:jumla/app/resources/app_colors.dart';

import '../../../resources/app_styles.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(AppAssets.logo,  width: 100),

          ],
        ),
        backgroundColor: AppColors.blueColor,
        actions: [
          IconButton(
            icon: Icon(Icons.sync, color: Colors.red),
            onPressed: () {
              // Handle refresh
            },
          ),
          IconButton(
            icon: Icon(Icons.menu, color: AppColors.whiteColor),
            onPressed: () {
              // Handle menu
            },
          ),
        ],
      ),
    );
  }

  void _showPopup() {
    Get.defaultDialog(
      radius: 0.0,
      title: "More shortcuts",
      titleStyle: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(thickness: 1, color: Colors.blue),
          Column(
            children: ['ds', 'dsdsa', 'dsd'].map((key) {
              return CheckboxListTile(
                title: Text(key, style: TextStyle(fontWeight: FontWeight.bold)),
                value: true,
                onChanged: (bool? value) {
                  // controller.shortcuts[key] = value ?? false;
                },
                activeColor: Colors.blue,
                checkColor: Colors.white,
              );
            }).toList(),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => Get.back(),
            child: Text("Done"),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(title, style: TextStyle(fontSize: 16)),
    );
  }
}
