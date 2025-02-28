import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var showAccountField = false.obs;
}
