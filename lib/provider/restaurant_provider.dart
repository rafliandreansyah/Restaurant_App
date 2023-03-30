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
  late ResultState _resultState;
  String _message = '';

  RestaurantProvider(this.apiService);

  List<Restaurant> get listRestaurant => _listRestaurant;

  List<Restaurant> get searchRestaurantData => _searchRestaurant;

  ResultState get resultState => _resultState;

  String get message => _message;

  RestaurantDetail get restaurantDetail => _restaurantDetail;

  Future<void> getListRestaurant() async {
    try {
      _resultState = ResultState.loading;
      notifyListeners();

      var response = await apiService.getListRestaurant();
      if (response.restaurants.isEmpty) {
        _resultState = ResultState.noData;
        _message = 'Data is empty!';
        notifyListeners();
      } else {
        _resultState = ResultState.success;
        _listRestaurant = response.restaurants;
        notifyListeners();
      }
    } catch (e) {
      _resultState = ResultState.error;
      _message = e.toString();
      notifyListeners();
    }
  }

  Future<void> getDetailRestaurant(String id) async {
    try {
      _resultState = ResultState.loading;
      notifyListeners();

      var response = await apiService.getDetailRestaurant(id);
      _resultState = ResultState.success;
      _restaurantDetail = response.restaurant;
      notifyListeners();
    } catch (e) {
      _resultState = ResultState.error;
      _message = e.toString();
      notifyListeners();
    }
  }

  Future<void> searchRestaurant(String query) async {
    try {
      _resultState = ResultState.loading;
      notifyListeners();

      var response = await apiService.searchRestaurant(query);
      if (response.restaurants.isEmpty) {
        _resultState = ResultState.noData;
        _message = 'Data is empty!';
        notifyListeners();
      } else {
        _resultState = ResultState.success;
        _searchRestaurant = response.restaurants;
        notifyListeners();
      }
    } catch (e) {
      _resultState = ResultState.error;
      _message = e.toString();
      notifyListeners();
    }
  }
}
