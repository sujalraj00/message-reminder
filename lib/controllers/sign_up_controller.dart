import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();


  // Variables
  final hidePassword = true.obs; // observable for hiding / showing pass
  final privacyPolicy = true.obs; // observable for privacy policy accept
  final email = TextEditingController(); // controller for email input
  final lastName = TextEditingController(); // controller for last name input
  final username = TextEditingController(); // controller for user name input
  final password = TextEditingController(); // controller for password input
  final firstName = TextEditingController(); // controller for first name input
  final phoneNumber = TextEditingController(); // controller for phone number input
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>(); // form key for more validation

Future<void > signup () async{}

}