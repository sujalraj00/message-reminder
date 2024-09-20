import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:message_reminder/controllers/user_controller.dart';
import 'package:message_reminder/res/consts/shimmer_effect.dart';
import 'package:message_reminder/res/consts/t_colors.dart';
import 'package:message_reminder/res/consts/t_images.dart';
import 'package:message_reminder/widgets/circular_image.dart';
import 'package:get/get.dart';
class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key, required this.onPressed,
  });
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return ListTile(
      leading:   Obx((){
        final networkImage = controller.user.value.profilePicture;
        final image = networkImage.isNotEmpty ? networkImage : TImages.user;
        return  controller.imageUploading.value
            ? const TShimmerEffect(width: 80, height: 80, radius: 80,)
            : TCircularImage(image: image, height: 80, width: 80, isNetworkImage: networkImage.isNotEmpty,);}),
      title: Text(controller.user.value.fullName, style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white),),
      subtitle: Text(controller.user.value.email, style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),),
      trailing: IconButton(onPressed: onPressed, icon:const Icon(Iconsax.edit, color: TColors.white,),),
    );
  }
}