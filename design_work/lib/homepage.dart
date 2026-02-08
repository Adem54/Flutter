import 'package:flutter/material.dart';
import 'package:design_work/colors.dart';
//simdi biz class ismini yazariz kendimiz...Homepage ismini vererek...Homepage buyuk olacak..
class Homepage extends StatefulWidget{
  const Homepage({super.key});
  //StatefullWidget in son 2 harfi silip tekrar yazarsak oneriler getirir material dart i seceriz..
  // yuklariya material dart i import eder ve tum hatalar silinir
  @override
  State<Homepage> createState() => _HomepageState();
}
//Ustteki Homepage class yapisi alttaki _HomepageState yapisini temsil ediyor,
// ama biz Homepage ile ilgli tasarimlari _HomepageState deki build mehtodu icerisinde yapacagiz
//_State yazan yere de _HomepageState yazacagz

//Dikkat edelim _HomepageState zaten Homepage i aliyor State icinde..
// ve bu _HomePageState e Homepage ozelligini zaten aktariyor bu sekilde ve
// biz zaten burda _HomepageState icinde Homepage i aslinda degistirmis olacagiz..build icerisinde
class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    //Ekran bilgisini biz bu sekilde alabilyoruz..
    var screenInfo = MediaQuery.of(context);
    final double screenHeight = screenInfo.size.height;
    final double screenWidth = screenInfo.size.width;
    print("ScreenHeight: $screenHeight");
    print("ScreenWidth: $screenWidth");

    //return const Placeholder();
    return Scaffold(
      //tutor da direk title ortali geldi bende sola yasli o yuzden ben centerTitle:true kullandim..cunku tutor mac kullaniyor
      // ve onda default u ortali gelirken bende android de default sola dayali geliyor ortlaamasi icin centerTitle:true kulanmam gerekti
      appBar: AppBar(centerTitle: true,
        title: Text("Pizzaa", style:TextStyle(color: fontColor1 , fontFamily: "Pacifico", fontSize: screenWidth/19)),),
      //screenWidth 411 olarak geldi bze bunu yaklasik olarak 20 ye bolerek yani fontsize i 20 de 1 i olarka verdikkik
      // ekranin buyumesine gore yazi da kendini ayarlayacakki bu sekilde...ekran buyuyunce yazi da buyumus olacak,
      // kuculunce yazid a kuculmus olacak..ve responsive mantigini uygulamis olacagiz
      body:const Center(//bunu da sabit yapiyoruz...ozellikle burda degisken dinamik bir yapi olmadigi icin..ekliyoruz...
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,//bu sekilde dikey de ortalamayi saglariz...
        children: [
          Text("Hello world", style:const TextStyle(fontSize:50 ),//direk 50 verdik ya sabit dinamik deigl o zaman const yapiki diyor
      // bunu her seferinde build de yeni bir instance olusturmaz ve ayni instanceyi kullanarak ciddi bir performans kazanim i saglar
    )
      ],
    ),//kolon koy , alt alta tasarim yapacagiz demek..
    ),//Sayfayi icindeki yapi ile beraber ortalayacak anlamina geliyor..yatay ve dikey de ortalayacagiz
    );
  }
}

//st yazdigmzda statefull, stateless diye secenekler  geir biz simdi statefull secelim..cunku dinamik yapmak isstyourz
//stful-stless(sabit-dinamik olmayan...stateless)demektir
//Ilk once bu Homepage class imizi maindarta tanitacagiz..
/*
Biz...build icerisinde ornegin
Scaffold ne?
Bu yapi material.darttan gelen bir yapidir..import 'package:flutter/material.dart'
Sayfa alt yapsini olusturdugmz bir yapidir
Sayfayi iskeletini ve genel layoutu ve birseyleri sabitlemek zor oldugu icin, Scaffold gibi yapilarla biz
hizlalama sabitleme..vs gibi boyle iste ustbarda, orta icerik..alt kisim vs bunmlari kolayica hizalayabilecegiz...
Material sayfa iskeleti
appBar (üst bar)
body (orta içerik)
"floatingActionButton (sağ alttaki + butonu)
gibi alanları hazır sağlar."

AppBar
Üstteki başlık barı.
title: Text(widget.title),

Burada widget.title diyoruz çünkü:
_MyHomePageState içindeyiz (State sınıfı)
State içinde, bağlı olduğun widget’a widget ile erişirsin.

body: Center -> Column -> Text...
Center: içeriği ortalar
Column: çocukları dikey dizer
"Text('$_counter'): _counter değerini string içinde gösterir
('$_counter' string interpolation)"
FloatingActionButton
onPressed: _incrementCounter,
Butona basınca _incrementCounter() çalışır → setState çağrılır → build() tekrar çalışır → sayı güncellenir.
 */