import 'package:flutter/material.dart';
//simdi biz class ismini yazariz kendimiz...Homepage ismini vererek...Homepage buyuk olacak..
class Testpage3 extends StatefulWidget{
  const Testpage3({super.key});
  //StatefullWidget in son 2 harfi silip tekrar yazarsak oneriler getirir material dart i seceriz..
  // yuklariya material dart i import eder ve tum hatalar silinir
  @override
  State<Testpage3> createState() => _TestState3();
}
//Ustteki Homepage class yapisi alttaki _HomepageState yapisini temsil ediyor,
// ama biz Homepage ile ilgli tasarimlari _HomepageState deki build mehtodu icerisinde yapacagiz
//_State yazan yere de _HomepageState yazacagz

//Dikkat edelim _HomepageState zaten Homepage i aliyor State icinde..
// ve bu _HomePageState e Homepage ozelligini zaten aktariyor bu sekilde ve
// biz zaten burda _HomepageState icinde Homepage i aslinda degistirmis olacagiz..build icerisinde
class _TestState3 extends State<Testpage3> {
  @override
  Widget build(BuildContext context) {
  
    //Degisikliklerimiz i burda yapacagiz...
    //return const Placeholder();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Row → Column → Row Mantığı"),
      ),
      body: Column(
        children: [
          // 1. ROW → 3 COLUMN
          Row(
            children: [
              _buildColumn("A", Colors.red),
              _buildColumn("B", Colors.green),
              _buildColumn("C", Colors.blue),
            ],
          ),

          // 2. ROW → 2 COLUMN
          Row(
            children: [
              _buildColumn("D", Colors.orange),
              _buildColumn("E", Colors.purple),
            ],
          ),

          // 3. ROW → 1 COLUMN
          Row(
            children: [
              _buildColumn("F", Colors.teal),
            ],
          ),
        ],
      ),
    );
  }

    // tekrar eden yapıyı fonksiyon yaptık
    Widget _buildColumn(String label, Color color) {
      return Expanded(
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          color: color.withOpacity(0.2),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(label, style: const TextStyle(fontSize: 20)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.star),
                ],
              ),
            ],
          ),
        ),
      );
    }
}