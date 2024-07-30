import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:message_reminder/res/consts/t_colors.dart';
import 'package:message_reminder/res/helper/helper_function.dart';

class TAppbar extends StatelessWidget implements PreferredSizeWidget {
  const TAppbar(
      {super.key,
        this.title,
        this.showBackArrow = false,
        this.leadingIcon,
        this.actions,
        this.leadingOnPressed});

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: AppBar(
          automaticallyImplyLeading: false,
          leading: showBackArrow
              ? IconButton(
              onPressed: () => Get.back(),
              icon:  Icon(Iconsax.arrow_left,
                  color: dark  ? TColors.white : TColors.dark))
              : leadingIcon != null ?  IconButton(
              onPressed: leadingOnPressed,
              icon:  Icon(leadingIcon))  : null,
          title: title,
          actions: actions,
        )
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
