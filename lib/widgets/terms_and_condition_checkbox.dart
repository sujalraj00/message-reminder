import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/sign_up_controller.dart';
import '../res/consts/t_colors.dart';
import '../res/helper/helper_function.dart';

class TermsAndConditionCheckBox extends StatelessWidget {
  const TermsAndConditionCheckBox({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = SignupController.instance;
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(() => Checkbox(
                value: controller.privacyPolicy.value,
                onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value
              )),
        ),
        const SizedBox(
          width: 24,
        ),
        Text.rich(TextSpan(children:[
          TextSpan(
              text: 'I Agree To ',
              style:Theme.of(context).textTheme.bodySmall
          ),
          TextSpan(
            text:'Privacy Policy ',
            style:Theme.of(context).textTheme.bodyMedium!.apply(
                color: dark ? TColors.white : TColors.primary,
                decorationColor: dark ? TColors.white : TColors.primary)
          ),
          TextSpan(
            text: 'and ',
              style: Theme.of(context).textTheme.bodySmall
          ),
          TextSpan(
              text: 'Terms of Use',
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? TColors.white : TColors.primary,
                  decorationColor: dark ? TColors.white : TColors.primary)),
        ] ))
      ],
    );
  }
}
