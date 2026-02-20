import 'package:block_pattern_usage/ui/cubit/homepage_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var textFeildNum1 = TextEditingController();
  var textFeildNum2 = TextEditingController();
  //int result = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text("Bloc pattern", style:TextStyle(color:Colors.white)),backgroundColor: Colors.blue,),
      body:Center(
        child:Padding(
          padding: const EdgeInsets.only(right: 50,left: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //BlocBuilder HomepageCubit i burda dinliyor emit ile tetiklenen fonks ve gonderilen data burda dinlenerek aliniyor
              //HomepageCubit icindeki emit her tetiklendiginde, veya calistiginda burasi ordan gonderilen burda dinliyor ve aliyor gonderilen datayi
              //Ilk olarak sayfa geldiginde BlocBuilder de okunuyor HomepageCubit e gider ve onu constructori claisir ve
              // orda defaultolarak atanan degeri okur ve onu result a atama yapar...
              //Bizdde verimizi Text icine almamiz gerektigi icin bu Text e secip alt-enter yaparak BlockBuilder<HomepageCubit,int> ile sarmaladik!!
              BlocBuilder<HomepageCubit,int>(//<HomepageCubit,int> hangi cubit dinlenecek ve return edecegi veri turu...
               builder:(context, result){
                 print("emmitted-result!!: ${result}");
                 return Text(result.toString(), style:TextStyle(fontSize: 40));
               }
              ),
              //Simdi soyle bir harika bestpractise var burda..HomepageCubit icindeki sum, multiple methodlarindan
              // her hangi birsi bu sayfada butonlara tiklaninca bu methodlari tetikliyorlar,
              // flutter_bloc kutuphanesi sayesinde ve orda emit ile result u buraya gonderiyor ve
              // bizde bunu result u nerde kullanacaksak orda dinliyoruz...ok, aynen bu ornekteki gibi, burda suna dikka ,
              // hic setState kullanmadik ama sayfamniz hic setState kullanmadan yani build yapmadan guncellendi...
              // ISTE BU HARIKA BIR OZELLIK BU BIZE SU IMKANI SUNUYOR SAYFAYI DINAMIK SEKKILDE KULLANABILIRKEN
              // BU SAYFAYI STATELESSS OLARAK DA OLUSTURABILIRDIK...DIKKAT EDELIM SETSTATE KULLANMADAN
              // CUBIT YAPISI SAYESINDE SAYFAMIZI GUNCELLENMESINI SAGLADIK DINAMIK BIR DEGISIKLIK OLDUGUNDA

              // Text(result.toString(), style:TextStyle(fontSize: 24)),
              //Simdi bak biz burda SizedBox icine alarak cozmek bir secenek alternatif olarak da en bastaki
              // Column a padding verirsek sag ve sol tarafinda o zamanda ayni mantkta istedgimzi elde etmis oluyoruz
              //Textfieldlar tum alani yatayda kapliyor bunu engellemek icin SizedBox icerisne alarak widthini sinirlanidiyoruz...
             /* SizedBox(
                width: 240,
                child: TextField(
                  controller: textFeildNum1,decoration: const InputDecoration(hintText: "number1"),

                  onTap: (){

                  },
                ),
              ),
              SizedBox(
                width: 240,
                child: TextField(
                  controller: textFeildNum2,
                    decoration: const InputDecoration(hintText: "number2"),
                  onTap: (){

                  },
                ),
              ), */
              TextField(
                controller: textFeildNum1,decoration: const InputDecoration(hintText: "number1"),

                onTap: (){

                },
              ),
              TextField(
                controller: textFeildNum2,
                decoration: const InputDecoration(hintText: "number2"),
                onTap: (){

                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style:ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      onPressed: (){
                      /*  print("textFeildNum1: ${textFeildNum1.text}");
                        print("textFeildNum2: ${textFeildNum2.text}");
                        int input1 = int.parse(textFeildNum1.text) ?? 0;
                        int input2 = int.parse(textFeildNum2.text) ?? 0;

                        setState(() {
                          result = input1 + input2;
                          textFeildNum1.text = "";
                          textFeildNum2.text = "";
                        }); */
                        //Iste Cubit teki methodumzu da burda butona tiklayinca tetikleriz...
                        context.read<HomepageCubit>().sum(textFeildNum1.text, textFeildNum2.text);
                        //read blockpattern yapisindan gelecektir eger gelmiyorsa yukarda blocpattern
                        // import u kontorl etmemiz gerekir..flutter_bloc
                      }, child: const Text("Sum", style:TextStyle(color:Colors.white))),
                  ElevatedButton(
                      style:ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      onPressed: (){
                    /*    print("textFeildNum1: ${textFeildNum1.text}");
                        print("textFeildNum2: ${textFeildNum2.text}");
                        int input1 = int.parse(textFeildNum1.text) ?? 0;
                        int input2 = int.parse(textFeildNum2.text) ?? 0;

                        setState(() {
                          result = input1 * input2;
                          textFeildNum1.text = "";
                          textFeildNum2.text = "";
                        }); */

                        //Iste Cubit teki methodumzu da burda butona tiklayinca tetikleriz...
                        context.read<HomepageCubit>().multiple(textFeildNum1.text, textFeildNum2.text);//read blockpattern yapisindan gelecektir
                      }, child: const Text("Multiply", style:TextStyle(color:Colors.white))),
                ],
              )
            ],
          ),
        )
      )
    );
  }
}
/*
***************COOOK ONEMLI- flutter_bloc kutuphanesini pubspec.yaml da eklemeliyiz Cubit i kullanabilmek icin *********
Cubit ile calismak icin Bloc kutuphanesini kurmamiz gerekiyor
pubspec.yaml a gideriz ve flutter_bloc: u flutter ile ayni hizaya yaszariz ve karsina
 flutter_bloc: birsey yazmasak boyle birakirsak en guncel surumu getirri veya istedigmz bir surum var ise onu karsina yazari
# the latest version available on pub.dev. To see which dependencies have newer
# versions available, run `flutter pub outdated`.
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc:

ekledikten sonra pub get e basarak yuklenemsini saglariz..
Her sayfaya ait bir cubit olacak!!
* *
*
* */
