import 'package:design_work/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './l10n/app_localizations.dart'; // bulunduğun dosyaya göre yolu ayarla
//simdi biz class ismini yazariz kendimiz...Homepage ismini vererek...Homepage buyuk olacak..
class Testpage4 extends StatefulWidget{
  const Testpage4({super.key});
  //StatefullWidget in son 2 harfi silip tekrar yazarsak oneriler getirir material dart i seceriz..
  // yuklariya material dart i import eder ve tum hatalar silinir
  @override
  State<Testpage4> createState() => _TestState4();
}

class _TestState4 extends State<Testpage4> {
  @override
  Widget build(BuildContext context) {
    //Ekran bilgisini biz bu sekilde alabilyoruz..
    var screenInfo = MediaQuery.of(context);
    final double screenHeight = screenInfo.size.height;
    final double screenWidth = screenInfo.size.width;
    print("ScreenHeight: $screenHeight");
    print("ScreenWidth: $screenWidth");

    //Coklu dil ile ilgli degiskenimize bu sekilde erisecegiz...
    var d = AppLocalizations.of(context);
    //Degisikliklerimiz i burda yapacagiz...
    //return const Placeholder();
    return Scaffold(
      //eN UST KISIM...WEB DE HEADER OLARAK ADLANDIRILAN MOBILE DE APPBAR ISMI ILE ADLANDIIRLAN EN USTTEKI KISIMDIR
      appBar: AppBar(
        centerTitle: true,//AppBar a girilen text i yatay da ortalma demek(align-center gibi web deki)
        //BURAYA DIKKAT,BURDA CONST TEXT YAZARSAK TEXT ICINDEKI STYLE DA DINAMIK BIR RENK DEGISKENI KULLANAMAYIZ ONDAN DOLAYI CONST I KALDIRDIK
        title:  Text("Pizza", style:TextStyle(color:fontColor1, fontWeight: FontWeight.bold, fontFamily: "Pacifico", fontSize: screenWidth/19  )),
        //screenWidth 411 olarak geldi bze bunu yaklasik olarak 20 ye bolerek yani fontsize i 20 de 1 i olarka verdikkik
        // ekranin buyumesine gore yazi da kendini ayarlayacakki bu sekilde...ekran buyuyunce yazi da buyumus olacak,
        // kuculunce yazid a kuculmus olacak..ve responsive mantigini uygulamis olacagiz
        //YANI ASLINDA MANTIGIIMZ HEP RESPONSIVE MANTIGI OLACAK YANI screenWith e oranla yapaagiz asagidakullanidgimz
        // padding,top,height..vs her turlu boyut la ilgili kisiimlari ki bu sekidle yazdigmz mobile uygulama tum,
        // farkli ekranlarda tabletlerde vs ayni sekilde ekrana gore uyum saglamis sekilde calisacktir
        //DIKKAT APPBAR A YAZILAN YAZININ RENGINI BU SEKILDE DEGISTIREIBLIRIZ..
        surfaceTintColor: Colors.transparent, // <-- kritik (Material 3)
        backgroundColor: mainColor,//colors icerisinde tanimlagimz, mainColor i bu sekilde kullanabilyoruz burda
        // StatusBar (üstteki saat/ikon alanı)

      ),
      body: Center(
        child: Column(//Row la basliyorum, cunku demekki ben yanyana gelecek nesneler yerlestirecegim..
          // .ya da row yazip icine 1 kolon yazip onun icine brden fazlan nesne koyarak alt alta gelmesini de salayabiliriz
          //Row,Column,Stack nesneleri icerisinde birden fazla gorsel neseneyi gosterebilmek icin tasarlandigi icin,
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,//center deyince 3 kutuyu da o satirin ortasina yerlesecek sekilde yerlestirir
          //MainAxisAlignment.end dese idik o zaman da en sagdan sola yerlestirecektir..start soldan baslar default oldugu gibi,
          // spaceBetween en saga ve en sola bir container yerlestirir ve var ise diger lerini ortaya yerlestirerek aralarinda max bosluk olacak skeilde ayarlar...
          //spaceEvenly ise en sag ve en solda da bosluk olacak skeilde tum containerlar araasi esit bosluk koyarak ayarlar
          //crossAxisAlignment: CrossAxisAlignment.center,
          // children isimli proeprty i array olarak tutarki icerisine duruma gore birden fazla element,child yerlestirebilelim...
          children: [
            //Icerisinde gorsen nesne koyabilecegimi container nesnesi var onu kullanacgz burda..Container web deki div gibi,icerisne verdigmz nesnedin alanini kaplar
             Padding(
               //padding: const EdgeInsets.all(8.0),//Burda her tarafa 8 verecek..ama bunun yerine sadece yukari vermesni de saglayabilirz...
               padding: const EdgeInsets.only(top: 8.0),//Sadece yukariya bosluk birak diuyruz...
               //child: Text("Beef Cheese", style:TextStyle(fontSize:36, color:mainColor,fontWeight: FontWeight.bold)),
               //d!.pizzatitle burda nullable hatasi aldk ve sonra ! eklyerek cozduk...
               child: Text(d!.pizzatitle , style:TextStyle(fontSize:36, color:mainColor,fontWeight: FontWeight.bold)),
             ),//Artik bu Padding nesnemiz textimizi temsil ediyor dikkat edeliim....
            //Bu Textimize biz padding boslugu vermek istiyoruz...yani bu Text imizin icinde olduu ana kutuya padding verecegizki Text i biraz asagi ittirsin...
            //Isteboyle durumlarda nasil di yani biz bir wrapper kullanmak isityrsak yani Text i kapsayan kutu veya nesne ye verecegimz
            // ozellikle Text in yerini ayarlamk istiyorsak ne yapiyordukm, Text i seceriz sonra alt-enter yaparsak Text e uygulayabileegiz tum wrap options larini gorebiliriz...
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Image.asset("pictures/pizza_picture.png"),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // Button 1
                  //ChipBtn(content:"Cheese"),
                  ChipBtn(content:d.cheeseText),
                  /* TextButton(
                    onPressed: () {},
                    child:  Text('Cheese', style:TextStyle(color:fontColor1)),
                    style:TextButton.styleFrom(backgroundColor: mainColor),
                    ),*/
                  // Button 2
                  //ChipBtn(content:"Sausage"),
                  ChipBtn(content:d.sausageText),
                  /*TextButton(
                    onPressed: () {},
                    child:  Text('Sausage', style:TextStyle(color:fontColor1)),
                    style:TextButton.styleFrom(backgroundColor: mainColor),
                  ),*/
                  // Button 3
                  //ChipBtn(content:"Olive"),
                  ChipBtn(content:d.oliveText),
                  /*TextButton(
                    onPressed: () {},
                    child:  Text('Olive', style:TextStyle(color:fontColor1)),
                    style:TextButton.styleFrom(backgroundColor: mainColor),
                  ),*/
                  // Button 3
                  //ChipBtn(content:"Pepper"),
                  ChipBtn(content:d.pepperText),
                 /* TextButton(
                    onPressed: () {},
                    child:  Text('Pepper', style:TextStyle(color:fontColor1)),
                    style:TextButton.styleFrom(backgroundColor: mainColor),
                  ), */ //Simdi TextButtonlar artik kenarlari kivrilmis olarak, web-css deki border-radius
                  // verilmis olarak geliyor eskidenkoseli gelir biz yapardik onu ama simdi default olarak artik,
                  // border-radiis verilmios olarak gelior TextButttonlar
                ],
              ),
            ),
            //Alt alta gelmis olan 20 min, Delivery ve Meat lover,
            // get ready to meet your pizza! 3 farkli yaziyi alt alta gelecek sekilde simdi planlayacagiz
            //Ucu alt alta oldugu icin Column icerisine koyabiliriz
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [

                  // Text("20 min",style:TextStyle(fontSize:22, color:fontColor2, fontWeight:  FontWeight.bold)),
                  Text(d.deliverTime,style:TextStyle(fontSize:22, color:fontColor2, fontWeight:  FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                   // child: Text("Delivery", style:TextStyle(fontSize:22,color:mainColor,fontWeight: FontWeight.bold)),
                    child: Text(d.deliveryTitle, style:TextStyle(fontSize:22,color:mainColor,fontWeight: FontWeight.bold)),
                  ),

                 // Text("Meat lover get ready to meet your pizza!", style:TextStyle(fontSize:22, color:fontColor2), textAlign: TextAlign.center,),
                  Text(d.pizzaExplanation, style:TextStyle(fontSize:22, color:fontColor2), textAlign: TextAlign.center,),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //Iki element arasinda boslugu biz istersek Space() nesnesi ile de verebiliriz ancak bu Space aradaki tum boslugu alacaktir.
                children:[
                  //$ ile degisken atandigi icin, ters-slash ile \$ kullanirsk direk $ simgesini text olarak anlayacaktir
                  // ve bizden degisken girmemizi beklemez..
               //   Text("\$ 5.98", style:TextStyle(fontSize:44, color:mainColor,fontWeight: FontWeight.bold)),
                  Text(d.price, style:TextStyle(fontSize:44, color:mainColor,fontWeight: FontWeight.bold)),
                  SizedBox(
                    //width: 200,
                    width: screenWidth/2,//screenWidth:410..
                    //height: 50,
                    height: screenHeight/16,//Cunku screenHeight 914
                    child: TextButton(//TextButton un boyutunu degistirmek icin SizeBox ozellgini
                      // yine Wrap with Textbuttonu sec,Alt-enter a bas, ve SizedBox nesnesi ile wrap et ve
                      // Sizedbox nesnesi icerisnde 1.element olarak with-heigh kullanabilriz artik
                      onPressed: () {},
                     // child:  Text('ADD TO CART', style:TextStyle(color:fontColor1, fontSize:18)),
                      child:  Text(d.buttonText, style:TextStyle(color:fontColor1, fontSize:18)),
                      style:TextButton.styleFrom(
                        backgroundColor: mainColor,
                        //SIMDI DEFAULTU ROUNDED-OLARAK GELN BUTONU KENARLARI KOSELI YAPARAK KULLANMAK!
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)))
                      ),
                    ),
                  ),
                ]
              ),
            )
            //Container(width: 100, height: 100, color:Colors.red),
            //Container(width: 50, height: 50, color:Colors.blue),
            //Container(width: 80, height: 80, color:Colors.green),
            //Simdi row un alani olarak bu 3 alan width olarak kullandigi alandan o satirda en sagda bos kalan yer de row un alanidir,
            // yenui container bu row icine eklenirse gidip, en son container dan sonra kalan kisma yerlesecektir
            //Ayni mantikta eger biz gidip Row yerine Column yazarsak o zamanda yanyana getirdigi nesneleri alt alta getirecektir
            // ayni kolonda asgi dogru kalan bosluga ise yeni bir container eklenirse onu yerlestirecektir
            //Container width-height olarak kac verilir ise o kadar kendisini buyutecektir, o boyutu alacaktir
            //Ama bu 3 container birbirinn uzerine gelsiin istersek o zaman da Stack icerisinde tanimlariz ana birlestirici kapsyaici o zaman Stack olur

          ],
        ),
      )
    );
  }
}

//class _TestState4 extends State<Testpage4> { } bittigi yerde  olusturacak sekilde..st-yazariz ve statelessWidget gelir...
class ChipBtn extends StatelessWidget {
  //const ChipBtn({super.key});//Burayi silecegiz..cunku icerden icerik gondereceigz
  //Cunku sadece yazisi degisecek...disardan yazi-buton yaziyi alacagiz
  String content;
  //yazdiktan sonra, mouse ile saga tiklayarak Generate->constructor seceriz...
  // ve asagidaki gibi constructor icerisinde disardan textalma structurunu getirir
  ChipBtn({required this.content});

  @override
  Widget build(BuildContext context) {
    //Simdi bu Widget type inda oluyor dikkat edelim...
    //Dikkat edelim bak...return olarak TextButton gonder..ve button-text yazsini yerine contenti koy
    return   // Button 1
      TextButton(
        onPressed: () {},
        child:  Text(this.content, style:TextStyle(color:fontColor1)),
        style:TextButton.styleFrom(backgroundColor: mainColor),
      );
  }
}


/*
SPESIFIK BIR GOOGLE-FONT(PACIFICO) UN PROJEMIZDE KULLANILABILMESI
*Pacifico ismindeki google font download ediir ilk once
* design_work ana proje isminin hemen altinda directory diyerek font klasoru olustururuz..
Dikkat, lib klasoru altinda olusturursak, o zaman onu okuyamaz ondan dolayi ana klasor altinda olacak
Sonra da indirdigmz gogogle-font pacifico icinde Pacifico-Regular.ttf isminde bir dosya var onu alip fonts klasoru icerisine atariz
Simdi bu google font u projemize tanitmamiz gerkeiyor,
PUBSPEC.YAML DOSYASI ICERISINE GIDERIZ...
PROJEMIZE TANITMAK ICIN pubspec.yaml ismindeki dosya icerisine gideriz..
flutter: text i var onuun altinda tnaimlama yapacagiz

flutter:
  fonts:
    - family: Pacifico
      fonts:
        - asset: fonts/Pacifico-Regular.ttf

flutter: in altindaki kisimlari eklememeiz gerekiyor...
Sonra da pubspec.yaml da dosya ust kisminda pubgtet e tiklayarak degisikleri aktar demis oluruz
PubGet dedgizde eger console da hata mesaji gelirse, muhtemlen pubspec.yaml da hizalama hatalarimz olabilir..

Console. da bu sekilde text gorebiliriz...

C:\Users\Hp35\flutter\bin\flutter.bat --no-color pub get
Resolving dependencies...
Downloading packages...
  characters 1.4.0 (1.4.1 available)
  matcher 0.12.17 (0.12.18 available)
  material_color_utilities 0.11.1 (0.13.0 available)
  meta 1.17.0 (1.18.0 available)
  test_api 0.7.7 (0.7.9 available)
Got dependencies!
5 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
Process finished with exit code 0

Fontumuzu eklemis olduk...testpage4.dart a geliriz ve pubspec.yaml da ekledigmz font-famil yi artik kullanabilirz
 title:  Text("Pizza", style:TextStyle(color:fontColor1, fontWeight: FontWeight.bold, fontFamily: "Pacifico", fontSize: 22  )),
 Ve tekrar run tusuna basarak artik kullanilan font un Pizza yazsinda emulator uzerinden nasil yansidngini gorebilriz
 Bazen run tusuna bazsak da sonuc hemen gelmeyebilir boyle duurmldarda projeyi ustteki
  run iconunn yanindan ki kirmizi renkli dikdortgen tuusna basip durdurup bastan baslatmak da gerekebilir
*
* */
/*
* ROW-COLUMN-STACK-MAINAXISALIGNMENT --
* Scaffold bizim sayfamizin tum ekraninin temsil eder..appbar,body ve en alt kisim, web de footer..diye isimlendirilen kisimdir
* Scaffold sayesinde appbar imiz, sabit kalir, appbarimizin sabit olmasini istedigimz durumlarda Scaffold kullaniriz..
* Flutter in tasarimi yatay da ve dikey deki hizalamlarla calisiyor..bunlara hakim olmak gerekiyor..
* ROW:
* EGER NESNELERI YATAY DA YANYANA YERLESTIRMEK ISTERSEK O ZAMAN EN DISTA ROW TANIMLAMAMIZ GEREKIR
* EGERKI NESNELERI DIKEY DE ALT ALTA YERLESTIRMEK ISTERSEK O ZAMAN DA EN DISTA COLUMN ILE TANIMLAMAMIZ GEREKIR
* EGER KI NESNELER UST USTE GELMESINI ISTERSEK O ZAMAN DA STACK ILE KULLANMAMIZ GEREKIR...YANI BIRBIRINI OVERLAPP YAPACAK SEKILDE KULLANMAK

  body: Row(//Row la basliyorum, cunku demekki ben yanyana gelecek nesneler yerlestirecegim..
        // .ya da row yazip icine 1 kolon yazip onun icine brden fazlan nesne koyarak alt alta gelmesini de salayabiliriz
        //Row,Column,Stack nesneleri icerisinde birden fazla gorsel neseneyi gosterebilmek icin tasarlandigi icin,
        // children isimli proeprty i array olarak tutarki icerisine duruma gore birden fazla element,child yerlestirebilelim...
        children: [
          //Icerisinde gorsen nesne koyabilecegimi container nesnesi var onu kullanacgz burda..Container web deki div gibi,icerisne verdigmz nesnedin alanini kaplar
          Container(width: 100, height: 100, color:Colors.red),
          Container(width: 50, height: 50, color:Colors.blue),
          Container(width: 80, height: 80, color:Colors.green),
          //Simdi row un alani olarak bu 3 alan width olarak kullandigi alandan o satirda en sagda bos kalan yer de row un alanidir,
          // yenui container bu row icine eklenirse gidip, en son container dan sonra kalan kisma yerlesecektir
          //Ayni mantikta eger biz gidip Row yerine Column yazarsak o zamanda yanyana getirdigi nesneleri alt alta getirecektir
          // ayni kolonda asgi dogru kalan bosluga ise yeni bir container eklenirse onu yerlestirecektir
          //Container width-height olarak kac verilir ise o kadar kendisini buyutecektir, o boyutu alacaktir
          //Ama bu 3 container birbirinn uzerine gelsiin istersek o zaman da Stack icerisinde tanimlariz ana birlestirici kapsyaici o zaman Stack olur

        ],
     PEKI CONTAINER LARIMIZIN YATAY DA VEYA DIKEY DE HIALNMASINI NASIL YAPABLIRZ...
     * MAINAXISALIGNMENT
     * CROSSAXISALIGNMENT
     * MAINAXISSIZE

     SIMDI ORNEGIN ROW ICIN DUSUNURSEK
     * MAINAXISALIGNMENT-ANA EKSEN HIZALAMASI DEMEK..ANA EKSEN YATAY OLDUGU ICIN - YATAY DA HIZALAMA DEMEKTIR
     * ROW UN DEFAULT HIZALAMASI SOLA YATIK YANI SOLDAN SAGA DOGRU YERLESITYOR YA CONTAINER ISTE BIZ BU HIZALAMYI DEGISTIREIBLIRIZ
     COLUMN ICIN DUSUNECEK OLURSAK DA
     * MAINAXISALIGNMENT-ANA EKSEN HIZALAMASI DEMEK-ANA EKSEN DIKEY OLDUGU ICIN - DIKEY DE HIZALMA DEMEKTIR...
     *
     *
     *     body: Row(//Row la basliyorum, cunku demekki ben yanyana gelecek nesneler yerlestirecegim..
        // .ya da row yazip icine 1 kolon yazip onun icine brden fazlan nesne koyarak alt alta gelmesini de salayabiliriz
        mainAxisAlignment: MainAxisAlignment.center,//center deyince 3 kutuyu da o satirin ortasina yerlesecek sekilde yerlestirir
        //MainAxisAlignment.end dese idik o zaman da en sagdan sola yerlestirecekti
       MAINAXISALIGNMENT-START(DEFAULT)-START-END-CENTER-SPACEBETWEEN-SPACEEVENLY
       *
         body: Row(//Row la basliyorum, cunku demekki ben yanyana gelecek nesneler yerlestirecegim..
        // .ya da row yazip icine 1 kolon yazip onun icine brden fazlan nesne koyarak alt alta gelmesini de salayabiliriz
        //Row,Column,Stack nesneleri icerisinde birden fazla gorsel neseneyi gosterebilmek icin tasarlandigi icin,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,//center deyince 3 kutuyu da o satirin ortasina yerlesecek sekilde yerlestirir
        //MainAxisAlignment.end dese idik o zaman da en sagdan sola yerlestirecektir..start soldan baslar default oldugu gibi,
        // spaceBetween en saga ve en sola bir container yerlestirir ve var ise diger lerini ortaya yerlestirerek aralarinda max bosluk olacak skeilde ayarlar...
        //spaceEvenly ise en sag ve en solda da bosluk olacak skeilde tum containerlar araasi esit bosluk koyarak ayarlar
        *
      DIKKAT EDELIM...MAINAXISALIGNMENT ROW ICIN YATAYDA HIZALMA, COLUMN ICIN DIKEY DE HIZALAMAYAA YARDIMCI OLUYOR
      * PEKI SORUMUZ SU ROW ICIN BEN YATAY HIZALAMAYI MAINAXISALIGNMENT ILE AYARLADIM PEKI ROW ICIN DIKEY HIZALAMAYI NE ILE AYARLAYACAGIZ?
      * CEVAP: ISTE BU ISLERI ICIN CROSSAXISALIGNMENT KULLANACAGIZ
      * AYNI MANTIKTA COLUMN ICIN DIKEY DE HIZALAMA YI EVET MAINAXISALIGNMENT ILE YAPARIZ,
      * AMA COLUMN ICIN DIKEY DE HIZALAMA ZATEN MAINAXISALIGNEMNT ILE YAPILIYORDU, ANCAK YATAY HIZALAMA YI ISE CROSSAXISALIGNMENT ILE YAPARIZ

     CROSSAXISALIGNMENT - ROW -DIKEY DE HIZALAMA
     START=>YUKARI HIZALI
     END=>ASAGI HIZALI
     CENTER(DEFAULT=>DIKEY DE ORTALANMIS HIZALI
     STRETCH=>BU ISE KUTULARI HEM ASAGIYA HEM DE YUKARIYA TAM HIZALARLAR.. STRECTH YAPARAK GERIP UZATIP YAYARLAR
     *
     *  CROSSAXISALIGNMENT - COLUMN - YATAY DA HIZALAMA
     START=>SOLA HIZALI
     END=>SAGA HIZALI
     CENTER(DEFAULT=>YATAY DE ORTALANMIS HIZALI
     STRETCH=>BU ISE KUTULARI HEM SAGA HEM DE SOLA TAM HIZALARLAR.. STRECTH YAPARAK GERIP UZATIP YAYARLAR
     *
* */