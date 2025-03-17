import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jumla/app/modules/home/views/customers/bindings/customer_details_binding.dart';
import 'package:jumla/app/modules/home/views/customers/views/customer_details_view.dart';
import 'package:jumla/app/modules/tools/lists/bindings/lists_binding.dart';
import 'package:jumla/app/modules/tools/lists/views/lists_view.dart';
import 'package:jumla/app/modules/tools/settings/app_settings/bindings/app_settings_binding.dart';
import 'package:jumla/app/modules/tools/settings/app_settings/views/app_settings_view.dart';
import 'package:jumla/app/modules/whats_new/bindings/whats_new_binding.dart';
import 'package:jumla/app/modules/whats_new/views/whats_new_view.dart';

import '../modules/auth/add_company_name_address/bindings/add_company_name_address_binding.dart';
import '../modules/auth/add_company_name_address/views/add_company_name_address_view.dart';
import '../modules/auth/add_currency_date_formats/bindings/add_currency_date_formats_binding.dart';
import '../modules/auth/add_currency_date_formats/views/add_currency_date_formats_view.dart';
import '../modules/auth/add_device_name/bindings/add_device_name_binding.dart';
import '../modules/auth/add_device_name/views/add_device_name_view.dart';
import '../modules/auth/add_tax_code_data/bindings/add_tax_code_data_binding.dart';
import '../modules/auth/add_tax_code_data/views/add_tax_code_data_view.dart';
import '../modules/auth/add_tax_setup/bindings/add_tax_setup_binding.dart';
import '../modules/auth/add_tax_setup/views/add_tax_setup_view.dart';
import '../modules/auth/company_info_note/bindings/company_info_note_binding.dart';
import '../modules/auth/company_info_note/views/company_info_note_view.dart';
import '../modules/auth/login/bindings/login_binding.dart';
import '../modules/auth/login/views/login_view.dart';
import '../modules/drawer/bindings/drawer_binding.dart';
import '../modules/drawer/views/drawer_view.dart';
import '../modules/dropbox/bindings/dropbox_binding.dart';
import '../modules/dropbox/views/dropbox_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/customers/bindings/customer_binding.dart';
import '../modules/home/views/customers/views/customers_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/tools/manage_data/bindings/manage_data_binding.dart';
import '../modules/tools/manage_data/views/manage_data_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.COMPANY_INFO_NOTE,
      page: () => const CompanyInfoNoteView(),
      binding: CompanyInfoNoteBinding(),
    ),
    GetPage(
      name: _Paths.ADD_COMPANY_NAME_ADDRESS,
      page: () => const AddCompanyNameAddressView(),
      binding: AddCompanyNameAddressBinding(),
    ),
    GetPage(
      name: _Paths.ADD_CURRENCY_DATE_FORMATS,
      page: () => const AddCurrencyDateFormatsView(),
      binding: AddCurrencyDateFormatsBinding(),
    ),
    GetPage(
      name: _Paths.ADD_TAX_SETUP,
      page: () => const AddTaxSetupView(),
      binding: AddTaxSetupBinding(),
    ),
    GetPage(
      name: _Paths.ADD_TAX_CODE_DATA,
      page: () => const AddTaxCodeDataView(),
      binding: AddTaxCodeDataBinding(),
    ),
    GetPage(
      name: _Paths.ADD_DEVICE_NAME,
      page: () => const AddDeviceNameView(),
      binding: AddDeviceNameBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMERS,
      page: () => CustomersView(),
      binding: CustomersBinding(),
    ),
    GetPage(
      name: _Paths.DRAWER,
      page: () => const DrawerView(),
      binding: DrawerBinding(),
    ),
    GetPage(
      name: _Paths.DROPBOX,
      page: () => const DropboxView(),
      binding: DropboxBinding(),
    ),
    GetPage(
      name: _Paths.MANAGE_DATA,
      page: () => const ManageDataView(),
      binding: ManageDataBinding(),
    ),
    GetPage(
      name: _Paths.APP_SETTINGS,
      page: () => const AppSettingsView(),
      binding: AppSettingsBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_DETAILS,
      page: () => CustomersDetailsView(),
      binding: CustomersDetailsBinding(),
    ),
    GetPage(
      name: _Paths.WHATS_NEW,
      page: () => WhatsNewView(),
      binding: WhatsNewBinding(),),
    GetPage(
      name: _Paths.LISTS,
      page: () => ListsView(),
      binding: ListsBinding(),),
  ];
}
