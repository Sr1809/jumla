import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/common/common_appbar.dart';
import '../../../core/app_storage.dart';
import '../../../resources/app_styles.dart';
import '../controllers/whats_new_controller.dart';

class WhatsNewView extends GetView<WhatsNewController> {
  const WhatsNewView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    return DefaultTabController(
      length: 2, // Two tabs: What's New & License
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonAppBarWithTitleAndIcon(
          title: "",
          showBackButton: true,
        ),
        body: Column(
          children: [
            _buildTabs(isTablet), // ✅ Add Tabs at the top
            Expanded(
              child: TabBarView(
                children: [
                  _whatsNewTab(isTablet),
                  _licenseTab(isTablet),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Add Tabs
  Widget _buildTabs(bool isTablet) {
    return Container(
      color: AppStorages.appColor.value,
      child: TabBar(
        indicatorColor: Colors.lightBlue,
        labelStyle: AppTextStyles.bold(
          fontSize: isTablet ? 18.0 : 16.0,
          fontColor: Colors.white,
        ),
        unselectedLabelStyle: AppTextStyles.regular(
          fontSize: isTablet ? 18.0 : 16.0,
          fontColor: Colors.white70,
        ),
        tabs: [
          Tab(text: "WHAT'S NEW"),
          Tab(text: "LICENSE"),
        ],
      ),
    );
  }

  // ✅ "What's New" Tab Content
  Widget _whatsNewTab(bool isTablet) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(isTablet ? 20 : 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("v.1.6", style: _sectionTitleStyle(isTablet)),
          Obx(() => Column(
            children: controller.whatsNewList
                .map((item) => _bulletPoint(item, isTablet))
                .toList(),
          )),
          SizedBox(height: isTablet ? 20 : 12),
          Text("Bug Fixes", style: _sectionTitleStyle(isTablet)),
          Obx(() => Column(
            children: controller.bugFixesList
                .map((item) => _bulletPoint(item, isTablet))
                .toList(),
          )),
        ],
      ),
    );
  }

  // ✅ "License" Tab Content
  Widget _licenseTab(bool isTablet) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(isTablet ? 20 : 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("END-USER LICENSE AGREEMENT", style: _sectionTitleStyle(isTablet)),
          SizedBox(height: isTablet ? 12.0 : 8.0),
          Obx(() => Text(
            controller.licenseText.value,
            style: AppTextStyles.regular(
              fontSize: isTablet ? 15.0 : 13.0,
              fontColor: Colors.black,
            ),
          )),
        ],
      ),
    );
  }

  // ✅ Helper method for bullet points
  Widget _bulletPoint(String text, bool isTablet) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isTablet ? 6 : 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("• ", style: AppTextStyles.bold(fontSize: isTablet ? 16.0 : 14.0, fontColor: Colors.black)),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.regular(fontSize: isTablet ? 16.0 : 14.0, fontColor: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Common section title styling
  TextStyle _sectionTitleStyle(bool isTablet) {
    return AppTextStyles.bold(fontSize: isTablet ? 18.0 : 16.0, fontColor: Colors.black);
  }
}
