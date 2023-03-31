import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/data/model/restaurant_detail.dart';

import '../data/api/api_service.dart';

enum ResultState { loading, success, error, noData }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  late List<Restaurant> _listRestaurant;
  List<Restaurant> _searchRestaurant = [];
  late RestaurantDetail _restaurantDetail;
  ResultState _resultStateListRestaurant = ResultState.loading;
  ResultState _resultStateSearch = ResultState.loading;
  ResultState _resultStateDetailRestaurant = ResultState.loading;
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
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        _resultStateListRestaurant = ResultState.loading;
        notifyListeners();
      });

      var response = await apiService.getListRestaurant();
      if (response.restaurants.isEmpty) {
        _resultStateListRestaurant = ResultState.noData;
        _message = 'Data is empty!';
      } else {
        _resultStateListRestaurant = ResultState.success;
        _listRestaurant = response.restaurants;
      }
    } on SocketException catch (e) {
      _resultStateListRestaurant = ResultState.error;
      _message = 'Please check your connection...';
    } catch (e) {
      _resultStateListRestaurant = ResultState.error;
      _message = e.toString();
    }

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }

  Future<void> getDetailRestaurant(String id) async {
    try {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        _resultStateDetailRestaurant = ResultState.loading;
        notifyListeners();
      });

      var response = await apiService.getDetailRestaurant(id);
      _resultStateDetailRestaurant = ResultState.success;
      _restaurantDetail = response.restaurant;
    } on SocketException catch (e) {
      _resultStateDetailRestaurant = ResultState.error;
      _message = 'Please check your connection...';
    } catch (e) {
      _resultStateDetailRestaurant = ResultState.error;
      _message = e.toString();
    }

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }

  Future<void> searchRestaurant(String query) async {
    try {
      _searchRestaurant.clear();
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        _resultStateSearch = ResultState.loading;
        notifyListeners();
      });

      var response = await apiService.searchRestaurant(query);

      if (query.isEmpty) {
        _resultStateSearch = ResultState.noData;
        _message = 'Write down the restaurant you want to find...';
      } else {
        if (response.restaurants.isEmpty) {
          _resultStateSearch = ResultState.noData;
          _message = 'Data is empty!';
        } else {
          _resultStateSearch = ResultState.success;
          _searchRestaurant = response.restaurants;
        }
      }
    } on SocketException catch (e) {
      _resultStateSearch = ResultState.error;
      _message = 'Please check your connection...';
    } catch (e) {
      _resultStateSearch = ResultState.error;
      _message = e.toString();
    }

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      notifyListeners();
    });
  }
}
