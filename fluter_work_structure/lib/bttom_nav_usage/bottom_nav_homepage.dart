import 'package:fluter_work_structure/bttom_nav_usage/page_one.dart';
import 'package:fluter_work_structure/bttom_nav_usage/page_three.dart';
import 'package:fluter_work_structure/bttom_nav_usage/page_two.dart';
import 'package:flutter/material.dart';

class BottomNavHomepage extends StatefulWidget {
  const BottomNavHomepage({super.key});

  @override
  State<BottomNavHomepage> createState() => _BottomNavHomepageState();
}

class _BottomNavHomepageState extends State<BottomNavHomepage> {
  int choosenIndex = 0;//default olarak 0 dir yani default olarak ana sayfamiz PageOne olacaktir
  //pageOne-0.index, pageTwo-1.index, pageThree-2.index
  var myPages = [ const PageOne(), const PageTwo(), const PageThree()];
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar( title: const Text("BottomNavHomepage!"), backgroundColor: Colors.deepPurple,),
      //body icerisinde istersek direkt olarak sayfalarimiz i da gorebiliriz ornegin
      //Biz ne yaptik bottom_nav_homepage icerisnde bodysinde direk olarn pageOne i goruntuledik!!!
      // body: const PageOne(),
      body: myPages[choosenIndex],
      //Artik body altinda bottomNavigationBar yapisini kullanabilirz..yani footer ddaki tab yapisi...
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.looks_one), label:"One!"),
        BottomNavigationBarItem(icon: Icon(Icons.looks_two), label:"Two!"),
        BottomNavigationBarItem(icon: Icon(Icons.looks_3), label:"Three!"),
      ],
        currentIndex: choosenIndex,//Simidi bu icon uzerinde secildigi style i vermesini sagliyor buyani burda
        //currentIndex 0 olursa burdaki label i "One!" olan iconun backgroundu secili olarak style alarak gelir,
        //currentIndex 1 olursa label i "Two!" olan in iconun  arka plani vs secilmis bir clor rengi ile gelir,
        //currentIndex 2 olursa da label i "Three"olan in iconun arka plnai secilims color rengi ile gelir
          //onTap ozelligi var tiklanan indexi veriyor burda
          backgroundColor: Colors.deepPurple,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.white38,
        onTap:(index){
        print("Tapped index: ${index}");
        setState(() {
           choosenIndex = index;
           //Burda biz choosenIndex e index i atadigmz zaman ne yapiyor setState invoke edildigi icin,
          // sayfayi yeniden build ediyor
           //Evet bunu yaptimgzda artik..1 e basarsak 1.sayfa, 2 ye basarsak 2 .sayfa 3 e basarsak 3.sayfa gelecektir
        });
        }
      //BottomNavigationBar’ın kendi içinde “underline” özelliği yok.
      // Ama çok küçük bir dokunuşla alt bar’ın üstüne ince bir çizgi satırı koyup,
      // seçili index’e göre hareket ettirebiliriz.
      ) ,
    );
  }
}
