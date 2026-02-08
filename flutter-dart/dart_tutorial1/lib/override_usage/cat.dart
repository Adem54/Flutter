import 'package:dart_tutorial1/override_usage/Mammal.dart';

class Cat extends Mammal{

   @override
  void makeSound()
   {
     print("Cat: meow");
   }
}