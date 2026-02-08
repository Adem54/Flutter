import 'package:dart_tutorial1/obj_oriented/inheritance/car.dart';
import 'package:dart_tutorial1/obj_oriented/inheritance/nissan.dart';
import 'package:dart_tutorial1/obj_oriented/inheritance/vehicle.dart';

void main()
{
  var vehicle1 = Vehicle(brand: "Nissan", year: 2022, maxSpeed: 260);
  var car1 = Car(doorCount: 5,isAutomatic: true, brand:"Nissan",year: 2022,maxSpeed: 260 );
  var nissan1 = Nissan(model: "GT-R",hasProPilot: true,doorCount: 5,isAutomatic: true, brand:"Nissan",year: 2022,maxSpeed: 260);

  nissan1.launchControl();
  nissan1.honk();
  nissan1.start();

  //car1.launchControl();
  //buraya erismez car..cunku car nissan tarafindan extend edildi, inherit edildi, Car nissan in superclassi,
  // nissan da carin subclassi, superclass subclass a ozel feield ve methodlara erisemez ama subclass superclass field ve metodlarina erisebilir
  car1.honk();
  car1.start();

  //vehicle1.launchControl()// Erisemez..superclass subclass ait bir methjoda erisemez..
  //vehicle1.honk();Erisemez
  vehicle1.start();
}