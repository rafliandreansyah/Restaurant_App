import 'drinks.dart';
import 'foods.dart';

class Menus {
  List<Foods>? foods;
  List<Drinks>? drinks;

  Menus({this.foods, this.drinks});

  Menus.fromJson(Map<String, dynamic> json) {
    foods = json["foods"] == null
        ? null
        : (json["foods"] as List).map((e) => Foods.fromJson(e)).toList();
    drinks = json["drinks"] == null
        ? null
        : (json["drinks"] as List).map((e) => Drinks.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if (foods != null) {
      _data["foods"] = foods?.map((e) => e.toJson()).toList();
    }
    if (drinks != null) {
      _data["drinks"] = drinks?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}
