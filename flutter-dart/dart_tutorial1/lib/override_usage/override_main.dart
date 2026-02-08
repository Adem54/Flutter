import 'package:dart_tutorial1/override_usage/Mammal.dart';
import 'package:dart_tutorial1/override_usage/animal.dart';
import 'package:dart_tutorial1/override_usage/cat.dart';
import 'package:dart_tutorial1/override_usage/cow.dart';
import 'package:dart_tutorial1/override_usage/dog.dart';
import 'package:dart_tutorial1/override_usage/ship.dart';

void main()
{
  print("------------------show animal-----------------");
  var animal1 = Animal();
  animal1.makeSound();
  print("------------------show mammal-----------------");
  var mammal1 = Mammal();
  mammal1.makeSound();

  print("------------------show cow-----------------");
  var cow1 = Cow();
  cow1.makeSound();
  print("------------------show ship-----------------");
  var ship1 = Ship();
  ship1.makeSound();

  print("------------------show cat-----------------");
  var cat1 = Cat();
  cat1.makeSound();

  print("------------------show dog-----------------");
  var dog1 = Dog();
  dog1.makeSound();
}