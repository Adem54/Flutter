import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/entity/movie.dart';
import 'package:movies_app/data/entity/movie_response.dart';

class MovieDaoRepostory {

  //Read-okuma islemini fonks uzernden yapacagiz..
  List<Movie> parseMovies(dynamic data){
    //jsonResp-string formatinda bunun json formatinda fromJson paramtresine verilmesi gerekir
    //jsonResp: personlist ve success in oldugu liste
    //  return PersonResponse.fromJson(json.decode(jsonResp)).persons;
    // Dio genelde Map döndürür
    if (data is Map<String, dynamic>) {
      return MovieResponse.fromJson(data).movies;
    }
    // Bazı durumlarda String gelebilir
    if (data is String) {
      final decoded = json.decode(data) as Map<String, dynamic>;
      return MovieResponse.fromJson(decoded).movies;
    }

    throw Exception("Beklenmeyen response tipi: ${data.runtimeType}");
  }


  Future<List<Movie>> fetchMovies() async {
    /*

    var filmlerListesi = <Movie>[];
    var f1 = Movie(id: 1, name: "Django", image: "django.png", price: 24);
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
  } */

    var url = "https://mocki.io/v1/01dffb77-111b-4ae7-b499-3d921e14afd4";
    var response = await Dio().get(url);
    return parseMovies(response.data);
  }

  //Burda veritabani islemlerini yapacagiz..
}