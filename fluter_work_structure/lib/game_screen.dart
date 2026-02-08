import 'package:fluter_work_structure/persons.dart';
import 'package:fluter_work_structure/result_screen.dart';
import 'package:flutter/material.dart';
//Her zman kigibi st yazip stfulll u seceriz, ve GameScreen yazariz
//Sonra da StatefulWidget in son 2 harfini sileriz, ve sonra o harfleri tekrar yazarken
// import secenkleri gelir ve orda material.dart ile biteni seceriz

//Statefull olan screen ler icin sayfalar arasi data gecisini, StatefulWidget in extends edildigi yerde yapaagiz
//Buraya bu sayfaya gonderilmesini istedgimz degiskenleri yazacagiz, yani gonderilmesini bekldgimz degiskenleri yazariz
class GameScreen extends StatefulWidget {
  /*String name;
  int age;
  double height;
  bool isMarried; */
  Persons person;

  GameScreen({required this.person}); //constructor eklemelyiz,saga tik generate constructor yapariz
//Sonra da suslu parantez icine alarak hepsinin bassina required ekleriz...bu sekilde kullanilirken key ler ile birlikte kullanilmis olur
  //GameScreen({required person.name, required this.age, required this.height, required this.isMarried});

  //Bu degiskenler GameScreen class i icerisinde, ve GameScreen class i da _GameScreenState tarafindan extends ediliyor,
  // yani alt-siinif yani subclass, GameScreen _GameScreenState in parent-classi veya baseclass, i , _GameScreenState ise GameScreen in subclass idir
  //Biz bir ust siniftaki bu sekilde degerlere, degiskenlere..name,age,height,isMarried gibi,  alt siniftan Widget keywordu ile erisebilecegiz
  //widget dedigmiz de bir ust class in instancesini veriyor aslinda...
  // yani _GameScreenState icinde Text("${widget.name}") dersen bu GameScreen icine gelen name e erismis olur

  //Bunu yoruuma aliyoruz yukardaki isleleri yapinca
  // const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  Future<bool> comeBackKey(BuildContext context) async {
    print("Navigation-back-key-is-chosen");
    return false;//geri donme islemi calismasin..true olursa calissin, yani geri donsebilsin..demis olurz
  }//Bu fonks Center in en disina ekliyorum...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Game screen!!"),
        //back iconumuz..default olarakappBar icinde kendisi geliyordu hatirlayalim...
        //leading = AppBar’ın başlangıç tarafındaki widget
        // actions = bitiş tarafındaki widget’lar
        //leading = her zaman “başlangıç tarafı”
        // trailing/actions = “bitiş tarafı”
        leading: IconButton(onPressed: () {
          print("Appbar-back-key-is-chosen");
          Navigator.pop(context);//Simdi biz istersek de back-tusunu kendimiz bu sekilde default olarak geldigi gibi calismaini saglayabiriz
          // ama bu satiri yazmaszak, sadece prtinti yazdidir ekrana ama geri gitmez,
          // cunku biz default olarak gelen ozelligin uzerine yazmis oluyroz...
        }, icon: Icon(Icons.arrow_back_ios_new)), //leading sol demek

      ),

      //Center i secip alt-enter yapariz ve wrap widget secip sonra WillPopScope yapariz..cunku WillPopScope orda gelmiyor
    //  body: WillPopScope(
        body: PopScope(
          canPop:false,
       onPopInvokedWithResult: (didPop, result){
            print("Navigation back-key is being choosen!");
            debugPrint("Back pressed. didPop=$didPop result=$result");
       },
       // onWillPop: ()=>comeBackKey(context),//bunu 1 tane onWillPop eventi var...paramettreye context aliyor...
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            //  Text("${widget.name} - ${widget.age} - ${widget.height} - ${widget.height}"),
              Text("${widget.person.name} - ${widget.person.age} - ${widget.person.height} - ${widget.person.height}"),
              ElevatedButton(onPressed: (){
                //State ozelligi
                //Bu butona tiklayinca bizi ResultScreen sayfasina yonlendirecek
                //game_screen.dart ta, da ResultScreen e yonlendirirken push ile degil de, Navigator.pushReplacement ile yonlendirirsek o
                // zman GameScreen ekrani kendisini backstack ten silerek ResultScreen ekranin a yonlendirmis olacak
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const ResultScreen()));
                //context parametrede flutter in vermis oldugu contextdir ve bu sayfda oldugumuz belirtir
                //const yaptik icerisine bir deger gondermiyoruz, sabit oldugu icin

              }, child: const Text("Finish!")),
              ElevatedButton(onPressed: (){
                //Bir onceki sayfaya odnmek icin ise Navigator.pop kulanilir, pop bir onceki sayfaya donmek icin kullanilir,
                // push bir sonraki sayaya gitimek icindi
                Navigator.pop(context);
              }, child: const Text("Come back!!")),
            ],
          ),
        ),
      ),
    );
  }
}
