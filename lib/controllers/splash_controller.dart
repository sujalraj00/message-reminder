import 'package:get/get.dart';
import 'package:message_reminder/Authentication/authentication_repository.dart';

import '../res/routes/route_name.dart';


class SplashController extends GetxController{
  SplashController();

  // @override
  // void onInit() {
  //   navigateScreen();
  //   super.onInit();
  // }
  //
  // void navigateScreen() {
  //   Future.delayed(const Duration(seconds: 2), (){
  //     Get.offNamed(RouteName.onboarding);
  //   });
  // }
  @override
  void onReady() {
    super.onReady();
    // Simulate some delay for initialization or loading
    Future.delayed(Duration(seconds: 3), () {
      AuthenticationRepository.instance.screenRedirect();
    });
  }


}