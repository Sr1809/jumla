import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/common/common_appbar.dart';
import 'package:jumla/app/modules/home/views/customers/controllers/customer_detail_controller.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:jumla/app/resources/app_styles.dart';

class CustomersDetailsView extends GetView<CustomerDetailController> {
  CustomersDetailsView({super.key});
  final CustomerDetailController customerController =
      Get.put(CustomerDetailController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE9E9E9),
      appBar: CommonAppBar(title: "Customers", showBackButton: false, actions: [
        Icon(Icons.edit, color: AppColors.whiteColor),
        SizedBox(width: 12),
        Icon(Icons.keyboard_arrow_down, color: AppColors.whiteColor),
        SizedBox(width: 12),
      ]),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Anonymous Customer",
                  style: AppTextStyles.medium(
                      fontSize: 18.0, fontColor: AppColors.blackColor),
                ),
                Text(
                  "Company",
                  style: AppTextStyles.regular(
                      fontSize: 14.0, fontColor: Color(0xff323232)),
                ),
              ],
            ),
          ),
          // Divider(color: AppColors.lightGrey, height: 1.0),
          customHorizontal(),
          // Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Address
                  Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 16.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.home,
                                    size: 20, color: Colors.black54),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    "4309 S Morgan Street, Chicago, IL, United States 60609",
                                    style: AppTextStyles.medium(
                                        fontSize: 14.0,
                                        fontColor: Color(0xff323232)),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),

                            // Phone
                            Row(
                              children: [
                                Icon(Icons.phone, size: 20, color: Colors.blue),
                                SizedBox(width: 8),
                                Text(
                                  "8557765",
                                  style: AppTextStyles.regular(
                                      fontSize: 14.0, fontColor: Colors.blue),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),

                            // Email
                            Row(
                              children: [
                                Icon(Icons.email, size: 20, color: Colors.blue),
                                SizedBox(width: 8),
                                Text(
                                  "anonymous@mycompany.com",
                                  style: AppTextStyles.regular(
                                      fontSize: 14.0, fontColor: Colors.blue),
                                ),
                              ],
                            ),
                          ])),
                  Divider(
                      color: AppColors.lightGrey, height: 2.0, thickness: 0.5),

                  // Company Info Section
                  _buildInfoRow("Type", "Company"),
                  _buildInfoRow("Is Public", "Yes"),
                  _buildInfoRow("Taxable", "Yes (VAT)"),
                  _buildInfoRow("Price Level", "Base Price 0%"),
                  _buildInfoRow("Terms", "Same day"),

                  Divider(
                      color: AppColors.lightGrey, height: 12.0, thickness: 0.5),

                  // Created / Updated Section
                  _buildInfoRow("Created by", "Nimik Zadafiya 27/02/25"),
                  _buildInfoRow("Updated by", "Nimik Zadafiya 27/02/25"),
                  _buildInfoRow("MobileBiz Id", "1"),
                  _buildInfoRow("External Id", "-"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Custom Method for Info Rows
  Widget _buildInfoRow(String title, String value) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                "$title: ",
                style: AppTextStyles.bold(
                    fontSize: 14.0, fontColor: AppColors.blackColor),
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                value,
                style: AppTextStyles.medium(
                    fontSize: 14.0, fontColor: AppColors.blackColor),
              ),
            ),
          ],
        ));
  }

  var tabs = ['Info', "Sales", "Payments", "Projects", "Notes"].obs;
  var selectedIndex = 0.obs;
  customHorizontal() {
    return Obx(() => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(tabs.length, (index) {
              bool isSelected = selectedIndex.value == index;
              return GestureDetector(
                onTap: () {
                  // setState(() {
                  selectedIndex.value = index;
                  // });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 38),
                  decoration: BoxDecoration(
                      color: isSelected ? Colors.white : Color(0xffEAEAEA),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xffC9C9C9),
                            spreadRadius: 1.0,
                            blurRadius: 0.5)
                      ],
                      border: Border(
                        bottom: BorderSide(
                          color: !isSelected
                              ? Color(0xffD7D7D7)
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6.0),
                          topRight: Radius.circular(6.0))),
                  child: Text(tabs[index],
                      style: AppTextStyles.semiBold(
                          fontSize: 16.0, fontColor: AppColors.blackColor)),
                ),
              );
            }),
          ),
        ));
  }
}
