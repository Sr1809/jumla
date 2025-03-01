import 'package:get/get.dart';

import '../modules/auth/add_company_name_address/bindings/add_company_name_address_binding.dart';
import '../modules/auth/add_company_name_address/views/add_company_name_address_view.dart';
import '../modules/auth/company_info_note/bindings/company_info_note_binding.dart';
import '../modules/auth/company_info_note/views/company_info_note_view.dart';
import '../modules/auth/login/bindings/login_binding.dart';
import '../modules/auth/login/views/login_view.dart';
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
  ];
}
