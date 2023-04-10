import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

import '../main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate_alarm';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void intializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<void> callback() async {
    print('Execute');
    final NotificationHelper notificationHelper = NotificationHelper();
    try {
      var result = await ApiService().getListRestaurant();
      var random = Random();
      var index = random.nextInt(result.restaurants.length);
      var restaurant = result.restaurants[index];
      await notificationHelper.showNotification(
          flutterLocalNotificationsPlugin, restaurant);
    } catch (e) {
      print('error get restaurant');
    }

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
