import 'package:dart_tutorial1/obj_oriented/composition/categories.dart';
import 'package:dart_tutorial1/obj_oriented/composition/directors.dart';
import 'package:dart_tutorial1/obj_oriented/composition/movies.dart';

void main()
{
  var action = Categories(categoryId:1, categoryName:"action");
  var fiction = Categories(categoryId:2, categoryName:"fiction");
  var christoper_nolan = Directors(directorId: 1,directorName: "Christopher Nolan");
  var guy_ritchie = Directors(directorId: 2,directorName: "Guy Ritchie");

  //Composition mantigi bu sekilde foregin key lerin nesnesini movies class i iceine yerlestirmeye composition diyoruz
  var inception = Movies(movieId: 1, movieName: "Inception", movieYear: 2010, category: action, director: christoper_nolan);
  var snatch = Movies(movieId: 2, movieName: "Snatch", movieYear: 2000, category: fiction, director: guy_ritchie);

  inception.showMovie();
  print(".......................................");
  snatch.showMovie();
}