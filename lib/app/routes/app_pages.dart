import 'package:flutter/cupertino.dart';

import 'package:get/get.dart';

import '../modules/add_paymennt/bindings/add_paymennt_binding.dart';
import '../modules/add_paymennt/views/add_paymennt_view.dart';
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
import '../modules/cash_sale/bindings/cash_sale_binding.dart';
import '../modules/cash_sale/views/cash_sale_view.dart';
import '../modules/customers_list/bindings/customers_list_binding.dart';
import '../modules/customers_list/views/customers_list_view.dart';
import '../modules/drawer/bindings/drawer_binding.dart';
import '../modules/drawer/views/drawer_view.dart';
import '../modules/dropbox/bindings/dropbox_binding.dart';
import '../modules/dropbox/views/dropbox_view.dart';
import '../modules/estimate/bindings/estimate_binding.dart';
import '../modules/estimate/views/estimate_view.dart';
import '../modules/expiring_quotes/bindings/expiring_quotes_binding.dart';
import '../modules/expiring_quotes/views/expiring_quotes_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/customers/bindings/customer_binding.dart';
import '../modules/home/views/customers/bindings/customer_details_binding.dart';
import '../modules/home/views/customers/views/customer_details_view.dart';
import '../modules/home/views/customers/views/customers_view.dart';
import '../modules/home/views/home_view.dart';
import '../modules/invoice/bindings/invoice_binding.dart';
import '../modules/invoice/views/invoice_view.dart';
import '../modules/items/bindings/items_binding.dart';
import '../modules/items/views/items_view.dart';
import '../modules/new_project/bindings/new_project_binding.dart';
import '../modules/new_project/views/new_project_view.dart';
import '../modules/purchase_orders/bindings/purchase_orders_binding.dart';
import '../modules/purchase_orders/views/purchase_orders_view.dart';
import '../modules/quotes/bindings/quotes_binding.dart';
import '../modules/quotes/views/quotes_view.dart';
import '../modules/reports/bindings/reports_binding.dart';
import '../modules/reports/views/reports_view.dart';
import '../modules/sales_order/bindings/sales_order_binding.dart';
import '../modules/sales_order/views/sales_order_view.dart';
import '../modules/scan_barcodes/bindings/scan_barcodes_binding.dart';
import '../modules/scan_barcodes/views/scan_barcodes_view.dart';
import '../modules/statements/bindings/statements_binding.dart';
import '../modules/statements/views/statements_view.dart';
import '../modules/tools/lists/bindings/lists_binding.dart';
import '../modules/tools/lists/views/lists_view.dart';
import '../modules/tools/manage_data/bindings/manage_data_binding.dart';
import '../modules/tools/manage_data/views/manage_data_view.dart';
import '../modules/tools/settings/app_settings/bindings/app_settings_binding.dart';
import '../modules/tools/settings/app_settings/views/app_settings_view.dart';
import '../modules/transactions/bindings/transactions_binding.dart';
import '../modules/transactions/views/transactions_view.dart';
import '../modules/vendors/bindings/vendors_binding.dart';
import '../modules/vendors/views/vendors_view.dart';
import '../modules/whats_new/bindings/whats_new_binding.dart';
import '../modules/whats_new/views/whats_new_view.dart';

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
      binding: WhatsNewBinding(),
    ),
    GetPage(
      name: _Paths.LISTS,
      page: () => ListsView(),
      binding: ListsBinding(),
    ),
    GetPage(
      name: _Paths.ITEMS,
      page: () => const ItemsView(),
      binding: ItemsBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMERS_LIST,
      page: () => const CustomersListView(),
      binding: CustomersListBinding(),
    ),
    GetPage(
      name: _Paths.ESTIMATE,
      page: () => const EstimateView(),
      binding: EstimateBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PROJECT,
      page: () => const NewProjectView(),
      binding: NewProjectBinding(),
    ),
    GetPage(
      name: _Paths.SALES_ORDER,
      page: () => const SalesOrderView(),
      binding: SalesOrderBinding(),
    ),
    GetPage(
      name: _Paths.CASH_SALE,
      page: () => CashSaleView(),
      binding: CashSaleBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PAYMENNT,
      page: () => const AddPaymenntView(),
      binding: AddPaymenntBinding(),
    ),
    GetPage(
      name: _Paths.INVOICE,
      page: () => const InvoiceView(),
      binding: InvoiceBinding(),
    ),
    GetPage(
      name: _Paths.SCAN_BARCODES,
      page: () => const ScanBarcodesView(),
      binding: ScanBarcodesBinding(),
    ),
    GetPage(
      name: _Paths.STATEMENTS,
      page: () => StatementsView(),
      binding: StatementsBinding(),
    ),
    GetPage(
      name: _Paths.REPORTS,
      page: () => ReportsView(),
      binding: ReportsBinding(),
    ),
    GetPage(
      name: _Paths.VENDORS,
      page: () => const VendorsView(),
      binding: VendorsBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTIONS,
      page: () => const TransactionsView(),
      binding: TransactionsBinding(),
    ),
    GetPage(
      name: _Paths.PURCHASE_ORDERS,
      page: () => const PurchaseOrdersView(),
      binding: PurchaseOrdersBinding(),
    ),
    GetPage(
      name: _Paths.QUOTES,
      page: () => const QuotesView(),
      binding: QuotesBinding(),
    ),
    GetPage(
      name: _Paths.EXPIRING_QUOTES,
      page: () => const ExpiringQuotesView(),
      binding: ExpiringQuotesBinding(),
    ),
  ];
}
