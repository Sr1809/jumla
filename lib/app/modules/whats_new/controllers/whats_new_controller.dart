import 'package:get/get.dart';

class WhatsNewController extends GetxController {
  //TODO: Implement WhatsNewController

  var version = "1.6.0".obs;

  var whatsNewList = [
    "Support for Android 12 devices",
    'For Android 11 and above, "mobilebiz-co"',
    "Fix for using current location as billing"
  ].obs;

  var bugFixesList = [
    "Fixes on tax computations",
    "Fixes on apply discount for Android",
    "Fixes on watermarks for cash sale"
  ].obs;

  var licenseText = """
END-USER LICENSE AGREEMENT FOR MOBILEBIZ IMPORTANT PLEASE READ THE TERMS AND CONDITIONS OF THIS LICENSE AGREEMENT CAREFULLY.
1. GRANT OF LICENSE
   MobileBiz Systems grants you the right to install and use copies of the SOFTWARE PRODUCT on your Android device.
2. DESCRIPTION OF OTHER RIGHTS AND LIMITATIONS
   You may not distribute registered copies of the SOFTWARE PRODUCT to third parties.
3. TERMINATION
   MobileBiz Systems may terminate this EULA if you fail to comply with the terms and conditions.
4. COPYRIGHT
   All title, including but not limited to copyrights, in and to the SOFTWARE PRODUCT are owned by MobileBiz Systems.
5. NO WARRANTIES
   MobileBiz Systems expressly disclaims any warranty for the SOFTWARE PRODUCT.
6. LIMITATION OF LIABILITY
   In no event shall MobileBiz Systems be liable for any damages including lost profits, business interruption, or lost information.
""".obs;
}
