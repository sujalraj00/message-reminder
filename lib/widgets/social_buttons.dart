import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:message_reminder/controllers/login_controller.dart';
import 'package:message_reminder/fb.dart';
import 'package:message_reminder/services/firebase_auth_method.dart';
import 'package:velocity_x/velocity_x.dart';

import '../res/consts/t_colors.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({
    super.key,

  });



  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            decoration: BoxDecoration(
                border: Border.all(color: TColors.grey),
                borderRadius: BorderRadius.circular(100)),
            child: IconButton(
              onPressed: ()=> controller.googleSignIn(),
              icon: const Image(
                width: 24,
                height: 24,
                image: AssetImage(
                    "assets/splash_icon/google-icon.png"),
              ),
            )),
        const SizedBox(
          width: 16,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: TColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            // onPressed: () {
            //   FireBaseAuthMethods(FirebaseAuth.instance).signInWithFacebook(context);
            // },
            onPressed: () {},
            icon: const Image(
              width: 24,
              height: 24,
              image: AssetImage(
                  "assets/splash_icon/facebook-icon.png"),
            ),
          ),
        ),
      ],
    );
  }
}