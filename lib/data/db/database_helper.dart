import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  static late DatabaseHelper? _instance;
  static const String _tableName = 'favorite_restaurant';

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  Future<Database> initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(join(path, 'restaurant.db'), );
  }

}