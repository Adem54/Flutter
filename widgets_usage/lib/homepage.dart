import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}
//Bir textfield-input kullanacaksak o zaman o veriyi okuyabilmek icin bizim bir obje tanimlamamiz gerekiyor,
// var tfController = TextEditingController();
class _HomepageState extends State<Homepage> {
  var tfController = TextEditingController();
  //Artik tfController i arayuzde-ui da asagida kullanabiliriz..tfController araciligi ile
  // disardan girilen input-textField a girilen degeri baska bir degiskene aktararak arayuzde gosterebilirz
  String inputValue = "";


  String imageName = "good_mode.png";//default olarak bu gozuksun diye
  // ilk imageName i tanimladigmzda gozukmesini istedigmz image ismini veririz, ana proje altindaki images klasoru altinda
  String imageSrc  = "baklava.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text("Homepage-Widgets")),
      body:Center(
        child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Text(inputValue),
              //TextField her tarafi kapladigi icin kenarlarindan bosluk vermek icin
              // TextField i secip alt-enter yaptik ve padding ile kenarlra bosluk vermeyi sagladik
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller:tfController,
                  decoration: InputDecoration(hintText: "Enter your number!"),
                  keyboardType: TextInputType.number,
                  //ne tur bir klavye acilsin, yani girecegin data type ina gore klavye gelmesi saglanabilir
                 // obscureText: true,//bu da eger password gireceksek girilen letter lari gizleyebiliriz
                ),
              ),
              //ElevedatedButton cevresinde borderi vs olan bir buton ama
              // TextButton cevresinde butonu olmayan daha boyle duz yazi gibi bir button
              ElevatedButton(onPressed: () {
                setState(() {
                  inputValue = tfController.text;
                });
              }, child: const Text("Get the data!")),
              TextButton(onPressed: (){
                setState(() {
                  inputValue = tfController.text;
                });
              }, child:const Text("TextButton",style: TextStyle(color:Colors.orange)),  ),
              //Bu butonlari yanyana koymak istedgimzden dolayi row olusturup onun icerisne yerlestirecegiz
              //Bu sekiilde de show good mode butonuna basinca good_mode.png yi,
              // show bad mode butonuna tiklayinca da bad_mode.png yi gosterecektir
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () {
                    setState(() {
                      imageName = "good_mode.png";
                    });
                  }, child: const Text("Show good mode!")),
                    Image.asset("images/${imageName}"),
                  ElevatedButton(onPressed: () {
                    setState(() {
                      imageName = "bad_mode.png";
                    });
                  }, child: const Text("Show bad mode!")),
                ],
              ),
              //ASAGIDA DA, BIR UZAK REPODAN , URLDEN, VEYA SERVERDAN BIR RESMI NASIL GOSTEREBILIRZ...SRC SINI VEREREK
              ElevatedButton(onPressed: () {
                setState(() {
                  imageSrc = "kofte.png";
                });
              }, child: const Text("Show-Kofte-Image!")),
              ElevatedButton(onPressed: () {
                setState(() {
                  imageSrc = "ayran.png";
                });
              }, child: const Text("Show-Ayran-Image!")),
              SizedBox(//Image i secip alt-enter yaparak wrap sizedBox ekleriz dis cercevesine cunku image cok yer kaplayacakti bizde
                //buna widht-heigh vererek istedigmz gibi yerlestirmemiz gerekti
                  width: 48,
                  height: 48,
                  child: Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${imageSrc}")),

              //iste bu controller a tfController i atadgimz dan doolayi
              // girilen verileri artik okuyaiblir hale geliriz
          ]
        )
      )
    );
  }
}
