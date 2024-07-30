import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:message_reminder/Authentication/authentication_repository.dart';
import 'package:message_reminder/Authentication/loaders.dart';
import 'package:message_reminder/Authentication/network_manager.dart';
import 'package:message_reminder/Authentication/user_repository.dart';
import 'package:message_reminder/Authentication/verify_email_screen.dart';
import 'package:message_reminder/models/user_model.dart';
import 'package:message_reminder/res/consts/t_images.dart';
import 'package:message_reminder/widgets/full_screen_loader.dart';

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

  // --- SIGNUP
  Future<void> signup() async {
    try {
      // Start loading
      TFullScreenLoader.openLoadingDialog(
          'we are processing your information....', TImages.docerAnimation);

      // check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        // remove loader
        TFullScreenLoader.stopLoading();
        return;
      }

      // form validation
      if (!signupFormKey.currentState!.validate()) {
        // remove loader
        TFullScreenLoader.stopLoading();
        return;
      }


      // privacy policy check
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message: 'In order to create account, you must have to read and accept the Privacy Policy & Terms of Use.'
        );
        return;
      }

      // register user in firebase auth & save user data in the firebase
      final userCredential = await AuthenticationRepository.instance.registerWithEmailAndPassword(email.text.trim(), password.text.trim());

      // save authenticated user data in firebase FireStore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName : lastName.text.trim(),
        username : username.text.trim(),
        email : email.text.trim(),
        phoneNumber : phoneNumber.text.trim(),
        profilePicture : '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // remove loader
      TFullScreenLoader.stopLoading();

      // show success message
      TLoaders.successSnackBar(title: 'Congratulations', message: 'Your account has been created verify email to continue');

      // move to verify  email screen
      Get.to(() =>  VerifyEmailScreen(email: email.text.trim()));

    } catch (e) {
      // remove loader
      TFullScreenLoader.stopLoading();

      // show some generic error to user
      TLoaders.errorSnackBar(title: 'Oh snap!', message: e.toString());
    }
  }

}