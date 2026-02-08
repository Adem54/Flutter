void main()
{
  var  mySet = <String>{};
  mySet.add("a");
  mySet.add("b");
  mySet.add("a");
  print(mySet);//{a,b} duplikat eklemeye izin vermez

  //print(mySet[0]);//hata alirsin- Set'te index yok, bu mantık yok.


  //sette direk olarak contains i check edegbilirsin var mi yok mu diye...
  print(mySet.contains("a"));//true
  print(mySet.contains("b"));//true
  print(mySet.contains("c"));//false

  //Set’in temel amacı sıra değil, benzersizlik.
  //Sen ekleme sırası görsen bile şuna güven:
  //ayni eleman olmaz, contains hizli..
  //❌ “3. eleman şudur” gibi düşünme

  //MAP (HashMap) — key:value sözlüğü + key unique

  var ages = {
    "Ali":20,
    "Ayse":22
  };

  //key ile erisim
  print(ages["Ali"]);//20
  print(ages["Ayse"]);//22

//Aynı key tekrar yazılırsa value güncellenir (üstüne yazar)
  ages["Ali"] = 25;

  print(ages["Ali"]);//25

  //Key değiştirebilir miyiz?
  //Direk rename yapamiyoruz,key ini degistirmek istedgimz value yi yeni bir key e atariz once,
  // sonra da eski keyi sileriz ve bu sekilde ancak key i degistirip istedigmiz value yi yeni isimlendirdigmz keye verebiiriz

  //Map’te index yok; key senin “adresin”
  //
  // List: liste[2]
  // Map: map["Ali"]
  //
  // Biri “2. eleman” mantığı, diğeri “Ali’nin bilgisi” mantığı.
}