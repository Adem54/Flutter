import 'package:flutter/material.dart';

class UserInteractionPage extends StatefulWidget {
  const UserInteractionPage({super.key});

  @override
  State<UserInteractionPage> createState() => _UserInteractionPageState();
}

class _UserInteractionPageState extends State<UserInteractionPage> {
  var tfControl = TextEditingController();//TextEditingController sinifindan geliyor ve bu bize herhangi bir yerden veri okuyaiblmemizi saglar
  //Tabi ki bu tfControl u TextField imize baglayacagiz asagida
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text("UserInteraction")),
      body:Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,//mainAxis i dikey old icimndikey de ortala
          crossAxisAlignment: CrossAxisAlignment.center,//dikey old icin Column icinde, crossAxis i yatay da demek yatay da center yap
          children: [
            ElevatedButton(
                onPressed: (){
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(//action vremeden kullanirsak en alttan yukari dogru bir snackbar arka-black mesaji gosterir biraz durur ve kaybolur
                      //Ama action kulanirsak aciton ayazdigmz buton text ine tiklamamiz beklenir ve o action icindeki fonsk icinde de yapmak istedgimz
                      //eylemi gerceklestiririz...
                        content: const Text("Do you want to delete?"),
                        action : SnackBarAction(label: "Yes", onPressed: (){
                          print("The yes button is clicked");
                          //Yes e basinca Deleted diye bir mesaj gozukecek en alttan uste dogru belli bir sure kalip sonra kendiliginden kaybolacak
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: const Text("Deleted!"),)
                          );
                        })
                    ) //
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor:Colors.white),
                child:const Text("SnackBar(Default)")
            ),
            ElevatedButton(
                onPressed: ()
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(//action vremeden kullanirsak en alttan yukari dogru bir snackbar arka-black mesaji gosterir biraz durur ve kaybolur
                        //Ama action kulanirsak aciton ayazdigmz buton text ine tiklamamiz beklenir ve o action icindeki fonsk icinde de yapmak istedgimz
                        //eylemi gerceklestiririz...
                          content: const Text("Do you want to delete?", style:TextStyle(color:Colors.indigo)),
                          backgroundColor: Colors.cyan,
                          action : SnackBarAction(label: "Yes",textColor: Colors.red, onPressed: (){
                            print("The yes button is clicked");
                            //Yes e basinca Deleted diye bir mesaj gozukecek en alttan uste dogru belli bir sure kalip sonra kendiliginden kaybolacak
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: const Text("Deleted!", style:TextStyle(color:Colors.white)),backgroundColor: Colors.orange)
                            );
                          })
                      ) //
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor:Colors.white),
                child:const Text("SnackBar(Custom)")
            ),
            //SnackBar sayfanin en altinda yukari dogru cikarak gelen popup ve kullanici yonlendirme mesajlari, deleted, do you want to delete..vs gibi
            //Alert ise sayfanin en ust tarafindan gelen bir kullanici etkilesim popup yapilaridir
            ElevatedButton(
                onPressed: (){
                  showDialog(
                      context: context ,
                      builder: (BuildContext context){
                        return AlertDialog(
                          title:const Text("Title"),
                          content: const Text("Content of the Alert"),
                          actions:[
                            TextButton(onPressed: (){
                                print("Cancel is clicked!");
                                Navigator.pop(context);//AlertDialog butonunu kapatiyor yani bir
                              // oncekine aliyor aslinda ..gibi..geri tusuna basinca ne oluyorsa onu yapyor ve alert-popupu kapanmis oluyr
                            }, child:const Text("Cancel"),),
                            TextButton(onPressed: (){
                              print("Ok is clicked!");
                              Navigator.pop(context);
                            }, child:const Text("Ok"),)
                          ]
                        );
                      });//Alert dialog
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor:Colors.white),
                child:const Text("Alert(Default)")
            ),
            ElevatedButton(
                onPressed: (){
                  showDialog(
                      context: context ,
                      builder: (BuildContext context){
                        return AlertDialog(
                            title:const Text("Register"),
                            content:  TextField(controller: tfControl, decoration: const InputDecoration(hintText: "Enter data!"),),
                            backgroundColor: Colors.grey,
                            //controller a tfcontrol diyeerek sendedn veriyi bunun ile okuyacagim demis oluyroz
                            //InputDecoration web-input lardaki placehoolder mantiginda, inputa veri girlince kaybolur
                            //input mantignda TextFied kullanacagiz..bunun icin TextField verilerini alabilmek icin sayfanin ustudne
                            // bir tfControl olusturmami8z gerekiyor herhangi bir yerden girilen veriyi okuyabilmek icin-var tfControl = TextEditingController()
                            actions:[
                              TextButton(onPressed: ()
                              {
                                print("Cancel is clicked!!");
                                Navigator.pop(context);//AlertDialog butonunu kapatiyor yani bir
                                //oncekine aliyor aslinda ..gibi..geri tusuna basinca ne oluyorsa onu yapyor ve alert-popupu kapanmis oluyr
                              }, child:const Text("Cancel",style:TextStyle(color:Colors.black)),),
                              TextButton(onPressed: (){
                                print("Taken data: ${tfControl.text}!!");//Burda TextField-input a girilen datayi alabiliyoruz...tfControl aracilig ile
                                Navigator.pop(context);
                                //alert-popup kapatildiktan sonra girilen input alert icinde kalmasin diye, temizlemek icin
                                tfControl.text = "";
                                //Boyle yapariz ki bir sonraki bu alert acildiginda icerisinde en son girilmis deger gelmesin, bos gelsin
                              }, child:const Text("Save",style:TextStyle(color:Colors.black)),)
                            ]
                        );
                      });

                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor:Colors.white),
                child:const Text("Alert(Custom)")
            ),
          ],
        )
      )
    );
  }
}
