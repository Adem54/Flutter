import 'package:dart_tutorial1/obj_oriented/inheritance/accommodation/house.dart';

class Villa extends House{
  bool isGarageExist;

  //super burda baseclass veya superclass olan House u temsil ediyor
  Villa({required this.isGarageExist, required int countOfWindow}):super(countOfWindow: countOfWindow);
}
//Bizim taslaklara ihtiaycimz var, sabit degerlere degil