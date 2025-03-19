import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/modules/tools/lists/views/email_template_view.dart';
import 'package:jumla/app/modules/tools/lists/views/print_templates_view.dart';
import 'package:jumla/app/modules/tools/lists/views/sms_templates_view.dart';

import '../../../../common/common_appbar.dart';
import '../../../../core/app_storage.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_styles.dart';
import '../controllers/lists_controller.dart';
import 'company_fields_view.dart';

class ListsView extends GetView<ListsController> {
  const ListsView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth > 600;
    double paddingSize = isTablet ? 40.0 : 20.0;
    double titleFontSize = isTablet ? 24.0 : 18.0;
    double itemFontSize = isTablet ? 20.0 : 16.0;

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: CommonAppBar(title: "Lists", showBackButton: true,),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingSize, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// **Basic Section**
              _sectionHeader("BASIC", titleFontSize),
              Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: controller.basicLists
                    .map((item) => _listItem(item, itemFontSize))
                    .toList(),
              )),

              /// **Other Lists Section**
              _sectionHeader("OTHER LISTS", titleFontSize),
              Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: controller.otherLists
                    .map((item) => _listItem(item, itemFontSize))
                    .toList(),
              )),

              /// **Custom Fields Section**
              _sectionHeader("CUSTOM FIELDS", titleFontSize),
              Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: controller.customFields
                    .map((item) => _listItem(item, itemFontSize))
                    .toList(),
              )),

              /// **Templates Section**
              _sectionHeader("TEMPLATES", titleFontSize),
              Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: controller.templates
                    .map((item) => _listItem(item, itemFontSize))
                    .toList(),
              )),
            ],
          ),
        ),
      ),
    );
  }

  /// **Header for Each Section**
  Widget _sectionHeader(String title, double fontSize) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: AppTextStyles.bold(
                  fontSize: fontSize, fontColor: AppStorages.appColor.value)),
          Container(
            width: double.infinity,
            height: 2,
            color: AppStorages.appColor.value,
            margin: EdgeInsets.only(top: 5),
          ),
        ],
      ),
    );
  }

  /// **Clickable List Item**
  Widget _listItem(String title, double fontSize) {
    return InkWell(
      onTap: () {
        if(title == "SMS Templates"){
          Get.to(()=>SmsTemplatesView());
        }else if(title == "Email Templates"){
          Get.to(()=>EmailTemplatesView());
        }else if(title == "Print Templates"){
          Get.to(()=>PrintTemplatesView());
        }else if(title == "Company Fields"){
          Get.to(()=>CompanyFieldListView());
        }


        },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(title,
            style: AppTextStyles.regular(
                fontSize: fontSize, fontColor: AppColors.blackColor)),
      ),
    );
  }
}
