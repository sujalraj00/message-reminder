
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
  // final userController = Get.put(UserController());


  // google sign in
  Future<void> googleSignIn() async{

  }

  Future<void> signInWithFacebook (BuildContext context) async{
    try{
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);

      await _auth.signInWithCredential(facebookAuthCredential);

    } on FirebaseAuthException catch(e){
      showSnackBar(context, e.message!);

    }
  }
}