import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:message_reminder/controllers/onboarding_controller.dart';
import 'package:message_reminder/res/consts/t_images.dart';
import 'package:message_reminder/widgets/onboarding_dot_navigation.dart';
import 'package:message_reminder/widgets/onboarding_nextbutton.dart';
import 'package:message_reminder/widgets/onboarding_page.dart';
import 'package:message_reminder/widgets/onboarding_skip.dart';


class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    return   Scaffold(
      body: Stack(
        children: [
          // horizontal scrollable page
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image:"assets/onboarding/onboard0.png",
                title: "Choose your product",
                subTitle:"Welcome to a World of Limitless Choices - Your Perfect Product Awaits!"),
              OnBoardingPage(
                image: "assets/onboarding/onboard1.png",
                title: "Select Payment Method",
                subTitle:"For Seamless Transactions, Choose Your Payment Path - Your Convenience, Our Priority!"),
              OnBoardingPage(
                image: "assets/onboarding/onboard2.png",
                title: "Deliver at your door step",
                subTitle: "From Our Doorstep to Yours - Swift, Secure, and Contactless Delivery!"),
            ],
          ),
          // skip button
          const OnBoardingSkip(),

          // dot navigation smooth page indicator
          const OnBoardingDotNavigation(),

          // circular button
          const OnBoardingNextButton( )
        ],
      ),
    );
  }
}
