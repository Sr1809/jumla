import 'package:get/get.dart';

class Customer {
  final String id;
  RxString name;
  RxString email;
  RxString phone;
  RxString address1;
  RxString address2;
  RxString city;
  RxString state;
  RxString country;
  RxString postcode;
  RxString taxCode;
  RxString terms;
  RxString priceLevel;
  RxBool isCompany =  true.obs;
  RxBool isPublic;
  RxBool isTaxable;
  RxBool isActive;

  Customer({
    String? id,
    required String name,
    String email = '',
    String phone = '',
    String address1 = '',
    String address2 = '',
    String city = '',
    String state = '',
    String country = '',
    String postcode = '',
    String taxCode = '',
    String terms = '',
    String priceLevel = '',
    bool isCompany = true,
    bool isPublic = false,
    bool isTaxable = false,
    bool isActive = true,
  })  : id = id ?? DateTime.now().toString(),
        name = name.obs,
        email = email.obs,
        phone = phone.obs,
        address1 = address1.obs,
        address2 = address2.obs,
        city = city.obs,
        state = state.obs,
        country = country.obs,
        postcode = postcode.obs,
        taxCode = taxCode.obs,
        terms = terms.obs,
        priceLevel = priceLevel.obs,
        isCompany = isCompany.obs,
        isPublic = isPublic.obs,
        isTaxable = isTaxable.obs,
        isActive = isActive.obs;
}
