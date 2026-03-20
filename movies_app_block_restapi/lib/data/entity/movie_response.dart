import 'package:movies_app/data/entity/movie.dart';

class MovieResponse {
  List<Movie> movies;
  int success;

  MovieResponse({required this.movies, required this.success});

//Json parse kisminda boyle manuel bir fonsk ihityacimz var dartta kendisi endpointten gelen responsu
// otomatik yapmadigi iicn boyle bir manuel fonsk ile yapariz o isi
  factory MovieResponse.fromJson(Map<String, dynamic> json)
  {
    print("json: ${json}");
    var jsonMovies = json["movies"] as List;//Dikkat burasi List<Movie> degil sadece List
    //Burda json array geliyor yani icerisinde json objeleri bulunduran json array ok..
    // bunun tipi Movie diyemeyiz henuz buraya dikkat
    int success = json["success"] as int;

    var movies = jsonMovies.map((jsonMovie)=>Movie.fromJson(jsonMovie)).toList();
    return MovieResponse(movies: movies, success: success);
  }
}