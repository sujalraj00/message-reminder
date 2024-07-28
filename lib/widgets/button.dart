
import 'package:flutter/material.dart';
import 'package:message_reminder/res/consts/t_colors.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const MyButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: TColors.primary
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color:  TColors.white
            ),
          ),
        ),
      ),
    );
  }
}
