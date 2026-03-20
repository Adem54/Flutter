class Movie {
  int id;
  String name;
  String image;
  int price;

  Movie({required this.id, required this.name, required this.image, required this.price});

  factory Movie.fromJson(Map<String, dynamic> json)
  {
    return Movie(
        id: json["id"] as int,
        name: json["name"] as String,
        image: json["image"] as String,
        price:  json["price"] as int
    );
  }
}