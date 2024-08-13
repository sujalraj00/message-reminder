import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:message_reminder/res/consts/shimmer_effect.dart';
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Center(
          child: isNetworkImage
              ? CachedNetworkImage(imageUrl: image,
            fit: fit,
            color: overlayColor,
            progressIndicatorBuilder: (context, url, downloadProgress) => const TShimmerEffect(width: 55, height: 55),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          )

              : Image(
            fit: fit,
            image: AssetImage(image) ,
            color: overlayColor,
          ),
        ),
      ),
    );
  }
}
