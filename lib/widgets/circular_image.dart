import 'package:flutter/material.dart';
import 'package:message_reminder/res/consts/t_colors.dart';
import 'package:message_reminder/res/helper/helper_function.dart';


class TCircularImage extends StatelessWidget {
  const TCircularImage({
    super.key,
    this.width =56,
    this.height = 56,
    this.padding = 8,
    this.backgroundColor,
    this.isNetworkImage = false,
    required this.image,
    this.fit = BoxFit.cover,
    this.overlayColor,
  });

  final double width, height, padding;
  final Color? backgroundColor;
  final bool isNetworkImage;
  final String image;
  final BoxFit fit;
  final Color? overlayColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding ),
      decoration: BoxDecoration(
        color: THelperFunctions.isDarkMode(context)
            ? TColors.black
            : TColors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Image(
        fit: fit,
        image: isNetworkImage ? NetworkImage(image) : AssetImage(image) as ImageProvider,
        color: overlayColor,
      ),
    );
  }
}
