import 'package:design_work/homepage.dart';
import 'package:design_work/testpage5.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart'; // yol sende böyle

void main() {
  runApp(const MyApp());
}

//run ana MyApp i calistiracak...MyApp de bizim uygulamamizi calistiracak
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,//sayfanin sag ust kosesindeki debug yazsinin kaldirmayi saglar
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate, // <--bu kendisi gelmkyor bizim gidip yukari import yazmamiz gerekiyor...import 'l10n/app_localizations.dart';
       //Alttaki 3 u ise burdan geliyor:import 'package:flutter_localizations/flutter_localizations.dart';
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: const [
        Locale('en'),
        Locale('tr'),
        Locale('no'),
      ],
     // home: const Homepage(),//simdi dikkat edelim...dartta birdosyanin gelmesi icin onu biraz silip bastan yazmak gerekiyor ki
      home: const Testpage5(),
      //editor taniyabilsin bu onemli...yoksa dogru yazsak bile hata gostermeye devam edebilir
    );
  }
}
//Simdi biz home:karsina home page imizi olusturmamiz gerekiyor
//Biz bu homepage i direk bu main.dart da da olusturabiliriz ama bu moduler aclaisma mantigina uygun degildir..ondan dolayi
//lib altinda homepage.dart olsutururuz..


/*
Simdi biz bir uygulama gelistirirken renk belirlerken o rengi bir degiskene atayip
istedigmz her yerde kullanacagiz...Bu onemli...ilerde cunku renkleri degistrebiliriz..
Bir yerde degistirerek 1 hamlede tum projede yerleri degistireiblirz...
Material color..google un sundugu..material design
Renk icin materialpalette.com kullanabilirz
https://www.materialpalette.com/
Burda renk secerken o renge uygun tonlarini da secebilmek cok onemlidir
Hexedecimal nedir:Heksadesimal (Hex), bilgisayar bilimleri ve dijital sistemlerde kullanılan,
 16 tabanlı bir sayı sistemidir; 0-9 rakamları ile A-F harflerini (10-15'i temsil eder)
  kullanarak 16 farklı sembol ile sayıları ifade eder ve özellikle ikili (binary) verileri
  daha okunabilir şekilde gruplamak ve web tasarımlarında renkleri belirtmek için
  (RGB değerleri olarak # ile başlar) kullanılır.
Hexedecimal->#512DAB=>16 li sayi sistemi
Temel Özellikleri
Taban: 16 tabanlıdır. Ondalık sistem 10 (0-9) kullanırken, heksadesimal 16 sembol kullanır.
Semboller: 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 rakamları ve A, B, C, D, E, F harfleri kullanılır.
A = 10, B = 11, C = 12, D = 13, E = 14, F = 15 değerlerini temsil eder.
Kullanım Alanları:
Bilgisayar Bilimi: İkili sayıların (binary) 4 bitlik gruplar halinde daha kısa ve anlaşılır temsilini sağlar.
Web Tasarımı: Renkleri (#RRGGBB formatında) tanımlamak için kullanılır, her iki karakter kırmızı, yeşil ve mavinin (RGB) yoğunluğunu belirtir.
Neden Kullanılır?
Bilgisayarlar ikili (0 ve 1) sistemde çalışır. Heksadesimal sistem, bu uzun ikili dizileri (örneğin, 10110010) daha kısa ve hatırlanması kolay hex değerlerine (örneğin 0xB2) dönüştürerek programcıların ve sistemlerin veriyi daha rahat işlemesini sağlar.
Örnek
Ondalık 255 sayısı, hex'te FF'dir (15x16 + 15x1).
Bir renk kodu olan #FF0000, tamamen kırmızı anlamına gelir (FF kırmızı, 00 yeşil, 00 mavi).
51=>Kirmizi sonraki 2 hane yesil son 2hane maviyi -RGB...RedGreenBlue

https://materialui.co/colors
https://dribbble.com/tags/uplabs  bu site de mobile desing ile ilgili renk, tasarim inspiration i almak icin kullanabiliirz
Tasarimlari vs figma ile yapabilirz...ozellikle prototype kullanirken cok etkili
color.adobe.com...var kesfedin..burda mesela uygulamanizda istedginiz kelimeiligil resim ve renk paletleri oneriyor..
Trentler, trent olan renk ve tasarimlar incelenebilir
 */

