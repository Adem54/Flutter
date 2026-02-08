
import 'package:flutter/material.dart';
//ne yaptik dikkat once st yazdik statesfull u sectik ve class ismi olarak PageOne verdik..ve sonra alti cizili hatalari cozmek icin ise
//StatefulWidget in son 2-3 harfi silip tekrar yazarsak import tavsiyesi onumuze gelir ve
// ona tiklarsak import gelir otomatik ve hatalarin hepsi gider
class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  @override
  Widget build(BuildContext context) {

    return const Center(
      child: const Text("PageOne", style: TextStyle(fontSize: 30, color: Colors.black54 ),),
    );
  }
}
