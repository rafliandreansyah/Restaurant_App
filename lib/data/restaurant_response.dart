import 'package:restaurant_app/data/restaurant.dart';

class Restaurants {
  List<Restaurant>? restaurants;

  Restaurants({this.restaurants});

  Restaurants.fromJson(Map<String, dynamic> json) {
    restaurants = json['restaurants'] == null
        ? null
        : (json['restaurants'] as List)
            .map((e) => Restaurant.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (restaurants != null) {
      data['restaurants'] = restaurants?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
