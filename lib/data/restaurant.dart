import 'menus.dart';

class Restaurant {
  String? id;
  String? name;
  String? description;
  String? pictureId;
  String? city;
  double? rating;
  Menus? menus;

  Restaurant(
      {this.id,
      this.name,
      this.description,
      this.pictureId,
      this.city,
      this.rating,
      this.menus});

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    pictureId = json["pictureId"];
    city = json["city"];
    rating = json["rating"].toDouble();
    menus = json["menus"] == null ? null : Menus.fromJson(json["menus"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["name"] = name;
    _data["description"] = description;
    _data["pictureId"] = pictureId;
    _data["city"] = city;
    _data["rating"] = rating;
    if (menus != null) {
      _data["menus"] = menus?.toJson();
    }
    return _data;
  }
}
