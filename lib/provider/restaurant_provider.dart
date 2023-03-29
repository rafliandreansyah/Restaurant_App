import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

import '../data/api/api_service.dart';

enum ResultState { loading, success, error, noData }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  late List<Restaurant> _listRestaurant;
  late ResultState _resultState;
  String _message = '';

  RestaurantProvider(this.apiService);

  List<Restaurant> get listRestaurant => _listRestaurant;

  ResultState get resultState => _resultState;

  String get message => _message;

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
}
