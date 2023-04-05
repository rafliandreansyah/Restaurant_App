import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/enum/result_state.dart';

import '../data/model/restaurant.dart';

class FavoriteProvider extends ChangeNotifier {
  final DatabaseHelper _databaseHelper;

  FavoriteProvider(this._databaseHelper);

  List<Restaurant> _allFavoriteRestaurant = [];
  late Restaurant? _favoriteRestaurant;
  bool _isFavorite = false;
  String _message = '';

  ResultState _allFavoriteResult = ResultState.loading;
  ResultState _checkIsFavoriteResult = ResultState.loading;
  ResultState _deleteFavoriteResult = ResultState.loading;
  ResultState _favoriteRestaurantResult = ResultState.loading;
  ResultState _insertFavoriteResult = ResultState.loading;

  ResultState get favoriteRestaurantResult => _favoriteRestaurantResult;

  ResultState get allFavoriteResult => _allFavoriteResult;

  ResultState get checkIsFavoriteResult => _checkIsFavoriteResult;

  ResultState get deleteFavoriteResult => _deleteFavoriteResult;

  ResultState get insertFavoriteResult => _insertFavoriteResult;

  List<Restaurant> get allFavoriteRestaurant => _allFavoriteRestaurant;

  Restaurant? get favoriteRestaurant => _favoriteRestaurant;

  bool get isFavorite => _isFavorite;

  String get message => _message;

  Future<void> getAllFavorite() async {
    try {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        _allFavoriteResult = ResultState.loading;
        notifyListeners();
      });

      _allFavoriteRestaurant = await _databaseHelper.getListRestaurants();
      if (_allFavoriteRestaurant.isEmpty) {
        _allFavoriteResult = ResultState.noData;
      } else {
        _allFavoriteResult = ResultState.success;
      }
    } catch (e) {
      _allFavoriteResult = ResultState.error;
      _message = 'Failed get all favorite';
    }

    notifyListeners();
  }

  void getFavoriteById(String id) async {
    try {
      _favoriteRestaurant = await _databaseHelper.getRestaurantById(id);
      if (_favoriteRestaurant == null) {
        _favoriteRestaurantResult = ResultState.noData;
      } else {
        _favoriteRestaurantResult = ResultState.success;
      }
    } catch (e) {
      _favoriteRestaurantResult = ResultState.error;
      _message = 'Failed get favorite';
    }
    notifyListeners();
  }

  void checkFavorite(String id) async {
    try {
      var restaurant = await _databaseHelper.getRestaurantById(id);
      if (restaurant == null) {
        _checkIsFavoriteResult = ResultState.noData;
        _isFavorite = false;
      } else {
        _checkIsFavoriteResult = ResultState.success;
        _isFavorite = true;
      }
    } catch (e) {
      _checkIsFavoriteResult = ResultState.error;
      _message = 'Failed get favorite';
      _isFavorite = false;
    }
    notifyListeners();
  }

  void deleteFavorite(String id) async {
    try {
      await _databaseHelper.deleteFromFavorite(id);
      _deleteFavoriteResult = ResultState.success;
    } catch (e) {
      _deleteFavoriteResult = ResultState.error;
      _message = 'Failed remove from favorite';
      print('Failed remove from favorite');
    }
    notifyListeners();
  }

  void insertFavorite(Restaurant restaurant) async {
    try {
      await _databaseHelper.insertToFavorite(restaurant);
      _insertFavoriteResult = ResultState.success;
    } catch (e) {
      _insertFavoriteResult = ResultState.error;
      _message = 'Failed insert to favorite';
      print('Failed insert to favorite');
    }

    notifyListeners();
  }
}
