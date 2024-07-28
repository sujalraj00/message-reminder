import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:message_reminder/services/notification_services.dart';
import 'package:message_reminder/services/theme_services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}



class _ProfileScreenState extends State<ProfileScreen> {
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
    return  Scaffold(
    body: Center(
      child:  GestureDetector(
        onTap: (){
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
              title:"Theme Changed",
              body: Get.isDarkMode ? "Activated Light Theme" : "Activated Daark Theme "
          );
        //  notifyHelper.scheduledNotification();
        },
        child: Icon(Icons.nightlight_round, size: 20,),

      ),
    ),
    );
  }


}
