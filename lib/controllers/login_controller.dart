
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:message_reminder/controllers/user_controller.dart';
import 'package:message_reminder/res/consts/t_images.dart';
import 'package:message_reminder/widgets/full_screen_loader.dart';

import '../Authentication/authentication_repository.dart';
import '../Authentication/loaders.dart';
import '../Authentication/network_manager.dart';
import '../res/helper/show_snackbar.dart';

class LoginController extends GetxController{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // variables
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final localStorage = GetStorage();
  final rememberMe = false.obs;
  final hidePassword = true.obs;
   final userController = Get.put(UserController());

  @override
  void onInit() {
    email.text =  localStorage.read('REMEMBER_ME_EMAIL')  ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD' )  ?? '';
    super.onInit();

  }

  // --- EMail and password SignIn
  Future<void> emailAndPasswordSignIn() async {
    try{
      // start loading
      TFullScreenLoader.openLoadingDialog('Logging you in...', TImages.docerAnimation);

      // check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // form validation
      if(!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // save data if remember me is selected
      if(rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      // login user using email and password auth
      final userCredential = await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      // remove loader
      TFullScreenLoader.stopLoading();

      // redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e){
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  // Google SignIn Auth

  Future<void> googleSignIn() async{
    try{
      // Start loading
      TFullScreenLoader.openLoadingDialog('Logging you in....', TImages.docerAnimation);

      // check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected){
        TFullScreenLoader.stopLoading();
        return ;
      }

      // google auth
      final userCredentials = await AuthenticationRepository.instance.signInWithGoogle();

      // save user record
      await userController.saveUserRecord(userCredentials);

      // remove loader
      TFullScreenLoader.stopLoading();

      // redirect user
      AuthenticationRepository.instance.screenRedirect();
    } catch(e){
      // remove loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap',message:  e.toString());
    }
  }

  // Future<void> signInWithFacebook (BuildContext context) async{
  //   try{
  //     final LoginResult loginResult = await FacebookAuth.instance.login();
  //
  //     final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);
  //
  //     await _auth.signInWithCredential(facebookAuthCredential);
  //
  //   } on FirebaseAuthException catch(e){
  //     showSnackBar(context, e.message!);
  //
  //   }
  // }
}