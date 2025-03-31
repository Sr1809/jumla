import 'package:get/get.dart';

class Item {
  final String id;
  RxString name;
  RxString category;
  RxString description;
  RxString tax;
  RxString type;
  RxString priceUnit;
  RxDouble cost;
  RxDouble price;
  RxBool active;
  RxBool isTaxable;

  Item({
    String? id,
    required String name,
    required String category,
    required String description,
    required String type,
    required String tax,
    required double cost,
    required double price,
    required String priceUnit,
    bool active = true,
    required bool isTaxable,
  })  : id = id ?? DateTime.now().toString(),
        name = name.obs,
        category = category.obs,
        description = description.obs,
        price = price.obs,
        tax = tax.obs,
        priceUnit = priceUnit.obs,
        type = type.obs,
        cost = cost.obs,
        active = active.obs,
  isTaxable = isTaxable.obs;
}


class ItemNote {
  final String note;
  final DateTime date;
  final bool isPublic;

  ItemNote({required this.note, required this.date, this.isPublic = false});
}