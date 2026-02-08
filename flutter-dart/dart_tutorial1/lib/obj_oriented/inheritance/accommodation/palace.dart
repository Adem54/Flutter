import 'package:dart_tutorial1/obj_oriented/inheritance/accommodation/house.dart';

class Palace extends House{
  int numberOfTowel;
  /*
  Bu constructor kullanimi aslinda sunun ile aynidir:
  Palace({
    required this.numberOfTowel,
    required super.countOfWindow, // <-- Kısaltma
  }); asagidaki kullanim klasik kullanimdir, benim burda yazdigim ise kisaltma kullanimdir ama islevleri aynidir
  * */
  Palace({required this.numberOfTowel, required int countOfWindow }):super(countOfWindow: countOfWindow);
  //DIKKAT...BU SEKILDE..SUPER CONSTCTOR DA PARAMTRE GONDERMEMIZ GEREKIYOR
//ONCELIKLE PALACE IN NEW LENIRKEN ILK ONCE EXTEND ETTITG I INHERIT ETTIGI SUPER-BASE CLASS IN NEW LENMESI GEREKIR
// ONDNA DOLAYI DA BIZIM SUPER CLASS IN CONSTRUCTORINI CALISTIRMAMIZ GEREKIR
//AMA BIZ DIKKAT...SUPER-BASE CLASS IN TALEP ETTIGI CONSTRUCTOR PARAMETRESINI DE DISARDAN ALMAK ISTIORUZ..
// YANI BIZ TASLAK OLUSTUYROUYZ DIREK SABIT DEGERLER ATAMIYORUZ ONDAN DOLAYI BU SEKILDE YAPARIZ
}