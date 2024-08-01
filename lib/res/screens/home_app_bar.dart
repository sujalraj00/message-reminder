
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:message_reminder/controllers/user_controller.dart';
import 'package:message_reminder/res/consts/shimmer_effect.dart';
import 'package:message_reminder/res/consts/t_colors.dart';
import 'package:message_reminder/widgets/t_appbar.dart';


class THomeAppBar extends StatelessWidget {
  const THomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return TAppbar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nur', style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.black)),
          Obx((){
            if(controller.profileLoading.value){
              return const TShimmerEffect(width: 80, height: 15);
            } else {
              return  Text(controller.user.value.fullName, style: Theme.of(context).textTheme.labelMedium!.apply(color: TColors.black));
            }
          }
          ),
        ],
      ),
     // actions: [TCartCounterIcon(onPressed: (){}, iconColor: TColors.white,) ],
    );
  }
}