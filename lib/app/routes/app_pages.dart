import 'package:get/get.dart';

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
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
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
      name: _Paths.DRAWER,
      page: () => const DrawerView(),
      binding: DrawerBinding(),
    ),
  ];
}
