import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:message_reminder/res/consts/colors.dart';
import 'package:message_reminder/res/consts/styles.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../controllers/onboarding_controller.dart';
import '../consts/AppAssets.dart';
import '../consts/AppString.dart';

class OnBoarding extends GetView<OnBoardingController> {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    var titles = [
      AppString.onboardingTitle0,
      AppString.onboardingTitle1,
      AppString.onboardingTitle2
    ];

    var desc = [
      AppString.onboardingDes0,
      AppString.onboardingDes1,
      AppString.onboardingDes2
    ];
    return Scaffold(
      body: PageView.builder(
          itemCount: 3,
          controller: controller.pageController,
          onPageChanged: (value) => controller.changeIndex(value),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top:  50.0, right: 30 , left: 30),
              child: Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: Image.asset(
                        "${AppAssets.onboarding}$index.png", fit: BoxFit.cover,)),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(right: 20, left: 20, top: 20 ),
                      child: Column(
                        children: [
                          Text(
                            titles[index],
                            style: AppStyles().semibold(size: 16),
                          ),
                          7.heightBox,
                          VxBox()
                              .size(100, 5)
                              .color(AppColor.primaryButton)
                              .rounded
                              .make(),
                          30.heightBox,
                          Text(
                            desc[index],
                            style: AppStyles()
                                .semibold(color: AppColor.secondaryText),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                style: TextButton.styleFrom(),
                onPressed: () {
                  controller.onContinueOrSkippedPressed();
                },
                child: Text(AppString.skip,
                  style: AppStyles().semibold(color: AppColor.secondaryText),)),
            Obx(
                  () =>
                  Row(
                      children: List.generate(
                          3,
                              (index) =>
                              VxBox()
                                  .size(index == controller.currentIndex ? 30 : 5, 5)
                                  .color(index == controller.currentIndex
                                  ? AppColor.primaryButton
                                  : AppColor.sliderDot).margin(const EdgeInsets.symmetric(horizontal: 4))
                                  .rounded
                                  .make())),
            ),
            Obx(
                    () =>
                controller.currentIndex < 2 ?
                IconButton(
                  onPressed: controller.changePage(controller.currentIndex),
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: AppColor.secondaryButton,
                  ),) :
                TextButton(
                    onPressed: (){
                      controller.onContinueOrSkippedPressed();
                    },
                    child: Text(
                      AppString.continueText,
                      style:
                      AppStyles().semibold(color: AppColor.secondaryButton),
                    ))
            )
          ],
        ),
      ),
    );
  }
}
