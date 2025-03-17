import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/core/app_storage.dart';

import '../../../common/common_methods.dart';
import '../../../common/common_widget.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_styles.dart';
import '../../../routes/app_pages.dart';
import '../../cloud_account/reser_device_data.dart';
import '../../cloud_account/reset_cloud_data_view.dart';
import '../../cloud_account/sync_options_view.dart';
import '../controllers/drawer_controller.dart';

class DrawerView extends GetView<DrawersController> {
  const DrawerView({super.key});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;

    double drawerWidth = isTablet ? screenWidth * 0.5 : screenWidth * 0.8; // 50% for tablets, 80% for mobile
    double textSize = isTablet ? 30.0 : 18.0;
    double iconSize = isTablet ? 28.0 : 22.0;
    double paddingSize = isTablet ? 40.0 : 20.0;
    double dividerThickness = isTablet ? 1.0 : 0.5;

    return SafeArea(
      child: SizedBox(
        width: drawerWidth, // ✅ Increased width dynamically
        child: Drawer(
          backgroundColor: AppColors.whiteColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(16.0), bottomRight: Radius.circular(16.0)),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              /// **Sync Section**
              _buildSyncSection(textSize, iconSize),

              /// **User Options**
              _buildUserOptions(textSize),

              Divider(color: AppStorages.appColor.value, height: 20, thickness: dividerThickness),

              /// **Main Menu**
              _buildSectionHeader("MAIN MENU", textSize),
              _buildMenuItem(Icons.home, "Home", () {}),
              _buildMenuItem(Icons.shopping_cart, "Sales", () {}),
              _buildMenuItem(Icons.shopping_bag, "Purchases", () {}),
              _buildMenuItem(Icons.person, "Customers", () {}),
              _buildMenuItem(Icons.people, "Vendors", () {}),
              _buildMenuItem(Icons.inventory, "Items", () {}),

              Divider(color: AppStorages.appColor.value, height: 20, thickness: dividerThickness),

              /// **Reports Section**
              _buildExpandableMenu("REPORTS", [
                _buildMenuItem(Icons.bar_chart, "Dashboard", () {}),
                _buildMenuItem(Icons.insert_chart, "Summary reports", () {}),
                _buildMenuItem(Icons.save, "Saved reports", () {}),
              ]),

              Divider(color: AppStorages.appColor.value, height: 20, thickness: dividerThickness),

              /// **Features Section**
              _buildExpandableMenu("FEATURES", [
                _buildMenuItem(Icons.edit, "Signatures", () {}),
                _buildMenuItem(Icons.description, "Statements", () {}),
                _buildMenuItem(Icons.qr_code, "Scan barcodes", () {}),
                _buildMenuItem(Icons.apartment, "Multiple companies", () {}),
                _buildMenuItem(Icons.autorenew, "Recurring invoices", () {}),
                _buildMenuItem(Icons.book, "QuickBooks", () {}),
              ]),

              Divider(color: AppStorages.appColor.value, height: 20, thickness: dividerThickness),

              /// **Tools Section**
              _buildExpandableMenu("TOOLS", [
                _buildMenuItem(Icons.list, "Lists", (){
                  Get.back();
                  Get.toNamed(Routes.LISTS);
                }),
                _buildMenuItem(Icons.settings, "Settings", () {
                  Get.back();
                  Get.toNamed(Routes.APP_SETTINGS);
                }),
                _buildMenuItem(Icons.storage, "Manage data", () {
                  Get.back();
                  Get.toNamed(Routes.MANAGE_DATA);
                }),
                _buildMenuItem(Icons.cloud, "Dropbox", () {
                  Get.back();
                  Get.toNamed(Routes.DROPBOX);
                }),
                _buildMenuItem(Icons.color_lens, "UI options", () {
                  showColorPickerPopup();
                }),
              ]),
              Divider(color: AppStorages.appColor.value, height: 20, thickness: dividerThickness),
              _buildSectionHeader("CLOUD ACCOUNT", textSize),
              _buildMenuItem(Icons.sync, "Sync options", () {
                Get.to(()=>SyncOptionsView());
              }),
              _buildMenuItem(Icons.refresh, "Reset DEVICE data", () {
                Get.to(()=>ResetDeviceDataView());

              }),
              _buildMenuItem(Icons.cloud_done, "Reset CLOUD data", () {
                Get.to(()=>ResetCloudDataView());

              }),
              _buildMenuItem(Icons.people, "Manage users", () {
                launchUrls(Uri.parse("https://system.mobilebizco.com/app/login"));
              }),
              _buildMenuItem(Icons.web, "Login to website", () {
                launchUrls(Uri.parse("https://system.mobilebizco.com/app/login"));
              }),


              Divider(color: AppStorages.appColor.value, height: 20, thickness: dividerThickness),

              /// **About Section**
              _buildExpandableMenu("ABOUT", [
                _buildMenuItem(Icons.phone_android, "What's new", ()=>Get.toNamed(Routes.WHATS_NEW)),
                _buildMenuItem(Icons.mail, "Contact Us", () {
                  final Uri emailUri = Uri(
                    scheme: 'mailto',
                    path: "info@mobilebizco.com",
                    queryParameters: {
                    },
                  );
                  launchUrls(emailUri);
                }),
                _buildMenuItem(Icons.thumb_up, "Send review", () {

                }),
                _buildMenuItem(Icons.lightbulb, "Help", (){
                  launchUrls(Uri.parse("https://support.mobilebizco.com/"));
                }),
              ]),
            ],
          ),
        ),
      ),
    );
  }


  /// **Sync Now Section**
  Widget _buildSyncSection(double textSize, double iconSize) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(Icons.sync, color: AppStorages.appColor.value, size: iconSize),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Sync Now", style: AppTextStyles.regular(fontSize: textSize, fontColor: AppStorages.appColor.value)),
              SizedBox(height: 5),
              Text("Last Sync: 3/2/25 1:22 PM", style: AppTextStyles.regular(fontSize: textSize * 0.7, fontColor: AppColors.darkGrey)),
            ],
          ),
        ],
      ),
    );
  }

  /// **User Options Section**
  Widget _buildUserOptions(double textSize) {
    return Row(
      children: [
        Expanded(
          child: _buildOptionButton("Super Admin", textSize),
        ),
        SizedBox(width: 4),
        Expanded(
          child: _buildOptionButton("Logout", textSize),
        ),
      ],
    );
  }

  /// **Reusable Button for User Options**
  Widget _buildOptionButton(String text, double textSize) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6),
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: AppStorages.appColor.value, // Updated color
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(text, style: AppTextStyles.regular(fontSize: textSize * 0.7, fontColor: AppColors.whiteColor)),
        ),
      ),
    );
  }

  /// **Header Section for Each Category**
  Widget _buildSectionHeader(String title, double textSize) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        title,
        style: AppTextStyles.bold(fontSize: textSize * 0.8, fontColor: AppStorages.appColor.value),
      ),
    );
  }

  /// **Standard Menu Item**
  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppStorages.appColor.value.withOpacity(0.05), // Updated menu item color
          border: Border.all(color: AppStorages.appColor.value)
        ),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Row(
          children: [
            Icon(icon, size: 24, color: AppStorages.appColor.value),
            SizedBox(width: 20),
            Text(title, style: AppTextStyles.medium(fontSize: 16.0, fontColor: AppStorages.appColor.value)),
          ],
        ),
      ),
    );
  }

  /// **Expandable Menu Section**
  Widget _buildExpandableMenu(String title, List<Widget> children) {
    return Theme(
      data: Theme.of(Get.context!).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: AppTextStyles.bold(fontSize: 16.0, fontColor: AppStorages.appColor.value),
        ),
        initiallyExpanded:true,
        children: children,
        collapsedIconColor: AppStorages.appColor.value,
        iconColor: AppStorages.appColor.value,
      ),
    );
  }

  void showColorPickerPopup() {
    List<Color> colors = [
      AppColors.blueColor, Colors.green, Colors.orange,
      Colors.pink, Colors.grey, Colors.purple,
      Colors.black, Colors.cyan, Colors.brown
    ];

    Rx<Color> selectedColor = AppStorages.appColor;
    RxBool showCompanyTitle = false.obs;

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // ✅ Rounded popup
        backgroundColor: AppColors.whiteColor,
        child: LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;
            bool isTablet = screenWidth > 600;

            double dialogWidth = isTablet ? screenWidth * 0.7 : screenWidth; // ✅ Larger width for tablets
            double dialogHeight = isTablet ? 600 : 500; // ✅ Taller popup for tablets

            return SizedBox(
              width: dialogWidth,
              height: dialogHeight,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// **Title and Divider**
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          "Choose Theme Color",
                          style: AppTextStyles.bold(fontSize: isTablet ? 26.0 : 22.0, fontColor: AppColors.blackColor),
                        ),
                      ),
                    ),
                    Divider(color: AppStorages.appColor.value, thickness: 2),
                    SizedBox(height: 10),

                    /// **Selected Color Preview**
                    Obx(() => Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: selectedColor.value,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.blackColor, width: 1),
                      ),
                    )),
                    SizedBox(height: 20),

                    /// **Color Selection Grid**
                    GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(10),
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isTablet ? 5 : 4, // ✅ More columns on tablets
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1.2
                      ),
                      itemCount: colors.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => selectedColor.value = colors[index],
                          child: Obx(() => Container(

                            decoration: BoxDecoration(
                              color: colors[index],
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: selectedColor.value == colors[index] ? AppColors.blackColor : Colors.transparent,
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6,
                                  spreadRadius: 1,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                          )),
                        );
                      },
                    ),
                    SizedBox(height: 20),

                    /// **Checkbox Options**
                    Obx(() => Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: _customCheckbox("Hide Jumla logo", AppStorages.hideCompanyLogo, isTablet),
                    )),
                    SizedBox(height: 10),
                    Obx(() => Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: _customCheckbox("My company on Home title", showCompanyTitle, isTablet),
                    )),
                    SizedBox(height: 20),

                    /// **Action Buttons**
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        /// **Cancel Button**
                        TextButton(
                          onPressed: () => Get.back(),
                          child: Text("Cancel", style: AppTextStyles.bold(fontSize: isTablet ? 20.0 : 18.0, fontColor: AppColors.blackColor)),
                        ),

                        /// **Save Button**
                        ElevatedButton(
                          onPressed: () {
                            AppStorages.appColor.value = selectedColor.value;
                            Get.back();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedColor.value,
                            padding: EdgeInsets.symmetric(horizontal: isTablet ? 40 : 30, vertical: isTablet ? 14 : 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Text("Save", style: AppTextStyles.bold(fontSize: isTablet ? 20.0 : 18.0, fontColor: AppColors.whiteColor)),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      barrierDismissible: true, // ✅ Allows dismissing the popup by tapping outside
    );
  }

  /// **Modern Checkbox with Tablet Support**
  Widget _customCheckbox(String label, RxBool value, bool isTablet) {
    return GestureDetector(
      onTap: () {
        value.value = !value.value;
        if (label == "Hide Jumla logo") {
          AppStorages.hideCompanyLogo.value = value.value;
        }
      },
      child: Row(
        children: [
          Container(
            width: isTablet ? 28 : 24,
            height: isTablet ? 28 : 24,
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              border: Border.all(color: AppColors.blackColor, width: 2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: value.value ? Icon(Icons.check, color: AppStorages.appColor.value, size: isTablet ? 22 : 18) : null,
          ),
          SizedBox(width: 10),
          Text(
            label,
            style: AppTextStyles.regular(fontSize: isTablet ? 20.0 : 16.0, fontColor: AppColors.blackColor),
          ),
        ],
      ),
    );
  }




}
