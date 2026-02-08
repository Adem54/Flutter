import 'package:flutter/material.dart';
//simdi biz class ismini yazariz kendimiz...Homepage ismini vererek...Homepage buyuk olacak..
class Testpage extends StatefulWidget{
  const Testpage({super.key});
  //StatefullWidget in son 2 harfi silip tekrar yazarsak oneriler getirir material dart i seceriz..
  // yuklariya material dart i import eder ve tum hatalar silinir
  @override
  State<Testpage> createState() => _TestState();
}
//Ustteki Homepage class yapisi alttaki _HomepageState yapisini temsil ediyor,
// ama biz Homepage ile ilgli tasarimlari _HomepageState deki build mehtodu icerisinde yapacagiz
//_State yazan yere de _HomepageState yazacagz

//Dikkat edelim _HomepageState zaten Homepage i aliyor State icinde..
// ve bu _HomePageState e Homepage ozelligini zaten aktariyor bu sekilde ve
// biz zaten burda _HomepageState icinde Homepage i aslinda degistirmis olacagiz..build icerisinde
class _TestState extends State<Testpage> {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("1", style: TextStyle(fontSize: 30)),
                SizedBox(width: 16),
                Text("2", style: TextStyle(fontSize: 30)),
                SizedBox(width: 16),
                Text("3", style: TextStyle(fontSize: 30)),
              ],
            ),

            const SizedBox(height: 20),

            // 2. SATIR → 4 5
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("4", style: TextStyle(fontSize: 30)),
                SizedBox(width: 16),
                Text("5", style: TextStyle(fontSize: 30)),
              ],
            ),

            const SizedBox(height: 20),

            // 3. SATIR → 6
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("6", style: TextStyle(fontSize: 30)),
              ],
            ),
          ],
        ),
      ),
    );

  }
}