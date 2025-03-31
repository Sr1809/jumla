import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumla/app/modules/tools/lists/views/email_template_view.dart';
import 'package:jumla/app/modules/tools/lists/views/payment_methods_view.dart';
import 'package:jumla/app/modules/tools/lists/views/payment_terms_view.dart';
import 'package:jumla/app/modules/tools/lists/views/price_levels_view.dart';
import 'package:jumla/app/modules/tools/lists/views/print_templates_view.dart';
import 'package:jumla/app/modules/tools/lists/views/project_fields_view.dart';
import 'package:jumla/app/modules/tools/lists/views/sms_templates_view.dart';
import 'package:jumla/app/modules/tools/lists/views/tac_codes_view.dart';
import 'package:jumla/app/modules/tools/lists/views/transaction_body_fields_view.dart';
import 'package:jumla/app/modules/tools/lists/views/transaction_line_fields_view.dart';
import 'package:jumla/app/modules/tools/lists/views/transaction_statuses_view.dart';
import 'package:jumla/app/routes/app_pages.dart';

import '../../../../common/common_appbar.dart';
import '../../../../core/app_storage.dart';
import '../../../../resources/app_colors.dart';
import '../../../../resources/app_styles.dart';
import '../../settings/app_settings/views/tax_code_view.dart';
import '../controllers/lists_controller.dart';
import 'company_fields_view.dart';
import 'customer_fields_view.dart';
import 'item_categories_view.dart';
import 'item_fields_view.dart';

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
      appBar: CommonAppBar(
        title: "Lists",
        showBackButton: true,
      ),
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
                        .map((item) => _listItem(item, itemFontSize, context))
                        .toList(),
                  )),

              /// **Other Lists Section**
              _sectionHeader("OTHER LISTS", titleFontSize),
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: controller.otherLists
                        .map((item) => _listItem(item, itemFontSize, context))
                        .toList(),
                  )),

              /// **Custom Fields Section**
              _sectionHeader("CUSTOM FIELDS", titleFontSize),
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: controller.customFields
                        .map((item) => _listItem(item, itemFontSize, context))
                        .toList(),
                  )),

              /// **Templates Section**
              _sectionHeader("TEMPLATES", titleFontSize),
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: controller.templates
                        .map((item) => _listItem(item, itemFontSize, context))
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
  Widget _listItem(String title, double fontSize, context) {
    return InkWell(
      onTap: () {
        if (title == "SMS Templates") {
          Get.to(() => SmsTemplatesView());
        } else if (title == "Email Templates") {
          Get.to(() => EmailTemplatesView());
        } else if (title == "Print Templates") {
          Get.to(() => PrintTemplatesView());
        } else if (title == "Company Fields") {
          Get.to(() => CompanyFieldListView());
        } else if (title == "Project Fields") {
          Get.to(() => ProjectFieldListView());
        } else if (title == "Transaction Line Fields") {
          Get.to(() => TransactionLineFieldsListView());
        } else if (title == "Transaction Body Fields") {
          Get.to(() => TransactionBodyFieldsListView());
        } else if (title == "Item Fields") {
          Get.to(() => ItemFieldListView("list"));
        } else if (title == "Customer Fields") {
          Get.to(() => CustomerFieldsListView());
        } else if (title == "Item Categories") {
          Get.to(() => ItemCategoryListView("list"));
        }else if (title == "Price Levels") {
          Get.to(() => PriceLevelListView("list"));
        }else if (title == "Payment Methods") {
          Get.to(() => PaymentMethodListView());
        }else if (title == "Terms") {
          Get.to(() => PaymentTermListView());
        }else if (title == "Tax Codes") {
          Get.to(() => TaxCodeListView("list"));
        } else if (title == "Transaction statuses") {
          showDialog(
              context: context, builder: (_) => TransactionStatusPopup());
        }else if (title == "Items") {
         Get.toNamed(Routes.ITEMS);
        }
        else if (title == "Customers") {
          Get.toNamed(Routes.CUSTOMERS_LIST);
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

class TransactionStatusPopup extends StatelessWidget {
  const TransactionStatusPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Transaction Status",
          style: AppTextStyles.bold(
              fontSize: 18.0, fontColor: AppColors.blackColor)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOption("Quote status", () {
            Get.back();
            Get.to(() =>
                StatusListScreen(title: "Quote Status", showProbability: true));
          }),
          _buildOption("Sales Order status", () {
            Get.back();
            Get.to(() => StatusListScreen(title: "Sales Order Status"));
          }),
          _buildOption("Invoice status", () {
            Get.back();
            Get.to(() => StatusListScreen(title: "Invoice Status"));
          }),
          _buildOption("Cash Sale status", () {
            Get.back();
            Get.to(() => StatusListScreen(title: "Cash Sale Status"));
          }),
          _buildOption("Purchase Order status", () {
            Get.back();
            Get.to(() => StatusListScreen(title: "Purchase Order Status"));
          }),
        ],
      ),
    );
  }

  Widget _buildOption(String title, onTap) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
    );
  }
}
