import 'dart:convert';

import 'package:restaurant_app/data/restaurant.dart';

class ParseData {
  static List<Restaurant> parseRestaurants(String? json) {
    if (json == null) {
      return [];
    }
    final List parsed = jsonDecode(json);
    return parsed.map((data) => Restaurant.fromJson(data)).toList();
  }
}
