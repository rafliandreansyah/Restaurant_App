import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/screen/restaurant_detail_screen.dart';
import 'package:restaurant_app/screen/restaurants_screen.dart';
import 'package:restaurant_app/style/theme.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (ctx) => RestaurantProvider(ApiService()),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        textTheme: textTheme,
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
