import 'package:fluter_work_structure/homepage.dart';
import 'package:flutter/material.dart';

//Her zman kigibi st yazip stfulll u seceriz, ve ResultScreen yazariz
//Sonra da StatefulWidget in son 2 harfini sileriz, ve sonra o harfleri tekrar yazarken
// import secenkleri gelir ve orda material.dart ile biteni seceriz
class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: const Text("Result screen!")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: (){
              //Bir onceki sayfaya donnmek icin ise Navigator.pop kulanilir, pop bir onceki sayfaya donmek icin kullanilir,
              // push bir sonraki sayaya gitimek icindi
              //Dikkat edelim, mobile ekraninda, simulatordeki en ust solda <- sola dogru arrrow simgesi kendisi geliyor zaten
              // ve kendi defaultunda hazir olarak geliyor, mobile uygulamalarin
              // Android ve iOS’ta AppBar’daki geri butonu Flutter çizer;
              // sadece görünüm ve davranış platforma göre uyarlanır.
              //Flutter geri butonunu ne zaman koyar?
              //Şu şartlar sağlanıyorsa:
              // Sayfa Navigator stack’inde ilk sayfa değilse
              // AppBar(automaticallyImplyLeading: true) (default)
              // iste bunu yaptigi islevin aynisini biz kendimz buton ile yapyoruz come-back butonu
              Navigator.pop(context);
              //Artik result_screen den geri don islemi, game_screen e degil direk homepage e olacak ,
              // cunku game_screen sayfasindan bu safyaya navigtor.pushReplacement ile
              // geldigi icin kendini(game_screen) backstack den silmis oldu..ve backstack de homepage ve result_screen kalmis oldu
            }, child: const Text("Come back!!")),
            ElevatedButton(onPressed: (){
              //State ozelligi
              /*setState(() {//Bu calisarak degisken state i dirty olarak isaretler ve flutter da bunun uzerinde
                // setState in calistigni gorunce gidip widget tan build i tetikleyerek yeni bir instance olusturur
              }); */
              Navigator.of(context).popUntil((route)=>route.isFirst);//Homepage e kadar geriye git demis oluyrouz
            //popUntil içindeki (route) => route.isFirst kısmı predicate dir
              //Predicate ne demek?
              // Predicate = bir şeye “doğru mu / yanlış mı?” diye bakan fonksiyon.
              // Yani dönüş tipi bool olan bir test fonksiyonu.
              //Flutter da bu sekildedir predicate bool Function(T item)
              //bu ornekteki bool Function(Route<dynamic> route)
              //popUntil ne yapıyor burda? Navigator.of(context).popUntil((route) => route.isFirst);
              //Navigator stack’inde en üstten başlayarak pop() yap, ta ki predicate true dönene kadar dur
              //Burada predicate:(route) => route.isFirst
              //demek “Bu route stack’in en altındaki (ilk) route mu?”
              //isFirst true olunca durur. Yani Homepage (ilk sayfa) kalır, üstündeki tüm sayfalar kapanır.
              //Kısa örnekle=>Stack şöyleyse:[Homepage] -> [Page2] -> [Page3] -> [Page4]
              //Page4’ten çalıştırınca:
              // Page4 pop
              // Page3 pop
              // Page2 pop
              //Homepage’e gelince route.isFirst == true → DUR
              //Predicate başka neye benzer?Listelerdeki where, any, firstWhere gibi şeylerde de aynı mantık var:
            }, child: const Text("Come back to homepage!")),
          ],
        ),
      ),
    );
  }
}
