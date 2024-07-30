import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:message_reminder/controllers/onboarding_controller.dart';
import 'package:message_reminder/res/consts/t_colors.dart';
import 'package:message_reminder/res/helper/helper_function.dart';


class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Positioned(
        right: 24,
        bottom: kBottomNavigationBarHeight,
        child: ElevatedButton(
            onPressed: () => OnBoardingController.instance.nextPage(),
            style: ElevatedButton.styleFrom(shape: const CircleBorder(), backgroundColor: dark? TColors.primary: Colors.black ),
            child: const Icon(Iconsax.arrow_right_3)));
  }
}