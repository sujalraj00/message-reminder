import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:message_reminder/Authentication/authentication_repository.dart';
import 'package:message_reminder/controllers/verify_email_controller.dart';
import 'package:message_reminder/res/consts/t_images.dart';
import 'package:message_reminder/res/helper/helper_function.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key, this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put( VerifyEmailController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => AuthenticationRepository.instance.logout(), icon:  const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // images
              Image(image: const  AssetImage(TImages.deliveredEmailIllustration), width: THelperFunctions.screenWidth() * 0.6 ),
              const SizedBox(height: 32),

              // title and subtitle
              Text("Verify your email address!", style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
              const SizedBox(height: 16),
              Text(email ?? '', style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center,),
              const SizedBox(height: 16),
              Text("Congratulations! Your Account Awaits: Verify Your Email to Start Shopping and Experience a World of Unrivaled Deals and Personalized Offers.",
                style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),
              const SizedBox(height:32),

              // buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  // success screen
                  onPressed: () => controller.checkEmailVerificationStatus(),
                  child: const Text('Continue'),),),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: TextButton(onPressed: () => controller.sendEmailVerification(),
                  child: const Text('resend email'),),),
            ],
          ),
        ),
      ),
    );
  }
}
