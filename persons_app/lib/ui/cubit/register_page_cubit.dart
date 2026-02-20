import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persons_app/data/repo/persons_dao_repostory.dart';

class RegisterPageCubit extends Cubit<void> {

  RegisterPageCubit():super(0);//super paramtresine deger bekler voiddede void oldugunda 0 yzabiirz herhangi bir etkisi olmayack zaten
   PersonsDaoRepostory personsDaoRepostory = PersonsDaoRepostory();

   //Evet iste cubit in islevi tam olarak bu, repostory ye islemi yaptirir ve ui ya gerktiginde
   //ihtiyac oldugunda, veri donmek icin emit yapark ui dak i veryi setState kullanmadan build yapmadan gostermeyi saglar
   //Ama bu save isleminde butona tiklandiktan sonra register sayfainsnda herhangi bir veri dondurulmeycegi icin
   // bu save fonks iyonu da void olacaktir egerornegin string turunde veri donecek olsa idi veya Perosn tipinde
   // veri donecek olsa idi o zaman Person tipinde veri donecek sekilde imzasini yaazmaiz gerekirdi Save butoununu
   // ama return edilen deger olmaycagi icin hem void olacak hemde herhangi bir emit yapmaycagiz
   Future<void> Save(String name, String phone) async
   {
     await personsDaoRepostory.Save(name, phone);
   }

}

/*
Register page:
* Once register sayfasini analiz ederk baslariz...
* Register sayfasi bizden disardan veri istiyor mu buna odaklanalim...
* Disardan input-TextField ile name,mobile girisi olacak kullanici tarafindan ve sonra bunu save-ile datbase e kaydedecek
* Register-veya Save butonuna basildiktan sonra register sayfsina birsey getirilmeyecek..bu farkli senaryolarda olabilir ama
* bizim senaryomuz simdilk boyle..Yani kaydettigi kisiyi homepage e donunce gorecek, ama register sayfasinda kayit isleminden
sonra kaydettigi kisi ile ilgil birsey register sayfasina donmeyecek
O ZAMAN HEM YORUMUMUZU YAPALIM...EGER ARA YUZDE BIR VERI GOSTERILMIYORSA, BIRSEY RETURN EDILIP KULLANICYA BIR VERI SUNULMUYORSA,
O ZAMAN EMIT ISLEMI OLMAYACAKK DEMEKTIR.., YANI TETIKLENME ISLEMI YANI BUTONA BASILMA-YANI-TAP ISLEMI VEYA HERHANGI BIR INTERAKTIF
LIK SONUCUNDA EGER KULLANICIYA BIR VERI DONDURULUP KULLANICYA BIR VERI GOSTERILMIYOR ISE O ZAMAN CUBIT DOSYASI ICINDE EMIT ISLEMI
OLMAYACAK DEMEKTIR...ONEMLI

MANTIGI HATIRLAYACAK OLURSAK EGER!!!!
Simdi onceki ornekte de input-textfield dan gelen deger aliniyor, cubit icinde calisacak olan method a paremetre olarak gidiyordu
ve eger bu butona tiklama sonucu ara yuzde gosterilecek bir degeri etkilyor ise, o cubit icinde calisacak fonksiyon icerisinde,
 return olacak degeri ortak repostoryden gelen fonks ile alip return degerini alip emit  yaparak bunu ui yda gozukmesini sglayakti
  mantik tam olarak bu skilde idi....

  ISTE BU REGISTER ISLEMINDE DE AYNEN MANTIGIM Z BOYLE SAVE BUTONUNA TIKLAYINCA NAME VE MOBILE VERILERI ALINIR VE BUTON ICINDE,
  CUBIT ICINDE CALISACAK OLAN FONKS TETIKLENIR VE PARAMTRESINE DE NAME VE MOBILE NO GONDERILIR CUBIT ISE SAVE ISLEMINI YAPAN
  ETHODU REPOSTORY DEN ALIR VE SAVE ILSEMINI YAPTIRIR ANCAK UI YA HERHANGI BIR DATA GOSTERILMEYECEGI ICIN SAVE SONUNDA,
  O ZAMAN HERHANGI BIR SEYI TETIKLEME YE GEREK DE OLMYOR DOLAYIS ILE EMIT KULLANMAYA GEREK KALMIYOR BURAYI DOGRU ANLAYALIM....
*
Homepage-Persons page e diyebiliriz personlistesin oldug icin
Bu sayfa homepage sayfasin ara yuzunu persons listesini bekelyen bir sayfay...yani sayfasinda person listesini gosteriyr kullaniciya..

!!!!!!!!!!!!!!!!!DIIKKAT
DIKKAT REGISTERPAGECUBIT IMIZI CALISMASI ICIN UYGULAMAMIZA MAINDARTTA ANA MATERIALAPP I BIZIM MultiBlocProvider ILE SARMALAMZM GEREKIYORDU

  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context)=>RegisterPageCubit())],
      child: MaterialApp(
        title: 'Flutter Demo',
!!!!!!!!!!!!!!!!!DIKKAT ONEMLI
* */