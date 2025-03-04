import 'package:get/get.dart';

class AppSettingsController extends GetxController {
  var useScreenUnlock = false.obs;
  var discountBeforeTax = true.obs;
  var noDatesOnNotes = false.obs;
  var createNoteAfterEmailSms = true.obs;
  var showAvailableItemsOnly = false.obs;
  var showOnHandItemsOnly = false.obs;
  var noDeleteOfTransactions = false.obs;
  var useItemPictures = false.obs;
}
