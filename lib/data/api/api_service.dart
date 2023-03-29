import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/list_restaurant_response.dart';

class ApiService {
  final String baseUrl = 'https://restaurant-api.dicoding.dev';

  static ApiService? _instance;

  ApiService._internal() {
    _instance = this;
  }

  factory ApiService() => _instance ?? ApiService._internal();

  Future<ListRestaurantResponse> getListRestaurant() async {
    var response = await http.get(Uri.parse('$baseUrl/list'));
    if (response.statusCode == 200) {
      return ListRestaurantResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Failed get data');
    }
  }
}
