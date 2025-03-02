import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jumla/app/modules/drawer/controllers/drawer_controller.dart';
import 'package:jumla/app/resources/app_assets.dart';
import 'package:jumla/app/resources/app_colors.dart';

import '../../../resources/app_styles.dart';
import '../../drawer/views/drawer_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:controller.scaffoldKey,
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
              var contro = Get.put(DrawersController());
              controller.scaffoldKey.currentState?.openDrawer();
            },
          ),
        ],
      ),
      drawer: DrawerView(),
    );
  }
}
