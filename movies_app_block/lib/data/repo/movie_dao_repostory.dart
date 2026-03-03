import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/entity/movie.dart';
import 'package:movies_app/sqlite/database_assistant.dart';

class MovieDaoRepostory {

  Future<List<Movie>> fetchMovies() async {
    /*
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
    return filmlerListesi; */
    //1-Database e eriselim ilk olarak
    var db = await DatabaseAssistant.databasAccess();
    //<Map<String, dynamic>> bu nedir?
    //Bu Map sayesinde her bir tablodaki satiri-recordu yani Map e cevirecektir
    //Her bir recordda farkli type int,String.. column datalar olacagi icin key her zamn string oluyor
    // cunku key-value mantigi ile alior ama value bazen string, bazen int, bool vs olabileegi icin dynamic aliyor
    //Bizim kac satirmz var ise sorgudan fetch edilen hepsini maps olarak bize verecek
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM movie");
    //maps i listeye cevirecegiz
    return List.generate(maps.length, (index) {
      var row = maps[index]; //Bu da bize her bir satiri verecek index 0 ile baslayacak
      print("row: ${row}");
     /*
      I/flutter ( 4289): row: {id: 1, name: Djangoo, image: django.png, price: 24}
      I/flutter ( 4289): row: {id: 2, name: Interstellar, image: interstellar.png, price: 32}
      I/flutter ( 4289): row: {id: 3, name: Inception, image: inception.png, price: 16}
      I/flutter ( 4289): row: {id: 4, name: The Hateful Eight, image: thehatefuleight.png, price: 28}
      I/flutter ( 4289): row: {id: 5, name: The Pianist, image: thepianist.png, price: 18}
      I/flutter ( 4289): row: {id: 6, name: Anadoluda, image: anadoluda.png, price: 10} */
      //Bu satiri MOVIE objesine donusturelim
      return Movie(
          id: row["id"],
          name: row["name"],
          image: row["image"],
          price: row["price"]
      );
    });
  }

  //Burda veritabani islemlerini yapacagiz..
}