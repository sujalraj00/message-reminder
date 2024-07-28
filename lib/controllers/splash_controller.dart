import 'package:get/get.dart';

import '../res/routes/route_name.dart';


class SplashController extends GetxController{
  SplashController();

  @override
  void onInit() {
    navigateScreen();
    super.onInit();
  }

  void navigateScreen() {
    Future.delayed(const Duration(seconds: 3), (){
      Get.offNamed(RouteName.onboarding);
    });
  }



}