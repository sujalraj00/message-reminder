import 'package:flutter/material.dart';
import 'package:message_reminder/res/helper/helper_function.dart';

import '../res/consts/t_colors.dart';

class FormDivider extends StatelessWidget {
  const FormDivider({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        Flexible(
            child: Divider(
              color: dark ? TColors.darkerGrey : TColors.grey,
              thickness: 0.5,
              indent: 60,
              endIndent: 5,
            )),
        Text('or sign in with',
            style: Theme.of(context).textTheme.labelMedium),
        Flexible(
            child: Divider(
              color: dark ? TColors.darkerGrey : TColors.grey,
              thickness: 0.5,
              indent: 5,
              endIndent: 60,
            )),
      ],
    );
  }
}