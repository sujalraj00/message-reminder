import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:message_reminder/controllers/remind_controller.dart';
import 'package:message_reminder/fb.dart';
import 'package:message_reminder/models/reminders.dart';
import 'package:message_reminder/res/consts/t_colors.dart';
import 'package:message_reminder/res/helper/helper_function.dart';
import 'package:message_reminder/res/screens/home.dart';
import 'package:message_reminder/res/screens/home_app_bar.dart';
import 'package:message_reminder/res/screens/profile_screen.dart';
import 'package:message_reminder/res/screens/reminder_page.dart';
import 'package:message_reminder/res/screens/reminders_screen.dart';
import 'package:message_reminder/res/screens/settings_screen.dart';
import 'package:message_reminder/services/theme_services.dart';
import 'package:message_reminder/widgets/t_appbar.dart';

import '../../services/notification_services.dart';
import '../../widgets/tdrawer.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Nur'),
      //   leading: Builder(
      //     builder: (context) {
      //       return IconButton(
      //         icon: const Icon(Icons.menu),
      //         onPressed: () {
      //           Scaffold.of(context).openDrawer();
      //         },
      //       );
      //     },
      //   ),
      //   // actions: [
      //   //   Padding(
      //   //     padding: const EdgeInsets.only(right: 10),
      //   //     child: GestureDetector(
      //   //       onTap: (){
      //   //         ThemeService().switchTheme();
      //   //       },
      //   //       child: Icon(Icons.nightlight_round, size: 20,),
      //   //
      //   //     ),
      //   //   )
      //  // ],
      // ),
      // appBar: TAppbar(
      //   title: Text(
      //     'Nur',
      //     style: TextStyle(
      //         fontWeight: FontWeight.bold,
      //         fontSize: 22,
      //         fontStyle: FontStyle.italic),
      //   ),
      //   leadingIcon: Iconsax.user,
      // ),

      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            'Nur',
            style: TextStyle(
                color: dark? TColors.white : Colors.black,
                fontStyle: FontStyle.italic,
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.symmetric(horizontal: 20) ,
            icon: Icon(Iconsax.user), // Replace with your desired icon
            onPressed: () => Get.to(()=> ProfileScreen()),
          ),
        ],
      )
      ,

      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 70,
          elevation: 1,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: dark ? TColors.black : TColors.white,
          indicatorColor: dark
              ? TColors.white.withOpacity(0.1)
              : TColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.setting), label: 'Profile'),
            NavigationDestination(
                icon: Icon(Iconsax.notification), label: 'Reminders'),
          ],
        ),
      ),
      body: Obx(() => controller.screen[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final RxList<Reminders> reminders = <Reminders>[].obs; // Initialize with an empty list
  final remindController = Get.put(RemindController());
  //
  // Reminders remind = remindController.remindList[];
  // final reminde = remindController.getReminders();
  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchReminders(); // Fetch or initialize reminders
  // }

  void fetchReminders() {
    // Fetch reminders from your source (e.g., local storage, API, etc.)
    // For example:
    reminders.addAll([
      Reminders(
        id: 1,
        title: "Meeting",
        note: "Team meeting at 10 AM",
        date: "31/07/2024",
        startTime: "10:00",
        endTime: "11:00",
        color: 1,
        isCompleted: 0,
        remind: 10,
        repeat: "Daily",
      ),
      // Add more reminders as needed
    ]);
  }
 // final List<Widget> screen = [];
  // @override
  // void onReady() {
  //   super.onReady();
  //   screen.addAll([
  //     HomeScreen(reminders: reminders.toList()), // Pass reminders here
  //     SettingsScreen(),
  //     ReminderPage(),
  //   ]);
  // }
  final screen = [  HomeScreen(), SettingsScreen(), const  ReminderPage() ];
}

class NDrawer extends StatefulWidget {
  const NDrawer({super.key});

  @override
  State<NDrawer> createState() => _NDrawerState();
}

class _NDrawerState extends State<NDrawer> {
  var notifyHelper;

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Center(
        child: GestureDetector(
          onTap: () {
            ThemeService().switchTheme();
            notifyHelper.displayNotification(
                title: "Theme Changed",
                body: Get.isDarkMode
                    ? "Activated Light Theme"
                    : "Activated Dark Theme ");
            //  notifyHelper.scheduledNotification();
          },
          child: Icon(
            Icons.nightlight_round,
            size: 20,
          ),
        ),
      ),
    );
  }
}
