import 'package:dart_tutorial1/obj_oriented/inheritance/accommodation/house.dart';
import 'package:dart_tutorial1/obj_oriented/inheritance/accommodation/palace.dart';
import 'package:dart_tutorial1/obj_oriented/inheritance/accommodation/villa.dart';


void main()
{
  var palace1 = Palace(numberOfTowel: 10, countOfWindow: 200);
  print(palace1.numberOfTowel);
  print(palace1.countOfWindow);


  //TIP KONTROLUNU BIZ KENDI OLUSTURDUGMZ CLASS LAR ICIN BIR CLASS IN INSTANCES I MI GIBI SORGULAYABILIRIZ..
  if(palace1 is Palace)
    {
      print("Yes palace1 is a Palace");
    }else{
    print("No palace1 is not a Palace");
  }

  print("---------------------------");
  
  var villa1 = Villa(isGarageExist: true, countOfWindow: 180);
  print(villa1.isGarageExist);
  print(villa1.countOfWindow);

  //UPCASTING ORNEGI
  House house = Palace(countOfWindow: 160,numberOfTowel: 24);//Upcasting...Palace i House a atayarak onu House yaptin aslinda..House gozlugu taktin ona UPcasting
  //AMA DIKKAT...BURYA...HOUSE EVET BIR PALACE DEGILDIR...AMA PALACE BIR HOUSE DUR DIYEBILRIZ ONU INERIT ETTIGI ICIN ANCAK..
  // .HOUSE PALACE IN REFERANSINI TUTABILYOR..ISTE KRITIKNOKTA DA BUDUR...
  // Villa palace3 = Palace(countOfWindow: 160,numberOfTowel: 24); AMA BURDA HATA ALIRIZ CUNKU VILLA ILE PALACE ARASINDA HERHANGI BIR INHERIT RELATION I YOKTUR BUNU YAPAMYZI O YUZDEN
  print(house.countOfWindow);
  //print(house.numberOfTowel);//YANLIS HOUSE GOZLUGU ILE PALACE A AIT BIR FIELDE ERISEMEZSIN, AYNI REFERANSI GOSTERSELER BILE

  //Upcasting: Palace/Villa -> House (otomatik)
  //Upcasting = “Palace nesnesine House gözlüğü takmak” (otomatik, güvenli)..
  // House baseclass-superclass inin kendi subclass i olan Palace in referansin tutabilmesi kendi referans tutucusina Palace tan bir instance nin atanaiblmesidir...
  //Downcasting: House -> Palace/Villa (ancak gerçekten o tipse, as veya is ile)
  //Downcasting = “House referansına Palace gözlüğü takmak” (ancak gerçekten Palace ise)

  //DOWNCASTING ORNEGI
  Palace palace2 = house as Palace;
  print(palace2.numberOfTowel); // ✅ artık Palace özelliklerine erişirsin

  //Secur downcasting
  if (house is Palace) {
    print(house.numberOfTowel); // sadece gerçekten Palace ise
  }

  House house2 = Villa(isGarageExist: true, countOfWindow: 140);//UPCASTING
  //SECURE DOWCASTING
  //Güvenli downcasting: is ile kontroL
  if (house2 is Villa) {
    // Burada Dart otomatik olarak h'yi Villa gibi kabul eder
  //DOWNCASTING..
    print(house2.isGarageExist); //
  }
}
//Downcasting:House un super class-base class olan House un onun subclass i olan Villaya donusmesi...
//Downcasting (explicit cast gerekir) + as

//Upcasting:Sublcass olan Villa veya Palace in superclass-baseclass lari olan House a donusmesi
//House h1 = Palace(numberOfTowel: 10, countOfWindow: 200); // ✅ upcasting
//  print(h1.countOfWindow); // ✅ House alanı
//// print(h1.numberOfTowel); // ❌ HATA: House tipinde numberOfTowel yok
//Çünkü değişkenin tipi House. Elinde aslında Palace objesi var ama “gözlüğün” House gözlüğü. Sadece House üyelerini görürsün.


//Villa ile Palace arasinda herhangi bir inheritance iliskisi olmadiigi icin aralarinda casting yapilmamaz..donusum yoktur

//Simdi Palace House u extend, inherit ettigi icin ayni zamanda Hosue dur diyebiliriz....
//Ancak House bir dogrudan Palace dir diyemeyiz ama downcasint ile Palace yapabilirz
// yani ona Palace gozlugu ile bakabilirz as kullanarak asgidaki ornekteki gibi
//Palace palace2 = house as Palace;

//SUNU DA TAM OLARAK ANLAYALIM KI BIZ NEDEN HOUSE A DIREK ONU INHERIT EDEN PALACE, VILLA INSTANCESINI ATAYABILIRKEN..
// CUNKU HOUSE YANI SUPERCLASS-BASECLASS CUNKU ONU INHERIT EDEN SUBCLASS LARIN REFERANSINI TUTABILYOR AMA
// NEDEN DIREK OLARAK PALACE VEYA VILLA SUBCLASS INI INHERIT ETTIKLERI SUPERCLASS VEYA BASE CLASS OLAN HOUSE DAN OLUSTURULAN INSTANCEYE ATANAMAYIYOR CUNKU...
//HOUSE SUPERCLASS, BASECLASS BIRSURU SUBCLASS TARAFINDAN INHERIT EDILEBILECEGI ICIN HOUSE DAN OLUSTURULAN INSTANCEININ ONU INHERIT EDEN HANGI SUBCLASS IN REFERANSIN TUTACAGINI BILEMEZ
// ...ONUN ICIN AS ILE DOWNCASTING ILE BUNU BELIRTILDIGI ZAMAN ANCAK O ZAMAN ISI YAPAILIYORUZ...