import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../res/routes/route_name.dart';


class OnBoardingController extends GetxController{
  OnBoardingController();

  final _currentIndex = 0.obs;
  get currentIndex => _currentIndex.value;
  set  currentIndex(value) => _currentIndex.value = value;

  PageController? pageController;



  changeIndex(int value ){
currentIndex = value;
  }

  changePage(int value){
    pageController?.animateToPage(value, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  onContinueOrSkippedPressed () {
    Get.offNamed(RouteName.login);
  }
}