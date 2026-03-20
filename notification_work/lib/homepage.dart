import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //burda FlutterLocalNotificationsPlugin i kutphaneden import ederek kullanirz
  var flp = FlutterLocalNotificationsPlugin();

  //initstate icinde uygulama basladigin anda ilk olarak calistirmak istiyoruz bunu..
  Future<void> installation() async 
  {
    //Bu app/src/main/res/mipmap- /ic_launcher.png   bu resimleri kullanmak icin asagidaki gbi yazariz.
    //Bu resim uygulama iconu resmidir
    //Burda dikkat edelm mipmap-xhdpi, -hdpi,-mhdpi ..bunlar aslinda boyutlardir ayni resmin farkli boyutlardaki versiyonlari oklaosrler altindaidr..
    var androidSettings = const AndroidInitializationSettings("@mipmap/ic_launcher");

    //IOS AYARI
    var iosSettings = const DarwinInitializationSettings();
    //Bunda uygulama iconu olusturmamiza gerek yhok andorid gibi burda otomatik cekecek,
    // ama androidde paremetreye image in vermemiz gerekiyhor yukardak i gibi

    var installationSetting = InitializationSettings(android: androidSettings, iOS: iosSettings);
    await flp.initialize(settings:installationSetting, onDidReceiveNotificationResponse: notificationSelection);
    //Burasi bildirim almak icin yeterlidir ancak bildirime tiklayip ordan da sonuc almak istersek onun icinde
    // onDidReceiveNotificationResponse parmatresini ekleyip ona da bir notificationSelection fonksyonu tanimlayip
    //notificationSelection fonks icini doldururuz..paramtreye otomatik birsekilde notificationResponse gelecektir

  }

  //Burasi gelen bildirm secildigi zaman calisacaktir...
  Future<void> notificationSelection(NotificationResponse notificationResponse) async
  {
    var payload = notificationResponse.payload;
    if(payload != null)
      {
        print("Notification is selected: ${payload}");
      }//Bildirimin secilme kodlamasini yaptik simdide bildirim gosterme kodlamasi yapabiliriz
  }

  Future<void> showNotification() async
  {
      var androidNotificationDetail = const AndroidNotificationDetails(
          "id",//bildirimleri gruplamak icin instagramde begeniler, yorumlar
          "name",//ismi
          channelDescription: "channelDescription",//aciklamaasi
          priority: Priority.high,//hangisi oncelik olarak kullanilacak...
          importance: Importance.max//eski ve guncel kodlama hala gecerli oldugu icin ikisini de kullaniyoruz
      );
      //Bu ios icin
      var iosNotificationDetail = const DarwinNotificationDetails();

      //Simdi ikisin birlestiririz
       var notificationDetail = NotificationDetails(android: androidNotificationDetail, iOS: iosNotificationDetail);
       await flp.show(id:0, title:"Title", body: "Contains", notificationDetails: notificationDetail, payload: "Payload contain");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    installation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text("Notification")),
      body:Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(onPressed: (){
              showNotification();

            }, child: const Text("Create Notification"))
          ],
        )
      )
    );
  }
}
