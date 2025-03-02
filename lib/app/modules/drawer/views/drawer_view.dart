import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../resources/app_colors.dart';
import '../../../resources/app_styles.dart';
import '../controllers/drawer_controller.dart';

class DrawerView extends GetView<DrawersController> {
  const DrawerView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        surfaceTintColor: Colors.black38,
        backgroundColor: AppColors.drawerColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
               Row(
                 children: [
                   SizedBox(width: 70,child: Icon(Icons.sync,color: AppColors.whiteColor,)),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("Sync Now", style: AppTextStyles.regular(fontSize: 18.0, fontColor: AppColors.whiteColor)),
                       SizedBox(height: 5),
                       Text("Last Sync: 3/2/25 1:22 PM", style: AppTextStyles.regular(fontSize: 12.0, fontColor: AppColors.greyColor)),
                     ],
                   )
                 ],
               ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                            padding: EdgeInsets.only(top: 6,bottom: 6),
                            decoration: BoxDecoration(
                              color: AppColors.liteGrayColor,

                            ),
                            child: Center(child: Text("Super Admin",style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.greyColor),))),
                      ),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.only(top: 6,bottom: 6),
                            decoration: BoxDecoration(
                              color: AppColors.liteGrayColor,

                            ),
                            child:  Center(child: Text("Logout",style: AppTextStyles.regular(fontSize: 14.0, fontColor: AppColors.greyColor),)),
                          )),
                    ),
                  ],
                )
              ],
            ),
            Container(
              height: 20,
              width: Get.width,
              color: Colors.black38,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "TEST",
                    style: AppTextStyles.regular(fontSize: 16.0, fontColor: AppColors.greyColor),
                  ),
                ),
                buildMenuItem( Icons.home,  "Home",  () {}),
                Divider(color: Colors.black45,height: 0.5,thickness: 1,),
                buildMenuItem( Icons.shopping_cart,  "Sales",  () {}),
                Divider(color: Colors.black45,height: 0.5,thickness: 1,),
                buildMenuItem( Icons.shopping_bag,  "Purchases", () {}),
                Divider(color: Colors.black45,height: 0.5,thickness: 1,),
                buildMenuItem( Icons.person,  "Customers", () {}),
                Divider(color: Colors.black45,height: 0.5,thickness: 1,),
                buildMenuItem(Icons.people, "Vendors",  () {}),
                Divider(color: Colors.black45,height: 0.5,thickness: 1,),
                buildMenuItem( Icons.inventory, "Items",  () {}),
              ],
            ),
            Divider(color: Colors.black45,height: 0.5,thickness: 0.5,),
            // Reports Section
            buildExpandableMenu("REPORTS", [
              buildMenuItem(Icons.bar_chart, "Dashboard", () {}),
              Divider(color: Colors.black45,height: 0.5,thickness: 1,),
              buildMenuItem(Icons.insert_chart, "Summary reports", () {}),
              Divider(color: Colors.black45,height: 0.5,thickness: 1,),
              buildMenuItem(Icons.save, "Saved reports", () {}),

            ]),
            Divider(color: Colors.black45,height: 0.5,thickness: 0.5,),

            // Features Section
            buildExpandableMenu("FEATURES", [
              buildMenuItem(Icons.edit, "Signatures", () {}),
              Divider(color: Colors.black45,height: 0.5,thickness: 1,),
              buildMenuItem(Icons.description, "Statements", () {}),
              Divider(color: Colors.black45,height: 0.5,thickness: 1,),
              buildMenuItem(Icons.qr_code, "Scan barcodes", () {}),
              Divider(color: Colors.black45,height: 0.5,thickness: 1,),
              buildMenuItem(Icons.apartment, "Multiple companies", () {}),
              Divider(color: Colors.black45,height: 0.5,thickness: 1,),
              buildMenuItem(Icons.autorenew, "Recurring invoices", () {}),
              Divider(color: Colors.black45,height: 0.5,thickness: 1,),
              buildMenuItem(Icons.book, "QuickBooks", () {}),
            ]),
            Divider(color: Colors.black45,height: 0.5,thickness: 0.5,),
            // Tools Section
            buildExpandableMenu("TOOLS", [
              buildMenuItem(Icons.list, "Lists", () {}),
              Divider(color: Colors.black45,height: 0.5,thickness: 1,),
              buildMenuItem(Icons.settings, "Settings", () {}),
              Divider(color: Colors.black45,height: 0.5,thickness: 1,),
              buildMenuItem(Icons.storage, "Manage data", () {}),
              Divider(color: Colors.black45,height: 0.5,thickness: 1,),
              buildMenuItem(Icons.cloud, "Dropbox", () {}),
            ]),
            Divider(color: Colors.black45,height: 0.5,thickness: 0.5,),
            // Cloud Account Section
            buildExpandableMenu("CLOUD ACCOUNT", [
              buildMenuItem(Icons.sync, "Sync options", () {}),
              Divider(color: Colors.black45,height: 0.5,thickness: 1,),
              buildMenuItem(Icons.refresh, "Reset DEVICE data", () {}),
              Divider(color: Colors.black45,height: 0.5,thickness: 1,),
              buildMenuItem(Icons.cloud_upload, "Reset CLOUD data", () {}),
              Divider(color: Colors.black45,height: 0.5,thickness: 1,),
              buildMenuItem(Icons.people, "Manage users", () {}),
              Divider(color: Colors.black45,height: 0.5,thickness: 1,),
              buildMenuItem(Icons.cloud_done, "Login to website", () {}),
            ]),
            Divider(color: Colors.black45,height: 0.5,thickness: 0.5,),
            // About Section
            buildExpandableMenu("ABOUT", [
              buildMenuItem(Icons.phone_android, "What's new", () {}),
              Divider(color: Colors.black45,height: 0.5,thickness: 1,),
              buildMenuItem(Icons.mail, "Contact Us", () {}),
              Divider(color: Colors.black45,height: 0.5,thickness: 1,),
              buildMenuItem(Icons.thumb_up, "Send review", () {}),
              Divider(color: Colors.black45,height: 0.5,thickness: 1,),
              buildMenuItem(Icons.lightbulb, "Help", () {}),
            ]),
          ],
        ),
      ),
    );
  }



  /// **Common Method for Expandable Menus**
  Widget buildExpandableMenu(String title, List<Widget> children) {
    return ExpansionTile(
      dense: true,
      title: Text(title, style: TextStyle(fontSize: 14, color: Colors.grey)),
      children: children,
      collapsedIconColor: Colors.white60,
      iconColor: Colors.white60,
    );
  }

  Widget buildMenuItem( IconData icon,  String title,  VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: AppColors.liteGrayColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Icon(icon, size: 25, color: AppColors.whiteColor),
              SizedBox(width: 20),
              Text(title, style: AppTextStyles.medium(fontSize: 14.0, fontColor: AppColors.whiteColor)),
            ],
          ),
        ),
      ),
    );
  }

}
