import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:message_reminder/res/consts/t_colors.dart';

class TAnimationLoaderWidget extends StatelessWidget {

  ///default constructor for animation loader
  ///parameters:
  ///text : the text to be displayed below the animation
  ///animation : the path to the lottie animation file
  ///showAction : whether to show an action button below the text
  ///action text :  the text to be displayed on action button
  ///onActionPressed : callback fun to be executed when the action button is pressed


  const TAnimationLoaderWidget(
      {super.key,
        required this.text,
        required this.animation,
        this.showAction = false,
        this.actionText,
        this.onActionPressed});

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation, width: MediaQuery.of(context).size.width * 0.8),   // display lottie animation
          const SizedBox(height: 24),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          showAction
              ? SizedBox(
            width: 250,
            child: OutlinedButton(
              onPressed: onActionPressed,
              style: OutlinedButton.styleFrom(backgroundColor: TColors.dark),
              child: Text(
                actionText!,
                style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.light) ,
              ),
            ),
          )
              : const SizedBox()
        ],
      ),
    );
  }
}
