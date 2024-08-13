import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:message_reminder/Authentication/authentication_repository.dart';
import 'package:message_reminder/Authentication/loaders.dart';
import 'package:message_reminder/Authentication/network_manager.dart';
import 'package:message_reminder/res/consts/t_images.dart';
import 'package:message_reminder/res/screens/reset_password_screen.dart';
import 'package:message_reminder/widgets/full_screen_loader.dart';

class ForgetPasswordController extends GetxController{
  static ForgetPasswordController get instance => Get.find();

  // variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey= GlobalKey<FormState>();

  // send reset pass email
  sendPasswordResetEmail() async{
    try{
      // start loading
      TFullScreenLoader.openLoadingDialog('Processing your request....', TImages.docerAnimation);

      // check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {TFullScreenLoader.stopLoading(); return;}

      // form validation
      if(!forgetPasswordFormKey.currentState!.validate()){
        TFullScreenLoader.stopLoading();
        return;
      }

      // send email to reset pass
      await AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      // remove loader
      TFullScreenLoader.stopLoading();

      // show success screen
      TLoaders.successSnackBar(title: 'Email Sent', message: 'Email Link Sent to Reset your Password'.tr);

      // redirect
      Get.to(() => ResetPasswordScreen(email: email.text.trim()));

    } catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());

    }
  }

  resendPasswordResetEmail(String email) async{
    try{
      TFullScreenLoader.openLoadingDialog('Processing your request....', TImages.docerAnimation);

      // check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {TFullScreenLoader.stopLoading(); return;}

      // send email to reset pass
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      // remove loader
      TFullScreenLoader.stopLoading();

      // show success screen
      TLoaders.successSnackBar(title: 'Email Sent', message: 'Email Link Sent to Reset your Password'.tr);


    } catch(e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap',message: e.toString());
    }
  }
}