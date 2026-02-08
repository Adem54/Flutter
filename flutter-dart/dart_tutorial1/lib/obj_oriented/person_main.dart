import 'package:dart_tutorial1/obj_oriented/person.dart';
void main()
{
  var person1 = Person();
  person1.firstName = "Adem";
  person1.lastName = "Erbas";
  person1.age = 38;

  person1.ShowFields();
  person1.setFirstName("Adem");
  print(person1.firstName);
  person1.setLastName();
  print(person1.lastName);

  print("-----------------------------------");
  String firstName = person1.getFirstName();
  print("FirstName:  ${firstName}");
}