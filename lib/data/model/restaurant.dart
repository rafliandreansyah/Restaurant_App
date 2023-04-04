class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  late String id;
  late String name;
  late String description;
  late String pictureId;
  late String city;
  late double rating;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };

  Map<String, Object?> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };

  Restaurant.fromMap(Map<String, Object?> map) {
    id = map["id"] as String;
    name = map["name"] as String;
    description = map["description"] as String;
    pictureId = map["pictureId"] as String;
    city = map["city"] as String;
    rating = map["rating"] as double;
  }
}
