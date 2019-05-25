import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'dart:isolate';

// void printHello() {
//   final DateTime now = DateTime.now();
//   final int isolateId = Isolate.current.hashCode;
//   print("[$now] Hello, world! isolate=$isolateId function='$printHello'");
// }
// void showNotification() async {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     // var andorid =AndroidNotificationDetails('channel id', 'channel name', 'cahannel description');
//     // var iOS=IOSNotificationDetails();
//     // var platform=NotificationDetails(andorid, iOS);
//     // await flutterLocalNotificationsPlugin.show(0, 'New video is out', 'Flutter Local Notification', platform, payload: 'Lakshman');

//     // Show a notification every minute with the first appearance happening a minute after invoking the method
//     var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//         'repeating channel id',
//         'repeating channel name',
//         'repeating description');
//     var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
//     var platform = new NotificationDetails(
//         androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//         await flutterLocalNotificationsPlugin.show(0, 'New video is out', 'Flutter Local from notification', platform, payload: 'Lakshman');
//     // await flutterLocalNotificationsPlugin.periodicallyShow(0, 'repeating title',
//     //     'repeating body', RepeatInterval.EveryMinute, platformChannelSpecifics, payload: 'Lakshman');
//   }

void main() async {
  // final int helloAlarmID = 0;
  await AndroidAlarmManager.initialize();
  runApp(MyApp());
  // await AndroidAlarmManager.periodic(const Duration(seconds: 20), helloAlarmID, showNotification);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Local Notification'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('app_icon');
    var iOS = IOSInitializationSettings();
    var initSettings = InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);

// Show a notification every minute with the first appearance happening a minute after invoking the method
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'repeating channel id',
        'repeating channel name',
        'repeating description');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
        flutterLocalNotificationsPlugin.periodicallyShow(0, 'repeating title',
        'repeating body', RepeatInterval.EveryMinute, platformChannelSpecifics);
//     //////////////

// //for scheduled notifications
//     var scheduledNotificationDateTime =
//         new DateTime.now().add(new Duration(seconds: 50));
//     var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//         'your other channel id',
//         'your other channel name',
//         'your other channel description');
//     var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
//     NotificationDetails platformChannelSpecifics = new NotificationDetails(
//         androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//     flutterLocalNotificationsPlugin.schedule(0,'scheduled title','scheduled body', scheduledNotificationDateTime,
//         platformChannelSpecifics);
//         ////////////

// //show a daly notification at specific time
//     var time = new Time(12, 50, 0);
//     var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
//         'repeatDailyAtTime channel id',
//         'repeatDailyAtTime channel name',
//         'repeatDailyAtTime description');
//     var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
//     var platformChannelSpecifics = new NotificationDetails(
//         androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//     flutterLocalNotificationsPlugin.showDailyAtTime(
//         0,
//         'show daily title',
//         'Daily notification shown at approximately ${time.hour}:${time.minute}:${time.second}',
//         time,
//         platformChannelSpecifics);

    // //for showing a notification weeekly
    // var time = new Time(10, 0, 0);
    // var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
    //     'show weekly channel id',
    //     'show weekly channel name',
    //     'show weekly description');
    // var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    // var platformChannelSpecifics = new NotificationDetails(
    //     androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    // flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
    //     0,
    //     'show weekly title',
    //     'Weekly notification shown on Monday at approximately ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
    //     Day.Monday,
    //     time,
    //     platformChannelSpecifics);
        //////////////////////
  }

  Future onSelectNotification(String payload) {
    print('payload : $payload');
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Notification'),
              content: Text('$payload'),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: showNotification,
          child: Text('Demo'),
        ),
      ),
    );
  }

  showNotification() async {
    var andorid = AndroidNotificationDetails(
        'channel id', 'channel name', 'cahannel description');
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(andorid, iOS);
    await flutterLocalNotificationsPlugin.show(
        1, 'New video is out', 'Flutter Local Notification from key', platform,
        payload: 'Lakshman');

    // // Show a notification every minute with the first appearance happening a minute after invoking the method
    // var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
    //     'repeating channel id',
    //     'repeating channel name',
    //     'repeating description');
    // var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    // var platformChannelSpecifics = new NotificationDetails(
    //     androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    // await flutterLocalNotificationsPlugin.periodicallyShow(0, 'repeating title',
    //     'repeating body', RepeatInterval.EveryMinute, platformChannelSpecifics, payload: 'Lakshman');
  }
}
