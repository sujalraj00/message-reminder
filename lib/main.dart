import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:message_reminder/Authentication/authentication_repository.dart';
import 'package:message_reminder/Authentication/network_manager.dart';
import 'package:message_reminder/res/consts/general_binding.dart';
import 'package:message_reminder/res/consts/t_colors.dart';
import 'package:message_reminder/res/screens/splash_page.dart';
import 'package:message_reminder/services/notification_services.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:get_storage/get_storage.dart';
import 'package:message_reminder/db/db_helper.dart';
import 'package:message_reminder/firebase_options.dart';
import 'package:message_reminder/res/consts/theme/theme.dart';
import 'package:message_reminder/res/routes/routes.dart';
import 'package:message_reminder/services/theme_services.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
void main() async {Get.put(NetworkManager());
WidgetsFlutterBinding.ensureInitialized();

  NotifyHelper().initializeNotification();
  await _configureLocalTimeZone();
  await DBHelper.initDb();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  runApp(const MyApp());
}

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      themeMode: ThemeService().theme,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindings(),
      //getPages: AppRoutes.getRoutes(),
      home: const SplashPage()
    );
  }
}