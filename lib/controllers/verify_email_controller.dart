import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:message_reminder/Authentication/authentication_repository.dart';
import 'package:message_reminder/Authentication/loaders.dart';
import 'package:message_reminder/res/consts/t_images.dart';
import 'package:message_reminder/res/screens/success_screen.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  // send email whenever verify screen appears & set timer for auto redirect
  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  // send email verification link
  sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      TLoaders.successSnackBar(title: 'Email Sent!',
          message: 'please check your inbox and verify your email.');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh! Snap', message: e.toString());
    }
  }

// timer to automatically redirect on email verification

  setTimerForAutoRedirect() {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() =>
            SuccessScreen(image: TImages.successfullyRegisterAnimation,
                title: "Your account successfully created!",
                subTitle: "Welcome to Your Ultimate Shopping Destination: Your Account is Created, Unleash the Joy of Seamless Online Shopping!",
                onPressed: () =>
                    AuthenticationRepository.instance.screenRedirect()));
      }
    }
    );
  }


// manually check if email verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() =>
          SuccessScreen(image: TImages.successfullyRegisterAnimation,
              title: "Your account successfully created!",
              subTitle: "Welcome to Your Ultimate Shopping Destination: Your Account is Created, Unleash the Joy of Seamless Online Shopping!",
              onPressed: () =>
                  AuthenticationRepository.instance.screenRedirect()));
    }
  }

}