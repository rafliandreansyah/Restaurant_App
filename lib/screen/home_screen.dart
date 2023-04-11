import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/bottom_navigation_provider.dart';
import 'package:restaurant_app/screen/favorite_screen.dart';
import 'package:restaurant_app/screen/restaurant_detail_screen.dart';
import 'package:restaurant_app/screen/restaurants_screen.dart';
import 'package:restaurant_app/screen/setting_screen.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

import '../provider/scheduling_provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  final List<Widget> bottomNavWidget = [
    const RestaurantsScreen(),
    const FavoriteScreen(),
    const SettingScreen(),
  ];

  @override
  void initState() {
    super.initState();
    context.read<SchedulingProvider>().checkSchedule();
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantDetailScreen.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationProvider>(
        builder: (context, bottomNavState, _) {
      return Scaffold(
        body: bottomNavWidget[bottomNavState.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) =>
              context.read<BottomNavigationProvider>().setIndex(index),
          currentIndex: bottomNavState.currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  bottomNavState.currentIndex == 0
                      ? Icons.food_bank
                      : Icons.food_bank_outlined,
                ),
                label: 'Restaurant'),
            BottomNavigationBarItem(
                icon: Icon(
                  bottomNavState.currentIndex == 1
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
                label: 'Favorite'),
            BottomNavigationBarItem(
                icon: Icon(
                  bottomNavState.currentIndex == 2
                      ? Icons.settings
                      : Icons.settings_outlined,
                ),
                label: 'Setting'),
          ],
        ),
      );
    });
  }
}
