import 'package:restaurant_app/data/model/restaurant_detail.dart';

class DetailRestaurantResponse {
  DetailRestaurantResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  bool error;
  String message;
  RestaurantDetail restaurant;

  factory DetailRestaurantResponse.fromJson(Map<String, dynamic> json) => DetailRestaurantResponse(
    error: json["error"],
    message: json["message"],
    restaurant: RestaurantDetail.fromJson(json["restaurant"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "restaurant": restaurant.toJson(),
  };
}