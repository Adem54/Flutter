import 'package:dart_tutorial1/obj_oriented/inheritance/car.dart';

class Nissan extends Car {
  String model;//Nissana ozel(GT-R)
  bool hasProPilot;

  Nissan({required this.model, required this.hasProPilot, required super.doorCount,
    required super.isAutomatic, required super.brand, required super.year,
    required super.maxSpeed });

  void launchControl() {
    print("$brand $model launch control aktif!");
  }
//extends ile miras alıyoruz.
//super.xxx ile super class veya base class-sınıfın constructor parametrelerini geçiriyoruz.
//Nissan nesnesi hem Vehicle hem Car alanlarını/methodlarını kullanabilir.
//Ama Car ve Vehicle, Nissan’a özel alanları/methodları göremiyor.
//Her class ancak 1 tane superclass veya base class i inherit edebilir
}
/*
Yukardaki constructor kullanimi bu yazdigim ile ayni islevdedir sadece yukaredaki kullanilan kisaltmadir bu yoruma yazdigm ise klasik kullanimdir
Ve her ikisinin de islevi ayndir:

Nissan({
  required this.model,
  required this.hasProPilot,
  required int doorCount,
  required bool isAutomatic,
  required String brand,
  required int year,
  required double maxSpeed,
}) : super(
      doorCount: doorCount,
      isAutomatic: isAutomatic,
      brand: brand,
      year: year,
      maxSpeed: maxSpeed,
    );

* */