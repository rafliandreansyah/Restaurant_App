import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/utils/navigation.dart';
import 'package:restaurant_app/utils/received_notification.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String?>();
final didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

class NotificationHelper {
  static const _channelId = "01";
  static const _channelName = "channel_01";
  static const _channelDesc = "restaurant channel";

  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestCriticalPermission: false,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {
          didReceiveLocalNotificationSubject.add(ReceivedNotification(
            id: id,
            title: title,
            body: body,
            payload: payload,
          ));
        });

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse details) async {
      final payload = details.payload;
      selectNotificationSubject.add(payload);
    });
  }

  void requestPermissionIOS(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  void configureDidReceiveLocalNotificationSubject(
      BuildContext context, String route) {
    didReceiveLocalNotificationSubject
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
                title: receivedNotification.title != null
                    ? Text(receivedNotification.title!)
                    : null,
                content: receivedNotification.body != null
                    ? Text(receivedNotification.body!)
                    : null,
                actions: [
                  CupertinoDialogAction(
                    isDefaultAction: true,
                    onPressed: () async {
                      Navigation.back();
                      await Navigator.pushNamed(context, route,
                          arguments: receivedNotification);
                    },
                    child: const Text('Ok'),
                  )
                ],
              ));
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      Restaurant restaurant) async {
    const androidPlatformChannel = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const iOSPlatformChannel = DarwinNotificationDetails();

    const platformSpecificChannel = NotificationDetails(
      android: androidPlatformChannel,
      iOS: iOSPlatformChannel,
    );

    var titleNotification = "<b>Recommendation Restaurant</b>";
    var body = 'Discover the tastiest food from ${restaurant.name}';

    await flutterLocalNotificationsPlugin.show(
      1,
      titleNotification,
      body,
      platformSpecificChannel,
      payload: jsonEncode(restaurant.toJson()),
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen((payload) async {
      var data = Restaurant.fromJson(jsonDecode(payload!));
      Navigation.intentWithData(route, data);
    });
  }
}
