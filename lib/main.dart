import 'package:flutter/material.dart';
import 'package:restaurant_app/screen/restaurant_detail_screen.dart';
import 'package:restaurant_app/screen/restaurants_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RestaurantsScreen.routeName,
      routes: {
        RestaurantsScreen.routeName: (context) => const RestaurantsScreen(),
        RestaurantDetailScreen.routeName: (context) =>
            const RestaurantDetailScreen(),
      },
    );
  }
}
