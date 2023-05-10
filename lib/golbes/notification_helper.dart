import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class Notification_Helper {
  Notification_Helper._();

  static final Notification_Helper notification_helper =
      Notification_Helper._();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> intiNoti() async {
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('mipmap/ic_launcher');
    DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: darwinInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        print(details.payload);
      },
    );
  }

  scheduleNoti(
      {required String title,
      required String body,
      required DateTime select,
      required String tim}) {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("0", title);
    DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    tz.initializeTimeZones();
    String g = tim.split(":")[1];
    g = g.split(" ")[0];
    print(g);
    var dataTime = DateTime(
      select.year,
      select.month,
      select.day,
      int.parse(
        tim.split(":")[0],
      ),
      int.parse(g),
      0,
    );
    flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      tz.TZDateTime.from(dataTime, tz.local),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: "Parth",
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
