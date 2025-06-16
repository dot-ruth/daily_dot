import 'package:daily_dot/util/habit_util.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    final InitializationSettings initializationSettings 
        = InitializationSettings(android: initializationSettingsAndroid);

    await _notificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<void> scheduleDailyNotification({
    int id = 1,
    required int hour,
    required int minute
    }) async {
    // get the current datetime in the device's local timezone
    final now = tz.TZDateTime.now(tz.local);

    // create a datetime for today at the specified hour and min 
    var scheduledDate = tz.TZDateTime(
      tz.local, 
      now.year,
      now.month,
      now.day,
      hour,
      minute
      );

      await _notificationsPlugin.zonedSchedule(
        id,
        getRandomTitle(),
        getRandomBody(),
        scheduledDate,
        _notificationDetails(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    
  }

  NotificationDetails _notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_dot_reminders',             
        'Daily Habit Reminders',            
        channelDescription: 'Reminders to track your daily habits on Daily Dot',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: false,
      ),
    );
  }

Future<void> showNotification() async {
 return _notificationsPlugin.show(
  0, 
  getRandomTitle(),
  getRandomBody(),
  _notificationDetails()
  );
}

}