
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:message_reminder/fb.dart';
import 'package:message_reminder/res/consts/t_colors.dart';
import 'package:message_reminder/res/helper/helper_function.dart';
import 'package:message_reminder/res/screens/home.dart';
import 'package:message_reminder/res/screens/profile_screen.dart';
import 'package:message_reminder/res/screens/reminder_page.dart';
import 'package:message_reminder/res/screens/reminders_screen.dart';
import 'package:message_reminder/services/theme_services.dart';

import '../../services/notification_services.dart';
import '../../widgets/tdrawer.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});



  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBar with hamburger button'),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 10),
        //     child: GestureDetector(
        //       onTap: (){
        //         ThemeService().switchTheme();
        //       },
        //       child: Icon(Icons.nightlight_round, size: 20,),
        //
        //     ),
        //   )
       // ],
      ),
      drawer: const TDrawer(),

      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 70,
          elevation: 1,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor:  dark ? TColors.black : TColors.white,
          indicatorColor: dark? TColors.white.withOpacity(0.1) : TColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
            NavigationDestination(icon: Icon(Iconsax.notification), label: 'Reminders'),
            NavigationDestination(icon: Icon(Icons.facebook), label: 'Reminders'),
          ],),
      ),
      body: Obx(() =>  controller.screen[controller.selectedIndex.value]),
    );
  }
}


class NavigationController extends GetxController{

  final Rx<int> selectedIndex =0.obs;
  final screen = [const HomeScreen(), const ProfileScreen(), ReminderPage(), FbLogin()];
}
