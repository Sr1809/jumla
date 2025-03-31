import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jumla/app/common/common_appbar.dart';
import 'package:jumla/app/common/common_button.dart';
import 'package:jumla/app/common/common_text_field.dart';
import 'package:jumla/app/core/app_storage.dart';
import 'package:jumla/app/resources/app_colors.dart';
import 'package:jumla/app/resources/app_styles.dart';

import '../../../routes/app_pages.dart';
import '../controllers/statements_controller.dart';

class StatementsView extends GetView<StatementsController> {
   StatementsView({super.key});
  final Rx<DateTime> startDate = DateTime(2024, 10, 1).obs;
  final Rx<DateTime> endDate = DateTime(2025, 3, 27).obs;
  final RxBool excludePaid = false.obs;

  final List<Map<String, String>> transactions = [
    {"date": "10/1/24", "invoice": "", "desc": "Previous balance (forwarded)"},
    {"date": "3/15/25", "invoice": "CASHSLE#001", "desc": "New sale"},
    {"date": "3/24/25", "invoice": "CASHSLE#003", "desc": "New sale"},
    {"date": "3/24/25", "invoice": "CASHSLE#002", "desc": "New sale"},
    {"date": "3/24/25", "invoice": "CASHSLE#004", "desc": "New sale"},
    {"date": "3/25/25", "invoice": "CASHSLE#005", "desc": "New sale"},
    {"date": "3/25/25", "invoice": "INVOICE#001", "desc": "New sale"},
    {"date": "3/25/25", "invoice": "CASHSLE#006", "desc": "New sale"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(title: "Statement",hideLogo: true,),
      body: Column(
        children: [
          SizedBox(height: 10,),
          CommonElevatedButton(text: "Select a Customer", onPressed: ()=>Get.toNamed(Routes.CUSTOMERS_LIST,arguments: "from")),
          SizedBox(height: 10,),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color:AppStorages.appColor.value.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Obx(()=> GestureDetector(
                   onTap: ()=>controller.showPopup(context),
                   child: AbsorbPointer(child: CommonTextField(label: "Invoice & Cash Sales", controller: TextEditingController(text: controller.selectedSaleType.value))))),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Obx(() => CommonElevatedButton(
                      onPressed: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: startDate.value,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                        );
                        if (picked != null) startDate.value = picked;
                      },
                      text: "${startDate.value.month}/${startDate.value.day}/${startDate.value.year}",
                    )),
                    const SizedBox(width: 8),
                    Obx(() => CommonElevatedButton(
                      onPressed: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: endDate.value,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2030),
                        );
                        if (picked != null) endDate.value = picked;
                      },
                    text: "${endDate.value.month}/${endDate.value.day}/${endDate.value.year}",
                    )),
                  ],
                ),
                Obx(() => CheckboxListTile(
                  title:  Text("Don't include paid transactions",style: AppTextStyles.regular(fontSize: 12.0, fontColor: AppColors.blackColor)),
                  value: excludePaid.value,
                  onChanged: (val) => excludePaid.value = val ?? false,
                ))
              ],
            ),
          ),
           Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Account Summary", style: AppTextStyles.semiBold(fontSize: 14.0, fontColor: AppColors.blackColor)),
                SizedBox(height: 8),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Previous Balance", style: AppTextStyles.regular(fontSize: 12.0, fontColor: AppColors.blackColor),), Text("0.00")]),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Credits",style: AppTextStyles.regular(fontSize: 12.0, fontColor: AppColors.blackColor),), Text("0.00")]),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text("Charges",style: AppTextStyles.regular(fontSize: 12.0, fontColor: AppColors.blackColor),), Text("8.92")]),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text("Total Balance Due", style: AppTextStyles.bold(fontSize: 13.0, fontColor: AppColors.blackColor),),
                  Text("8.92", style: TextStyle(fontWeight: FontWeight.bold))
                ]),
              ],
            ),
          ),
          const Divider(thickness: 1),
          Container(
            color: AppStorages.appColor.value,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child:  Row(
              children: [
                Expanded(child: Text("Date", style:  AppTextStyles.bold(fontSize: 13.0, fontColor: AppColors.whiteColor),)),
                Expanded(child: Text("Invoice#", style:  AppTextStyles.bold(fontSize: 13.0, fontColor: AppColors.whiteColor),)),
                Expanded(child: Text("Description", style:  AppTextStyles.bold(fontSize: 13.0, fontColor: AppColors.whiteColor),)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final tx = transactions[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Row(
                    children: [
                      Expanded(child: Text(tx['date'] ?? "")),
                      Expanded(
                          child: Text(
                            tx['invoice'] ?? "",
                            style: TextStyle(
                              color: Colors.cyan.shade800,
                              decoration: TextDecoration.underline,
                            ),
                          )),
                      Expanded(child: Text(tx['desc'] ?? "")),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            color: Colors.blue.shade900,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(child: CommonFullWidthButton(text: "EMAIL", onTap: (){})),
                Expanded(child: CommonFullWidthButton(text: "PREVIEW", onTap: (){})),
                Expanded(child: CommonFullWidthButton(text: "CUSTOMIZE", onTap: (){})),

              ],
            ),
          )
        ],
      ),
    );
  }
}
