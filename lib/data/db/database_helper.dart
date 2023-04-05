import 'package:path/path.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static late DatabaseHelper? _instance;
  static const String _tableName = 'favorite_restaurant';

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  Future<Database> get database => initializeDb();

  Future<Database> initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      join(path, 'restaurant.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName (
              id TEXT PRIMARY KEY, 
              name TEXT, description TEXT, 
              pictureId TEXT, 
              city TEXT, 
              rating REAL
            )''',
        );
      },
    );
    return db;
  }

  Future<void> insertToFavorite(Restaurant restaurant) async {
    final db = await database;
    final statusInsert = await db.insert(_tableName, restaurant.toMap());
    if (statusInsert == 0) {
      throw Exception('Failed insert to favorite');
    }
  }

  Future<void> deleteFromFavorite(String id) async {
    final db = await database;
    final deleteStatus =
        await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
    if (deleteStatus == 0) {
      throw Exception('Failed remove from favorite');
    }
  }

  Future<Restaurant?> getRestaurantById(String id) async {
    final db = await database;
    final listOfRestaurant =
        await db.query(_tableName, where: 'id = ?', whereArgs: [id]);
    if (listOfRestaurant.isNotEmpty) {
      return Restaurant.fromMap(listOfRestaurant.first);
    }
    return null;
  }

  Future<List<Restaurant>> getListRestaurants() async {
    final db = await database;
    final listOfRestaurant = await db.query(_tableName);
    return listOfRestaurant
        .map((restaurant) => Restaurant.fromMap(restaurant))
        .toList();
  }
}
