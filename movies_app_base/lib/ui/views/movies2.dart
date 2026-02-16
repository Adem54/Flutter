import 'package:flutter/material.dart';
import 'package:movies_app/data/entity/movie.dart';
import 'package:movies_app/ui/views/movie_detail.dart';

class Movies2 extends StatefulWidget {
  const Movies2({super.key});

  @override
  State<Movies2> createState() => _MoviesState2();
}

class _MoviesState2 extends State<Movies2> {

  List<Movie> movieList  = [];
  //basina late koyarak bu degerin ilk bsta null yani hicbirsey atanadiginda hata vermemesin saglayabiliriz
  late Future<List<Movie>> movieFeature;
  Future<List<Movie>> fetchMovies() async {
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
  }

  /*
  BOYLE HATA ALDIK....
  ======== Exception caught by image resource service ================================================
The following assertion was thrown resolving an image codec:
Unable to load asset: "assets/images/django.png".
BURDAN DEMEKKI IMAGE LER YUKLENMEMIS DIYORUZ..
Bu hatayi aldgimzda ben acaba resimler mi yuklenmsmis vs diye endise ettim burda andr.studio yu kapatip geri actim vs..
bunlar yapilabilir veya en bastan calistir dedim...dikdorgene basarak-kirmizi dikdortgen sonra da image i kullandigmz yerde dogru bir sekilde cagirmis miyiz ona bakariz...yani
Sonra kullanima baktim...
  child: Image.asset("assets/images/${movie.image}", fit: BoxFit.cover, boyle kullanmisiz...ama burda assets ana klasoru altinda degil ki bizim ki yokunu yanlis vermisiz dikkat edelim
  Doogursu soyle oalcakti:child: Image.asset("images/${movie.image}", fit: BoxFit.cover
  * */

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieFeature = fetchMovies().then((movies){
      movieList = movies;
      return movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Movies"),),
      body:FutureBuilder<List<Movie>>(
        future: movieFeature,//fetchMovies()
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final movies = snapshot.data ?? [];
          if(movies.isEmpty)return const Center(child:Text("No movies"));

          /*
          Bu yöntemde “1-2-3” diye elle seçmezsin; Flutter ekranı ölçer ve sığdığı kadar kolon koyar.
          küçük ekranda 1 kolona düşer
          telefonda 2 olabilir
          tablette 3-4 bile olabilir
          Hangisini seçeyim?
          “Kesin 1/2/3 olsun” istiyorsan → Yöntem A--yani movies.dart
          “Kart genişliği sabit kalsın, kolon sayısı otomatik olsun” istiyorsan → Yöntem B yani movies2.dart (genelde daha modern)
*/
          return GridView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: movies.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 220, // ✅ her kart max 220px genişlik
              //“Grid’de bir kutunun (tile’ın) cross-axis (yatay) genişliği en fazla 220 logical pixel olsun.Ekrana kaç tane sığarsa o kadar kolon oluştur.”
             // Ekran genişse → 220’lik kutulardan daha fazla sığar → 3-4 kolon olur. Ekran dar ise → 220’lik kutular 2 tane bile sığmayabilir → 1 kolon olur.
              //Yani “220 her zaman aynıdır” gibi değil; Flutter 220’yi hedef alır, ama sığma durumuna göre kolon sayısını otomatik ayarlar.
              //220 “px” mi?Flutter’da bu değer logical pixel (dp) gibi düşünülür.Android’de “dp”iOS’ta “points”Flutter’da genelde “logical pixels” denir.
              //Yani ekranda cihazdan cihaza fiziksel piksel sayısı değişse de, görünen boyut tutarlı kalır.
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.70,
            ),
            /*
            *crossAxisCount ne demek?

GridView’de iki eksen var:
mainAxis: Scroll yönü (GridView dikey scroll ise mainAxis = dikey)
crossAxis: Scroll’a dik olan yön (dikey scroll’da crossAxis = yatay)
Senin GridView dikey kayıyor, o zaman:
✅ crossAxisCount = bir satırda kaç tane kutu/kolon olsun
1 → tek kolon (alt alta)
2 → iki kolon (yan yana 2)
3 → üç kolon (yan yana 3)
crossAxisSpacing ne demek?
✅ Yan yana kutuların arasındaki yatay boşluk.
Yani aynı satırdaki 2 kart arasında soldan sağa boşluk.
mainAxisSpacing ne demek?
✅ Alt alta kutuların arasındaki dikey boşluk.
Yani bir satır ile onun altındaki satır arasındaki boşluk.
childAspectRatio ne demek?
✅ Kartın en/boy oranı.
Formül gibi düşün:
childAspectRatio = width / height
1.0 → kareye yakın
0.70 → yüksek kart (height daha büyük)
1.5 → geniş kart (width daha büyük)
Film/poster tarzı UI’larda genelde 0.6–0.8 arası kullanılır çünkü posterler uzundur.
            * */

            itemBuilder: (context, index){
              final movie = movieList[index];
              return GestureDetector(
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieDetail(movie:movie)));
                },
                child: Card(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Image.asset("images/${movie.image}", fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.all(8),
                                   child: Text(movie.name, maxLines: 2, overflow: TextOverflow.ellipsis),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                                   child: Text("${movie.price} ₺"),
                                 ),
                               ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                  onPressed: (){
                                    print("movie-name ${movie.name} is added to card");
                                  },
                                  child: const Text("Card")),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ),
              );
            },
          );
        },
      )
    );
  }
}
/*
* YUKARDA BIZ KENDIMZ DIREK EKRAN BOYUTUNA GORE AYAR YAPTIK AMA YONTEM B ILE BUNU DA KENDISI OTOMATIK YAPSIN DIYEBILIRIZ!!!
* Yöntem B: “Kart max 220px olsun” → kolon sayısını otomatik bulsun (çok pratik)
Bu yöntemde “1-2-3” diye elle seçmezsin; Flutter ekranı ölçer ve sığdığı kadar kolon koyar.
* return GridView.builder(
  padding: const EdgeInsets.all(12),
  itemCount: movies.length,
  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 220, // ✅ her kart max 220px genişlik
    crossAxisSpacing: 12,
    mainAxisSpacing: 12,
    childAspectRatio: 0.70,
  ),
  itemBuilder: (context, i) { ... },
);
küçük ekranda 1 kolona düşer
telefonda 2 olabilir
tablette 3-4 bile olabilir

* Hangisini seçeyim?
“Kesin 1/2/3 olsun” istiyorsan → Yöntem A
“Kart genişliği sabit kalsın, kolon sayısı otomatik olsun” istiyorsan → Yöntem B (genelde daha modern)
* */
