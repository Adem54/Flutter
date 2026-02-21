import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/entity/movie.dart';

class MovieDaoRepostory {

  Future<List<Movie>> fetchMovies() async {
    var filmlerListesi = <Movie>[];
    var f1 = Movie(id: 1, name: "Djangoo", image: "django.png", price: 24);
    var f2 = Movie(id: 2, name: "Interstellar", image: "interstellar.png", price: 32);
    var f3 = Movie(id: 3, name: "Inception", image: "inception.png", price: 16);
    var f4 = Movie(id: 4, name: "The Hateful Eight", image: "thehatefuleight.png", price: 28);
    var f5 = Movie(id: 5, name: "The Pianist", image: "thepianist.png", price: 18);
    var f6 = Movie(id: 6, name: "Anadoluda", image: "anadoluda.png", price: 10);
    filmlerListesi.add(f1);
    filmlerListesi.add(f2);
    filmlerListesi.add(f3);
    filmlerListesi.add(f4);
    filmlerListesi.add(f5);
    filmlerListesi.add(f6);
    return filmlerListesi;
  }

  //Burda veritabani islemlerini yapacagiz..
}