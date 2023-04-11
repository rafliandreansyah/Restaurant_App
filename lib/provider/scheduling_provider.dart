import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/datetime_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SchedulingProvider extends ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static const String _REMINDER_KEY = 'REMINDER';

  bool _isScheduled = false;

  bool get isScheduled {
    return _isScheduled;
  }

  void checkSchedule() async {
    SharedPreferences sharedPreferences = await _prefs;
    _isScheduled = sharedPreferences.getBool(_REMINDER_KEY) ?? false;
    notifyListeners();
  }

  void _setScheduledPref(bool value) async {
    SharedPreferences sharedPreferences = await _prefs;
    await sharedPreferences.setBool(_REMINDER_KEY, value);
    checkSchedule();
  }

  Future<bool> scheduledRestaurant(bool value) async {
    _setScheduledPref(value);
    if (value) {
      print('Scheduling Restaurant Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DatetimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling News Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
