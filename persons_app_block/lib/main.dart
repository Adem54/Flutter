import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persons_app/ui/cubit/detail_page_cubit.dart';
import 'package:persons_app/ui/cubit/homepage_cubit.dart';
import 'package:persons_app/ui/cubit/register_page_cubit.dart';
import 'package:persons_app/ui/views/homepage.dart';
import 'package:persons_app/ui/views/homepage2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   // DIKKAT REGISTERPAGECUBIT IMIZI CALISMASI ICIN UYGULAMAMIZA MAINDARTTA ANA MATERIALAPP I
    // BIZIM MultiBlocProvider ILE SARMALAMZM GEREKIYORDU

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>RegisterPageCubit()),
        BlocProvider(create: (context)=>DetailPageCubit()),
        BlocProvider(create: (context)=>HomepageCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
      
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        ),
        //home: const Homepage(),
        home: const Homepage2(),
      ),
    );
  }
}
/*
* Block patterni kullanabilmek icin flutter_bloc kutuphanesini yukleriz pubspec.yaml icerisinde:
* # versions available, run `flutter pub outdated`.
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc:  dikkat flutter ile ayni hizada olacak ve flutter_bloc: karsina birsey yazmassak son versiyonu alir ..
* */
/*
SQL-LITE KULLANIM..
Sql liste icin DBBrowser i indiririz orda bir tane database ve icine persons tablosu olusutrup iceriinddede 2-3 tane data ekleriz...
sqllite tools da veritabani olusturunca bir dosya olusturuyor...o dosyayi biz flutter projemizde sql-lite kullanmak icin kullanacagiz

KUTUPHANELERI EKLEMEYI UNUTMAYALIM-SQL LITE I KULLANACAGIMZ ICIN ONUN LA ILGLI path: ve sqflite kutphaneinsi ekleriz!!!!!!!
* Sql lite i kullanabilmemiz icin pubspec.yaml da bir kutuphane ekleyecegiz:
* sqflite ismindekutuphaenimizi flutter_bloc: altinda path:(kopyalama islemi yapmak icin veritabanina erismeye caliskren onunla ilgil
*  bir kutupoane> dedikten sonra onun da altina sqflite: ekleriz..
*dependencies:
  flutter:
    sdk: flutter
  flutter_bloc:
  path:
  sqflite:

*********phonebook.sqlite dosyasi olusturup projemizde datbase isminde klasoru olusutup icine kopyalariz **************
  //Sonrasinda da gidip sql lite peson isminde tablo olusturup icerisined e 2 tane ornek
  data ekledik burda biz islemlerimiz artik db uzerindedn ypacagiz
  Veritabani ismimiz phonebook.sqlite ..phonebook veritabani ismimiz oluyor yani sqllite in bize ilk once bir
   klasor e kaydettirdgi klasore veridgimz isim veritabani ismidir
   Veritabani icin olusturulan phonebook.sqlite dosyasi bizim veritabnimizin bir kopya dosyasidir..ayni word dosyasi kopyasi gibi
   Bu dosyayi phonebook.sqlite in uzerine gelip copy deriz ve biz persons_app_block projemize androiod studio icerisne aktaracagiz...
   Ana klasorumuz olan persons_app_block u secip add-new deriz database isminde klasor olsuturup
   phonebook.sqlite dosyasin bir kopyasini bu database klasoru icerisne atariz
   Biz phonebook.sqlite dosyasini kopyalayarak persons_app_block/database/phonebook.sqlite yaptik
   bu phonebook.sqlite Flutter klasoru altinda olusturdugmz orjinal phonebook.sqlite ile ayni degil kopyasidir

   Sonra lib altinda sqlite isminde klasoru olustuyrouz, database/phonebook.sqlite dosyasina erisebilecek paket olsuturmak icin
  lib/sqlite altinda bir DatabaseAssisten class i olusturduk phonebook.sqlite databas dosyamiza baglanti kurup ordaki datalari alabilmek icin

  *********database/phonebook.sqlite dosysini pubspec.yaml de sistemimize tanittmamiz gerekiyor ********************
flutter:

  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the material Icons class.
  uses-material-design: true

  assets:
    - database/phonebook.sqlite
  # To add assets to your application, add an assets section, like this:

  pub get diyerek bu dosyasimizi da sistemimizn tanimasini saglariz

  Ayrica bizim ekledigmz diger kutuphanlerimiz ise asagidaki amaclar icin var idi
  path: bu kopyalama islemlerini yapmamizi saglar
  sqflite: bu da sqllite ile calisabilmemizi saglar

  Artik veirtabani islemleri icin haziriz, veriliermiz direk phonebook.sqlite dan aliriz repostorymizi icerisinde

* */