import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:message_reminder/models/reminders.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

import '../res/screens/notified_page.dart';

//import 'package:flutter_native_timezone/flutter_native_timezone.dart';


class NotifyHelper {

  FlutterLocalNotificationsPlugin
  flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin(); //

  initializeNotification() async {
    //tz.initializeTimeZones();
   await _configureLocalTimezone();
    // this is for latest iOS settings
    final DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification
    );

    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("appicon");

      final InitializationSettings initializationSettings =
      InitializationSettings(
      iOS: initializationSettingsIOS,
      android:initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse     );
  }

  displayNotification({required String title, required String body}) async {
    print("doing test");
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name',  channelDescription: 'your channel description',
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');
    //var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,  //iOS: iOSPlatformChannelSpecifics
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: title,
    );
  }


  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
      if(payload == "Theme Changed"){
        print('nothing navigate to');
      } else{ print('going to notified page');
     await Get.to(()=>NotifiedPage(label : payload));
      }
    }
    // await Navigator.push(
    //   context,
    //   MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
    // );
    //await Get.to(()=>Container(color: Colors.white,));

  }

  scheduledNotificationDaily(int hour, int minutes, Reminders reminders, String title, String body) async {
print(" scheduling notification");
//var status = await Permission.scheduleExactAlarm.request();
    var status = await Permission.scheduleExactAlarm.request();
    if (status.isGranted) {
      print("Exact alarm permission granted");
    } else {
      print("Exact alarm permission denied");
      return;
    }

    var scheduleTime = _convertTimeDaily(hour, minutes);
    print("Scheduled time: $scheduleTime");
  await flutterLocalNotificationsPlugin.zonedSchedule(
      reminders.id!.toInt()  ,
      reminders.title,
      body,
      scheduleTime,
      // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      const NotificationDetails(
          android: AndroidNotificationDetails('your channel id',
              'your channel name',channelDescription: 'your channel description',
              importance: Importance.max, priority: Priority.high, ticker: 'ticker')),

      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: "${title}|" + "${body}|"
  );

   print('notification scheduled');

  }



  scheduledNotificationNone(int hour, int minutes, Reminders reminders, String title, String body) async {
    print(" scheduling notification");
    var status = await Permission.scheduleExactAlarm.request();
    if (status.isGranted) {
      print("Exact alarm permission granted");
    } else {
      print("Exact alarm permission denied");
      return;
    }
    var scheduleTime = _convertTimeNone(hour, minutes);
    print("Scheduled time: $scheduleTime");
    await flutterLocalNotificationsPlugin.zonedSchedule(
        reminders.id!.toInt()  ,
        reminders.title,
        body,
        scheduleTime,
        // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name',channelDescription: 'your channel description',
                importance: Importance.max, priority: Priority.high, ticker: 'ticker')),

        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: "${title}|" + "${body}|"
    );

    print('notification scheduled');

  }

  scheduledNotificationWeekly(int hour, int minutes, Reminders reminders, String title, String body ) async {
    print(" scheduling notification");
    var status = await Permission.scheduleExactAlarm.request();
    if (status.isGranted) {
      print("Exact alarm permission granted");
    } else {
      print("Exact alarm permission denied");
      return;
    }
    var scheduleTime = _convertTimeWeekly(hour, minutes);
    print("Scheduled time: $scheduleTime");
    await flutterLocalNotificationsPlugin.zonedSchedule(
        reminders.id!.toInt()  ,
        reminders.title,
        body,
        scheduleTime,
        // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name',channelDescription: 'your channel description',
                importance: Importance.max, priority: Priority.high, ticker: 'ticker')),

        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: "${title}|" + "${body}|"
    );

    print('notification scheduled');


  }


  scheduledNotificationMonthly(int hour, int minutes, Reminders reminders, String title, String body) async {
    print(" scheduling notification");
    var status = await Permission.scheduleExactAlarm.request();
    if (status.isGranted) {
      print("Exact alarm permission granted");
    } else {
      print("Exact alarm permission denied");
      return;
    }

    var scheduleTime = _convertTimeMonthly(hour, minutes);
    print("Scheduled time: $scheduleTime");
    await flutterLocalNotificationsPlugin.zonedSchedule(
        reminders.id!.toInt()  ,
        reminders.title,
        body,
        scheduleTime,
        // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name',channelDescription: 'your channel description',
                importance: Importance.max, priority: Priority.high, ticker: 'ticker')),

        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: "${title}|" + "${body}|"
    );

    print('notification scheduled');

  }

  tz.TZDateTime _convertTimeDaily(int hour , int minutes ){
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
    if(scheduleDate.isBefore(now)){
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  tz.TZDateTime _convertTimeNone(int hour , int minutes ){
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);

    return scheduleDate;
  }

  tz.TZDateTime _convertTimeWeekly(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);

    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 7));
    }

    while (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 7));
    }

    return scheduleDate;
  }

  tz.TZDateTime _convertTimeMonthly(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
    tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);

    if (scheduleDate.isBefore(now)) {
      scheduleDate = tz.TZDateTime(tz.local, now.year, now.month + 1, now.day, hour, minutes);
    }

    // Adjust for months where the day might not exist (e.g., Feb 30)
    while (scheduleDate.isBefore(now)) {
      scheduleDate = tz.TZDateTime(tz.local, scheduleDate.year, scheduleDate.month + 1, scheduleDate.day, hour, minutes);
    }

    return scheduleDate;
  }



  Future<void> _configureLocalTimezone()async{
    tz.initializeTimeZones();
    final String timeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }


  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      print('notification payload: $payload');
      if(payload == "Theme Changed"){
        print('nothing navigate to');
      } else{ print('going to notified page');
        Get.to(()=>NotifiedPage(label : payload));
      }
    } else {
      print("Notification Done");
    }

  }

  Future<void> cancelScheduledNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
    print('Notification with id $id cancelled');
  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    // showDialog(
    //   //context: context,
    //   builder: (BuildContext context) => CupertinoAlertDialog(
    //     title: Text(title),
    //     content: Text(body),
    //     actions: [
    //       CupertinoDialogAction(
    //         isDefaultAction: true,
    //         child: Text('Ok'),
    //         onPressed: () async {
    //           Navigator.of(context, rootNavigator: true).pop();
    //           await Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => SecondScreen(payload),
    //             ),
    //           );
    //         },
    //       )
    //     ],
    //   ),
    // );
    Get.dialog(Text('Welcome to Flutter'));
  }
}