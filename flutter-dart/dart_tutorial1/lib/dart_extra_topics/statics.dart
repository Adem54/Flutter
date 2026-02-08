import 'package:dart_tutorial1/dart_extra_topics/a_class.dart';
void main()
{
  // class larda class i new lemeden direk class ismi ile static degisken ve static methjodlara erisebiliirz..
  var a1 = AClass();
  //Standart Usage
  print(a1.variable);
  a1.method();
  print("******************************");
  //Virtual-Sanal object-nesne..ASAGIDAKI GIBI DE CLASS ISMINI DIREK CONSTURDCTORI CALISTIRARAK KULLANIP MEMBER ACCESS ILE FIELD, METHOD DA ERISEILDIK...DIREK OLARAK
  //AClass() bu ismi olmayan nesne demektir...onemli...YANI ZATEN NORMALDE DE YUKARDA BIZ a1 e aktardgimz AClass() ini,
  // asagida direk aktarmadan kullandik aslinda ama dikkat her bir AClass(). kullaniminda yeni bir nesne olusturmus olduk aslinda ve
  // bu asagida biz 2 kez kullanarak 2 kez nesne uretmis olduk ancak yuukarda degiskene aktarip variable ve methodu o degisken uzerinden cagirdigmzda 1 kez nesne uretmis oluyoruz
  //Burda variable i cagiran ile mehtod u cagiran farkli nesneler ve performans olarak daha kotudur,daha yavastir
  print(AClass().variable);
  AClass().method();
  print("---------------------------------");
  //Static usage...DIKKAT DIREK CLASS ISMI ILE KULLANDIK.....
  print(AClass.variable2);
  AClass.myMethod();
}