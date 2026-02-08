import 'package:dart_tutorial1/override_usage/Mammal.dart';

class Dog extends Mammal
{
  @override
  void makeSound() {
    // TODO: implement makeSound
    super.makeSound();//inherit edilen class icinde kullanilmis ise o gelir, eger orda yok da o inherit edilen Mammal class i da baska
    // bir Animal gibi class i inherit etmis ise o zamand a animal icerisinde nasil kullanilmis ise o gelir buraya
    print("Dog: woof");
  }
}