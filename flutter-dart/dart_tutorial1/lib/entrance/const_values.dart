void main(){
  /*
* CONSTANTS-SABITLER
FINAL AND CONST
JAVA DILINDE FINAL, SWIFT DILINDE LET, KOTLIN DILINDE VAL OLARAK KARSIMZA CIKAR BU

* Swift dilinde eger degisken ve esitttir arsinda b osluk birakmazsak o zaman hata aliriz
*/

  int number = 30;
  number = 100;//number degiskeni
  print(number);
  final number2 = 50;
  //number2 = 120;//hata alrizi cunku:The final variable 'number2' can only be set once
  //1 kere deger atayabilirsin final ile tanimladign bir degiskeni

  const number3 = 130;
 // number3 = 220;//Hata aliriz..Constant variables can't be assigned a value after initialization.
//Sonradan tekrar degistirilemez..deger aktarilamaz..
//Mantigi bu hafizayi daha peformansli kullanaiblmek icin final , const kullaniliyor
//Simdi const-final ile belirledimgz zman bizim ona atadimgz deger e gore bir yer ayriliyor hafizada
// bu da performansa cok olumlu katikisi olyor yoksa diger degisken, dinamik olarak degisebilen degiskenler icin
// hangi deger atanacagi belli olmadigi icin, onalra daha buyuk hafiza ayriiyor

//Final ile const farki
//Final:Kodlamayi calistirdigmzda run time da hafiza da olusur, run tusuna bastigimizda
//Const ise degiskeni tanimladigmz anda hafizada olusur yani compile time da hafiza da olusur
// ondan doayi da Date.Now() i biz const a atayamayiz cunku bu run time da olusan bir methoddur, amaa final ile tanimlanabilir

//Const u genellikle gorsel nesnelerde kullaniriz.Button,Text vb yapilarda
//final i ise degisken lerde kullaniriz daha cok
}