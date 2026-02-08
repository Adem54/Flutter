import 'package:dart_tutorial1/obj_oriented/inheritance/vehicle.dart';

class Car extends Vehicle{
  int doorCount; //Kapi sayisi(car sinifina ozel)
  bool isAutomatic; //Otomatik mi?

  Car({required this.doorCount, required this.isAutomatic,required super.brand, required super.year, required super.maxSpeed});

  void honk()
  {
    print("$brand horn honked");
  }
}