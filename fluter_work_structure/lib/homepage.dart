//bu structure u olusturmak icin st yazdik ve ordan statesfull u sectik...ki state ozellgini kullnabilmek icin...COOK ONEMLI BURASI...
//Eger state ozelligi olmayan bir sayfa istiyorsak o zaman stateless i kullaniriz..
import 'package:fluter_work_structure/game_screen.dart';
import 'package:fluter_work_structure/persons.dart';
import 'package:flutter/material.dart';

//Simdi suraya dikkat StatefulWidget alti cizili geliyor hata veriyor son 2 harfi silip tekrar yazarsak
// hangi kutuphaneden import edildigni seceneklerini getiryor ordan da material dart i secersek o zaman,
// otomatik olarka importu yukari getirir ve tum hatalar ortadan kalkacaktir
//Bu arada burda Homepage in H buyuk olmasi gerekiyor
class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}
class _HomepageState extends State<Homepage> {
  int count = 0;
  bool checkVariable = false;
  //init state ekleyebiliyoruz..._HomepageState icerisine..bu createState ...sonucunda..
  //init yazinca zaten geridi kendiliginden geliyor..
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState in homepage");
  }

  //asenkron bir islemi simule edecek olursak
  //Simdi burda basit bir toplama islemi yaptirip bunun sonucunu ara yuzde gostermeye calisacagiz
  //Burda veritabanindan api den veriyi alip da ara yuze veriyi aktarma mantigini Future builder dedigmz bir yapi ile gerceklestirecegiz
  //Asenkron islem oldugu icin Future<> ile olusturmamz gerekir fonksiyonu... ve async kulanmamiz gerekir suslu parantezden once
  //Simdi dikkkat burda return ile adigmiz datayi arayuzde kullanacagiz..
  Future<int> sumNumbers (int num1, int num2) async {
    int sum = num1 + num2;
    return  sum;
  }
  @override
  Widget build(BuildContext context) {
    print("build is running in homepage!!!!");
    //Scaffold bir iskeletttir...appBar ile en ustteki bar kisminin yani header
    // kismini sabit kalmasin ve onn altina da body gelmesin saglariz..

    return Scaffold(
      appBar: AppBar(
          title: const Text("Homepage")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Count: ${count}"),
              ElevatedButton(onPressed: (){
                //State ozelligi
                setState(() {
                  print("state-count: ${count}");
                  count = count +1;
                });
              }, child: const Text("Increase!")),
              ElevatedButton(onPressed: (){
                //Bu butona tiklayinca bizi GameScreen sayfasina yonlendirecek
                //Simmdi navige ettigmz ekran..Statefull ise parametre uzerinden data gonderiuyouz,
                // boyle durumlarda artik GameScreen basinda const kullanamayiz bu hata verecektir, cunku disardan deger aliyor,sabit degil
               // Navigator.push(context, MaterialPageRoute(builder: (context)=>const GameScreen("Adem",38,1.68,true)));
             //   Navigator.push(context, MaterialPageRoute(builder: (context)=> GameScreen(name:"Adem",age:38,height:1.68,isMarried:true)));
                var person = Persons(name:"Adem",age:38,height:1.68,isMarried:true);
              //  Navigator.push(context, MaterialPageRoute(builder: (context)=> GameScreen(person: person)));
                Navigator.push(context, MaterialPageRoute(builder: (context)=> GameScreen(person: person)))
                    .then((value){
                      //Burda istedigmz islemi yapaiblirz
                  print("it is being came to homepage!!!!");
                });//DIKKAT EDELIM...BIZ BU NAVIGATOR ILE GECIS YAPMISTIK....VE YINE AYNI NAVIGATOR ILE GERIDONUSU ALABLIROUZ GERI DONUS GERCEKLESTIGINDE BU PRINT CALISACAKTIR
                //Simdi buraya dikkat edelim, GameScreen person bekliyor ama silip bastan yazmamiz gerekiyor
                // ...bu onemli yoksa hata varmis gibi gostrerebiliyor
               //context parametrede flutter in vermis oldugu contextdir ve bu sayfda oldugumuz belirtir
               //const yaptik icerisine bir deger gondermiyoruz, sabit oldugu icin
              }, child: const Text("Start!!")),
              //Burda 3 tane text ve 2 tane status butonu olustururuz, Start butonu altinda
              Visibility(visible: checkVariable , child: const Text("Hello")),
              //Text i seceriz ve Alt entre ile wrap widget deriz cunku direk eklemek istedgimz visibility yok..bizde widget yerine visibility icine aliriz Text i
              //Ve Visiblity icerisinde visible key i var oraya value olarak checkVariable kulaniriz ve checkVariable true olursa o Text visible olur,false olursa unvisble olur
            //Asagidaki Status-1 e tiklarsak bu Text gorunur olur checkVariable orda true oldugu icin, Status-2 ye tiklayp checkVariable i false yapinca da
              // Text tekrar not visible yani gorunmez olacaktir
              Text(checkVariable ? "Hello-TRUE" : "HA-DET-FALSE", style:TextStyle(color:checkVariable ? Colors.blue : Colors.red)),//true ise blue,false ise red
              Text("Hello"),
              ((){
                //Burda artik dart kodlamasini yapabilirz..
                //Ve checkVariable imiza gore biz farkli widget lari gosterebiliriz, ayni widget i farkli tekstlerle de gosterebliriz...
                //Dikkat direk olarak Text widget i icerisinde ternary ile yapbildigmz islemi bu sekilde tamamen ayri da yapailiyoruz...
                if(checkVariable)
                  {
                    return const Text("Hallooo!!", style:TextStyle(color:Colors.blue));
                  }else{
                  return const Text("Ha det godt da!!",style:TextStyle(color:Colors.red));
                }
              }()),
              ElevatedButton(onPressed: (){
                //State ozelligi
                setState(() {
                    checkVariable =  true;
                });
              }, child: const Text("Status-1-True!")),
              ElevatedButton(onPressed: (){
                //State ozelligi
                setState(() {
                    checkVariable = false;
                });
              }, child: const Text("Status-2-False!!")),

              //Asenkron olarak ekran acildiginda api den gelen bir degeri alip da arayuzde, herhangi bir text veya bakska tur bir wiget
              // icinde gelen datayi kullanacak isek onu FutureBuilder kullanarak yapariz
              FutureBuilder<int>(
                  future: sumNumbers(10, 20),
                  builder:(context, snapshot){
                    if(snapshot.hasError)//hasError,hasData
                      {
                        return const Text("Error is occured!!");
                      }
                    if(snapshot.hasData)
                      {
                        return  Text("Result ${snapshot.data}");//const kullaniyrsak kaldirmalyiz
                        // eger disardan bir degisken den deger kullanacaksak Text icerisinde
                      }else{
                      //Sonucunda data yok ise No result yazacak
                      return const Text("No result");
                    }
                  } )//sumNmbers sonucunu builder key ine yazacagizm value kisminda kontrol edecegiz
              //builder paramtreye 2 deger verir 1 context..bu flutter n verdigi ve flutter da oldugmzu ispat eden bir yapi
              //2.snapshat..bize sonuc veren yapi, bunun sayesinde bilgi alinir..hata var mi bunu ogrenebilirz
              //FutureBuilder yapsinin listeleme islemlernde ,
              // databsae den veya direk apiden bir liste fetch edip ui-userinterface de veya
              // widgetlarimz icerisnde o listeyi gosterecegimz zaman cok kullaniriz

            ],
        ),
      ),
    );
  }
}
