import 'package:dart_tutorial1/obj_oriented/composition/categories.dart';
import 'package:dart_tutorial1/obj_oriented/composition/directors.dart';

class Movies{
  int movieId;
  String movieName;
  int movieYear;
 // int categoryId;
 // int directorId;
  /*
  Iste movies veritabani tablosunda categoryId, directoryId olarak tutulan datalari,
  biz class lar icerisinde direk foreing key in nesnesini tutariz burda...iste buna composition diyoruz
  Hatirlarsak biz bu mantigi dotnet te kullanirken entityframewrok-orm inden de dolayi hem foreginkey in id isini hem de nesnesini tutuyorduk
   */
  Categories category;
  Directors director;

  Movies({required this.movieId, required this.movieName, required this.movieYear, required this.category, required this.director});

  void showMovie()
  {
    print("movieId: ${movieId} - movieName: ${movieName} - movieYear: ${movieYear} - categoryName: ${category.categoryName} - directorName: ${director.directorName}");
  }
}