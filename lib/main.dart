import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/bottom_navigation_provider.dart';
import 'package:restaurant_app/provider/favorite_provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/screen/home_screen.dart';
import 'package:restaurant_app/screen/restaurant_detail_screen.dart';
import 'package:restaurant_app/screen/search_screen.dart';
import 'package:restaurant_app/style/theme.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/navigation.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.intializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotification(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => RestaurantProvider(ApiService()),
        ),
        ChangeNotifierProvider(
          create: (ctx) => FavoriteProvider(DatabaseHelper()),
        ),
        ChangeNotifierProvider(
          create: (ctx) => BottomNavigationProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => SchedulingProvider(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Restaurant App',
        theme: ThemeData(
          textTheme: textTheme,
          primarySwatch: Colors.blue,
        ),
        initialRoute: HomeScreen.routeName,
        routes: {
          SearchScreen.routeName: (context) => const SearchScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
        },
        onGenerateRoute: (RouteSettings settings) {
          if (settings.name == RestaurantDetailScreen.routeName) {
            return MaterialPageRoute(
                builder: (ctx) => RestaurantDetailScreen(
                    restaurant: settings.arguments as Restaurant));
          }
          return null;
        },
      ),
    );
  }
}
