import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../controllers/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            children: [
              const Spacer(),
              Image.asset( "assets/splash_icon/splash_chat3.png"),
              const Spacer(),
              const Text('powered by s.raj'),
              const SizedBox(height: 10,)
            ],
          ),
        )
    );
  }
}