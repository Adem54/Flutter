import 'package:dart_tutorial1/override_usage/Mammal.dart';

class Ship extends Mammal{

    @override
  void makeSound() {
    // TODO: implement makeSound
    super.makeSound();//kendi inherit ettigi Mammal icine bakar bu fonks orda eger ki override edilmi ise onu baz alir yok,
      // eger override edilmemis ve o fonks inherit ettig i Mammal da baska bir class i inherit etmis ise, Mammal in inherit ettig fonks dan gelir
      //Dolayisi ile buraya Ship->Mammal->Animal...Animal iceriisnde donen sonucu donecektir cunku super.makeSound Animal icinde tanimlanmis...
  }
}