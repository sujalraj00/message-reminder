import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../res/helper/show_snackbar.dart';

class FireBaseAuthMethods{
  final FirebaseAuth _auth;
  FireBaseAuthMethods(this._auth);

  User get user => _auth.currentUser!;

  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();

  // facebook sign in
// Future<void> signInWithFacebook (BuildContext context) async{
//   try{
//     final LoginResult loginResult = await FacebookAuth.instance.login();
//
//     final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);
//
//     await _auth.signInWithCredential(facebookAuthCredential);
//
//   } on FirebaseAuthException catch(e){
//     showSnackBar( context,e.message!);
//   }
// }
}