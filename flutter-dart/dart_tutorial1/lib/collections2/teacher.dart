import 'package:dart_tutorial1/collections2/person.dart';

class Teacher implements IPerson{
  @override
  String firstName;

  @override
  int id;

  @override
  int no;

  @override
  String lastName;

  Teacher({required this.id,required this.firstName, required this.lastName, required this.no});

  @override
  String getFirstName() {
    // TODO: implement getFirstName
    return firstName;
  }

  @override
  String getLastName() {
    // TODO: implement getLastName

    return lastName;
  }

  @override
  void showFullName() {
    // TODO: implement showFullName
    print("Fullname is :${firstName} ${lastName}");
  }

}