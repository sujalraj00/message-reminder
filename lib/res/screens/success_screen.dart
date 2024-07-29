import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:message_reminder/res/helper/helper_function.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.image, required this.title, required this.subTitle, required this.onPressed});

  final String image, title , subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(56) *2,
          child: Column(
            children: [
              // image
              //Image(image: AssetImage(image), width: THelperFunctions.screenWidth() * 0.6 ),
              Lottie.asset(image, width: THelperFunctions.screenWidth() *0.6),

              const SizedBox(height: 32),

              // title and subtitle
              Text(title, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
              const SizedBox(height: 16),
              Text(subTitle, style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),
              const SizedBox(height: 32),

              // buttons
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: onPressed, child: const Text('Continue'),),),
            ],
          ),
        ),
      ),
    );
  }
}
