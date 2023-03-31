import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../model/detail_restaurant_response.dart';
import '../model/list_restaurant_response.dart';
import '../model/search_restaurant_response.dart';

class ApiService {
  final String baseUrl = 'https://restaurant-api.dicoding.dev';

  static ApiService? _instance;

  ApiService._internal() {
    _instance = this;
  }

  factory ApiService() => _instance ?? ApiService._internal();

  Future<ListRestaurantResponse> getListRestaurant() async {
    var hasConnection = await InternetConnectionChecker().hasConnection;
    if (!hasConnection) {
      throw Exception('Please check your connection...');
    }
    var response = await http.get(Uri.parse('$baseUrl/list'));
    if (response.statusCode == 200) {
      return ListRestaurantResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception('Not found');
    } else {
      throw Exception('Failed get data');
    }
  }

  Future<DetailRestaurantResponse> getDetailRestaurant(String id) async {
    var hasConnection = await InternetConnectionChecker().hasConnection;
    if (!hasConnection) {
      throw Exception('Please check your connection...');
    }
    var response = await http.get(Uri.parse('$baseUrl/detail/$id'));
    if (response.statusCode == 200) {
      return DetailRestaurantResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      throw Exception('Not found');
    } else {
      throw Exception('Failed get data');
    }
  }

  Future<SearchRestaurantResponse> searchRestaurant(String query) async {
    var hasConnection = await InternetConnectionChecker().hasConnection;
    if (!hasConnection) {
      throw Exception('Please check your connection...');
    }
    var response = await http.get(Uri.parse('$baseUrl/search?q=$query'));
    if (response.statusCode == 200) {
      return SearchRestaurantResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      throw Exception('Not found');
    } else {
      throw Exception('Failed get data');
    }
  }
}
