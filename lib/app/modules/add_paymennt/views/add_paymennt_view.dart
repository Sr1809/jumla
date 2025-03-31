import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../common/common_appbar.dart';
import '../../../common/common_text_field.dart';
import '../../../resources/app_colors.dart';
import '../../../resources/app_styles.dart';
import '../controllers/add_paymennt_controller.dart';

class AddPaymenntView extends GetView<AddPaymenntController> {
  const AddPaymenntView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(
        title: "CASHSALE#____",
        showBackButton: true,
        hideLogo: true,
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: Colors.white),
            onPressed: controller.savePayment,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: controller.selectPaymentMethod,
              child: AbsorbPointer(
                child: Obx(() => CommonTextFieldWithTitle(
                  label: "Pay Method",
                  controller: TextEditingController(text: controller.paymentMethod.value),
                )),
              ),
            ),

            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: controller.selectDate,
                    child: AbsorbPointer(
                      child: Obx(() => CommonTextFieldWithTitle(
                        controller: TextEditingController(text: controller.dateText.value), label: 'Date',
                      )),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CommonTextFieldWithTitle(
                    controller: controller.amountController,
                     label: 'Amount',
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            CommonTextFieldWithTitle(label: "Memo", controller: controller.memoController),
            SizedBox(height: 30),

          ],
        ),
      ),
    );
  }



}
