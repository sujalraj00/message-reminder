
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:message_reminder/Authentication/firebase_auth_exception.dart';
import 'package:message_reminder/Authentication/firebase_exception.dart';
import 'package:message_reminder/Authentication/format_exception.dart';
import 'package:message_reminder/Authentication/platform_exception.dart';
import 'package:message_reminder/Authentication/user_repository.dart';
import 'package:message_reminder/Authentication/verify_email_screen.dart';
import 'package:message_reminder/res/screens/login_screen.dart';
import 'package:message_reminder/res/screens/navigation_menu.dart';
import 'package:message_reminder/res/screens/onboarding.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();

  // --------Variables ---------
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  // get authenticated user data
  User? get authUser => _auth.currentUser;
  // ----- Called from main.dart on app launch
  @override
  void onReady(){
    // remove the native screen
    //FlutterNativeSplash.remove();
    // redirect to the appropriate screen
    super.onReady();
    screenRedirect();
  }

  // --- Function to show Relevant Screen ----
  Future<void> screenRedirect () async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const NavigationMenu());
      } else {
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email,));
      }
    } else {
      bool isFirstTime = deviceStorage.read('IsFirstTime') ?? true;
      if (isFirstTime) {
        deviceStorage.write('IsFirstTime', false);
        Get.offAll(() => const OnBoardingScreen());
      } else {
        Get.offAll(() => const LoginScreen());
      }
    }}
    //   if(kDebugMode){
    //     print('================GET STORAGE Auth Repo=====================');
    //     print(deviceStorage.read('IsFirstTime'));
    //   }
    //   deviceStorage.writeIfNull('IsFirstTime', true);
    //   deviceStorage.read('IsFirstTime') != true ? Get.offAll(() => const LoginScreen()) : Get.offAll(() => const OnBoardingScreen());
    // }

    /* -------------------------Email & Password Sign -IN---------------------------*/

    /// [EMAILAUTHENTICATION] -LogIn
    Future<UserCredential> loginWithEmailAndPassword(String email,
        String password) async {
      try {
        return await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } on FirebaseAuthException catch (e) {
        throw TFirebaseAuthException(e.code).message;
      } on FirebaseException catch (e) {
        throw TFirebaseException(e.code).message;
      } on FormatException catch (_) {
        throw const TFormatException();
      } on PlatformException catch (e) {
        throw TPlatformException(e.code).message;
      } catch (e) {
        throw 'Something went wrong. Please try again.';
      }
    }


    /// [EMAILAUTHENTICATION] -Register
    Future<UserCredential> registerWithEmailAndPassword(String email,
        String password) async {
      try {
        return await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
      } on FirebaseAuthException catch (e) {
        throw TFirebaseAuthException(e.code).message;
      } on FirebaseException catch (e) {
        throw TFirebaseException(e.code).message;
      } on FormatException catch (_) {
        throw const TFormatException();
      } on PlatformException catch (e) {
        throw TPlatformException(e.code).message;
      } catch (e) {
        throw 'Something went wrong. Please try again.';
      }
    }

    /// [EMAILAUTHENTICATION] - Mail verification
    Future<void> sendEmailVerification() async {
      try {
        await _auth.currentUser?.sendEmailVerification();
      } on FirebaseAuthException catch (e) {
        throw TFirebaseAuthException(e.code).message;
      } on FirebaseException catch (e) {
        throw TFirebaseException(e.code).message;
      } on FormatException catch (e) {
        throw const TFormatException();
      } on PlatformException catch (e) {
        throw TPlatformException(e.code).message;
      } catch (e) {
        throw 'Something went wrong. Please try again.';
      }
    }

  //[ReAuthentication]  ReAuthenticate user
  Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async{
    try{
      // create a credential
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

      //RE authenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e){
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_){
      throw const TFormatException();
    }  on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
    /// [EMAIL AUTHENTICATION] -------FORGET PASS

    Future<void> sendPasswordResetEmail(String email) async {
      try {
        await _auth.sendPasswordResetEmail(email: email);
      } on FirebaseAuthException catch (e) {
        throw TFirebaseAuthException(e.code).message;
      } on FirebaseException catch (e) {
        throw TFirebaseException(e.code).message;
      } on FormatException catch (e) {
        throw const TFormatException();
      } on PlatformException catch (e) {
        throw TPlatformException(e.code).message;
      } catch (e) {
        throw 'Something went wrong. Please try again.';
      }
    }


    /*---------------- federated identity and social sign in----------------------*/

    /// [GOOGLE AUTH] - GOOGLE
    Future<UserCredential?> signInWithGoogle() async {
      try {
        // trigger the auth flow
        final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

        // obtain the auth detail from the request
        final GoogleSignInAuthentication? googleAuth = await userAccount
            ?.authentication;

        // create a new credential
        final credentials = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

        // once signed in return the UserCredential
        return await _auth.signInWithCredential(credentials);
      } on FirebaseAuthException catch (e) {
        throw TFirebaseAuthException(e.code).message;
      } on FirebaseException catch (e) {
        throw TFirebaseException(e.code).message;
      } on FormatException catch (_) {
        throw const TFormatException();
      } on PlatformException catch (e) {
        throw TPlatformException(e.code).message;
      } catch (e) {
        if (kDebugMode) print('Something went wrong: $e');
        return null;
      }
    }

    /// [FACEBOOK AUTH]
/*----------------  ./ end federated identity and social sign in---------------*/

    /// [LOGOUT USER] - valid for any auth
    Future<void> logout() async {
      try {
        await GoogleSignIn().signOut();
        await FirebaseAuth.instance.signOut();
        Get.offAll(() => const LoginScreen());
      } on FirebaseAuthException catch (e) {
        throw TFirebaseAuthException(e.code).message;
      } on FirebaseException catch (e) {
        throw TFirebaseException(e.code).message;
      } on FormatException catch (_) {
        throw const TFormatException();
      } on PlatformException catch (e) {
        throw TPlatformException(e.code).message;
      } catch (e) {
        throw 'Something went wrong. Please try again.';
      }
    }

// [DELETE USER] remove account from FireStore acc and auth

  Future<void> deleteAccount() async{
    try{
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e){
      throw TFirebaseException(e.code).message;
    } on FormatException catch (_){
      throw const TFormatException();
    }  on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}