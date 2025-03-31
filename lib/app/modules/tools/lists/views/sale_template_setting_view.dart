import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/common/common_appbar.dart';
import 'package:jumla/app/core/app_storage.dart';
import 'package:jumla/app/resources/app_colors.dart';

import 'sale_template_field_view.dart';

class SalesTemplateSettingsView extends StatelessWidget {
  final List<String> settings = [
    'Margin top',
    'Margin left',
    'Margin right',
    'Margin bottom',
    'Color',
    'Font size (PDF)',
    'Font size (HTML)',
    'Line height (PDF)',
    'Line height (HTML)',
    'Company logo',
    'Company Name',
    'Company details',
    'Bill To label',
    'Bill To',
    'Ship To label',
    'Ship To',
    'Transaction No',
    'Transaction Details',
    'Sale Item labels',
    'Sale Item field tags',
    'Sale Total Labels',
    'Sale Totals',
    'Additional blocks headers',
    'Additional blocks',
    'Payment Details label',
    'Payment Details',
    'Other Info label',
    'Other Information',
    'Signature Text',
    'Signature Details',
    'Transaction Notes',
    'Footer text',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBarWithTitleAndIcon(title: "Jumla Sales Template",hideLogo: true,),
      body: ListView(
        children: [
          Container(
            color: AppStorages.appColor.value.withOpacity(0.2),
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'General settings',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppStorages.appColor.value,
              ),
            ),
          ),
          ...settings.map((setting) => ListTile(
            title: Text(setting),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Get.to(()=>SalesTemplateFieldScreen(title: setting,));
              // Handle tap if needed
            },
          )),
        ],
      ),
    );
  }
}
