import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:message_reminder/res/screens/login_screen.dart';


class OnBoardingController extends GetxController{
  static OnBoardingController get instance => Get.find();

  // variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  // update current index with page scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

  //jump to the specific dot selected page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  // update current index and jump to next page
  void nextPage() {
    if(currentPageIndex.value == 2){
      final storage = GetStorage();
      if(kDebugMode){
        print('================GET STORAGE Next Button =====================');
        print(storage.read('IsFirstTime'));
      }
      storage.write('IsFirstTime', false);
      if(kDebugMode){
        print('================GET STORAGE Next Button =====================');
        print(storage.read('IsFirstTime'));
      }
      Get.offAll(const LoginScreen());
    } else{
      int page = currentPageIndex.value +1;
      pageController.jumpToPage(page);
    }
  }

  // update current index and jump to last page
  void skipPage() {
    // currentPageIndex.value = 2;
    // pageController.jumpTo(2);
    Get.to(() => const  LoginScreen());
  }
}