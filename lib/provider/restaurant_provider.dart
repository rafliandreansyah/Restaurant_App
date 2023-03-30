import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

import '../data/api/api_service.dart';

enum ResultState { loading, success, error, noData }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  late List<Restaurant> _listRestaurant;
  List<Restaurant> _searchRestaurant = [];
  late RestaurantDetail _restaurantDetail;
  late ResultState _resultStateListRestaurant;
  late ResultState _resultStateSearch;
  late ResultState _resultStateDetailRestaurant;
  String _message = '';

  RestaurantProvider(this.apiService);

  List<Restaurant> get listRestaurant => _listRestaurant;

  List<Restaurant> get searchRestaurantData => _searchRestaurant;

  ResultState get resultStateListRestaurant => _resultStateListRestaurant;
  ResultState get resultStateSearch => _resultStateSearch;
  ResultState get resultStateDetailRestaurant => _resultStateDetailRestaurant;

  String get message => _message;

  RestaurantDetail get restaurantDetail => _restaurantDetail;

  Future<void> getListRestaurant() async {
    try {
      _resultStateListRestaurant = ResultState.loading;
      notifyListeners();

      var response = await apiService.getListRestaurant();
      if (response.restaurants.isEmpty) {
        _resultStateListRestaurant = ResultState.noData;
        _message = 'Data is empty!';
        notifyListeners();
      } else {
        _resultStateListRestaurant = ResultState.success;
        _listRestaurant = response.restaurants;
        notifyListeners();
      }
    } catch (e) {
      _resultStateListRestaurant = ResultState.error;
      _message = e.toString();
      notifyListeners();
    }
  }

  Future<void> getDetailRestaurant(String id) async {
    try {
      _resultStateDetailRestaurant = ResultState.loading;
      notifyListeners();

      var response = await apiService.getDetailRestaurant(id);
      _resultStateDetailRestaurant = ResultState.success;
      _restaurantDetail = response.restaurant;
      notifyListeners();
    } catch (e) {
      _resultStateDetailRestaurant = ResultState.error;
      _message = e.toString();
      notifyListeners();
    }
  }

  Future<void> searchRestaurant(String query) async {
    try {
      _searchRestaurant.clear();
      _resultStateSearch = ResultState.loading;
      notifyListeners();

      var response = await apiService.searchRestaurant(query);

      if (query.isEmpty) {
        _resultStateSearch = ResultState.noData;
        _message = 'Write down the restaurant you want to find...';
        notifyListeners();
      } else {
        if (response.restaurants.isEmpty) {
          _resultStateSearch = ResultState.noData;
          _message = 'Data is empty!';
          notifyListeners();
        } else {
          _resultStateSearch = ResultState.success;
          _searchRestaurant = response.restaurants;
          notifyListeners();
        }
      }
    } catch (e) {
      _resultStateSearch = ResultState.error;
      _message = e.toString();
      notifyListeners();
    }
  }
}
