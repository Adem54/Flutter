class Movie {
  String id;
  String name;
  String image;
  int price;

  Movie({required this.id, required this.name, required this.image, required this.price});

  //key-DocumentId ye ait key olacagi icin once id ye atayaagiz ki biz idmize documentid yi atayabilelim...
  factory Movie.fromJson(Map<dynamic, dynamic> json, String key)
  {
    return Movie(
        id: key,
        name: json["name"] as String,
        image: json["image"] as String,
        price:  json["price"] as int
    );
  }
}