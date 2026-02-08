import 'package:flutter/material.dart';
//simdi biz class ismini yazariz kendimiz...Homepage ismini vererek...Homepage buyuk olacak..
class Testpage5 extends StatefulWidget{
  const Testpage5({super.key});
  //StatefullWidget in son 2 harfi silip tekrar yazarsak oneriler getirir material dart i seceriz..
  // yuklariya material dart i import eder ve tum hatalar silinir
  @override
  State<Testpage5> createState() => _TestState5();
}
//Ustteki Homepage class yapisi alttaki _HomepageState yapisini temsil ediyor,
// ama biz Homepage ile ilgli tasarimlari _HomepageState deki build mehtodu icerisinde yapacagiz
//_State yazan yere de _HomepageState yazacagz

//Dikkat edelim _HomepageState zaten Homepage i aliyor State icinde..
// ve bu _HomePageState e Homepage ozelligini zaten aktariyor bu sekilde ve
// biz zaten burda _HomepageState icinde Homepage i aslinda degistirmis olacagiz..build icerisinde
class _TestState5 extends State<Testpage5> {
  @override
  Widget build(BuildContext context) {
    //Degisikliklerimiz i burda yapacagiz...
    //return const Placeholder();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Pizzaa",
          style: TextStyle(fontSize: 40),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. SATIR → 1 2 3
            coloredRow(
              bg: Colors.red,
              size: MainAxisSize.max, // <-- burada min/max değiştir..min olunca icerik kadar yerkaplarken,
              // max olunca ki defaultta max dir...o zaman da tum satiri kaplar
              children: const [
                Text("1", style: TextStyle(fontSize: 30)),
                SizedBox(width: 16),
                Text("2", style: TextStyle(fontSize: 30)),
                SizedBox(width: 16),
                Text("3", style: TextStyle(fontSize: 30)),
              ],
            ),

            coloredRow(
              bg: Colors.green,
              size: MainAxisSize.min,
              children: const [
                Text("4", style: TextStyle(fontSize: 30)),
                SizedBox(width: 16),
                Text("5", style: TextStyle(fontSize: 30)),
              ],
            ),

            coloredRow(
              bg: Colors.blue,
              size: MainAxisSize.min,
              children: const [
                Text("6", style: TextStyle(fontSize: 30)),
              ],
            ),
            // 2. SATIR → 4 5

          ],
        ),
      ),
    );

  }
}


//BACKGROUND...YANI ASLINDA CONTAINER, RENGI PARAMETREDE VERILEN RENGIN OPACITY SI 0.2 OLAN HALIDIR..YANI COK DAHA ACIK HALI..
//Dıştaki açık renk (0.2) = satırın tamamı (ekran genişliği)
//İçteki daha koyu renk (0.6) = Row’un gerçekten kapladığı alan
//Şimdi MainAxisSize.min yapınca:
// Koyu alan sadece içerik kadar olur.
Widget coloredRow({
  required Color bg,
  required MainAxisSize size,
  required List<Widget> children,
}) {
  return Container(
    width: double.infinity, // referans: tüm satırı göster
    padding: const EdgeInsets.symmetric(vertical: 8),
    color: bg.withOpacity(0.2), // satırın "tam alanı"
    child: Align(
      alignment: Alignment.center,
      child: Container(
        color: bg.withOpacity(0.6), // Row'un kapladığı alanı net gör..BU DA ROWUNKAPLADIGI ALAN RENGI ANA PARMTREDEKI
        // BACKGROUND(BG) RENGININ OPACITY 0.6 ILE CARIPILMIS HALIDIR
        child: Row(
          mainAxisSize: size, // <-- min / max farkı burada
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    ),
  );
}