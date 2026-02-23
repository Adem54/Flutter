import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

/*
* Bu countNumber değişkeni:
👉 _HomepageState objesinin içinde tutulur
👉 Bu obje yeniden oluşturulmadığı sürece değer kaybolmaz
* countNumber artık state objesinde kaldığı için 0’a geri dönmez”
* Bunun anlamı:
_HomepageState hala aynı obje
countNumber onun içinde tutuluyor
Flutter sadece UI’ı yeniliyor (build)
👉 O yüzden değer korunur
* Ne zaman 0’a döner?
Sadece şu durumda:
1) Widget tamamen yok edilirse
sayfadan çıkarsan
Navigator.pop vs.
2) Hot restart yaparsan
state sıfırlanır
* 👉 Değerin korunmasının sebebi: State objesinin yaşamaya devam etmesi
👉 setState sadece: “ekranı yeniden çiz” demek
* */
/*
* Neden açılışta build 2+ kez olabiliyor?
1) İlk frame: “ekranı bir an önce çiz”
Uygulama açılır açılmaz Flutter, elindeki state ile hemen ilk frame’i çizer.
Senin durumda countNumber = 0
O yüzden ilk BUILD: 0 geliyor.
2) Sonra framework bazı şeyleri netleştirip yeniden çizer
İlk frame’den hemen sonra Flutter/Engine tarafında bazı bilgiler “tam oturur” ve yeni bir frame daha gerekebilir. Örnekler:
Ekran ölçüleri / safe area / status bar inset (MediaQuery) gibi değerlerin kesinleşmesi
Text/font ölçümleri ve layout’un tam oturması (özellikle debug’da)
InheritedWidget’ların (Theme, MediaQuery, Localizations) ilk kurulum/yenilemeleri
Debug modunda bazı ek “layout/paint” döngüleri
Bu yüzden bazen sen hiçbir şey yapmasan bile ikinci build görebilirsin.
Yani 2. build’in “sebebi” çoğu zaman senin kodun değil; Flutter’ın ilk frame sonrası sistemi stabilize etmesi.
* */
class _HomepageState extends State<Homepage> {

  int countNumber = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //test();
    countControl();
  }
  bool ready = false;
  Future<void> countControl() async {
    print("countNUmber1: ${countNumber}");//Burda 0 alir her seferinde
    final prefs = await SharedPreferences.getInstance();
    //Bu tarz yapilarda once okuma yapilir once okuruz ki en son hangi sayi atanmissa onu almak isteriz
    // ki zaten atanmamis ise default degeri atariz
    final last = prefs.getInt("countNumber") ?? 0;
    //Burda 0 alir her seferinde burda da her seferinde en son degeri alir..
    //setState icinde countNumber calistginda yeniden build ediiyor...

    setState(() {
      countNumber = last + 1;
      ready = true;//0 degerini sadece countNumber ilk kez degeri 0 oldugunda goster sonra gosterme istersek boyle yapariz
    });
    // //Burda setState icerisinde biz guncelleme yapariz ve

    await prefs.setInt("countNumber", countNumber);
    print("countNumber4: ${countNumber}");
  }
  /*
  * setState() tetiklenince bu State objesinin build() metodu tekrar çalışır.
Ama initState() tekrar çalışmaz ve class’ın üstündeki field initializasyonları (örn. int countNumber = 0;) yeniden kurulmaz
*  (çünkü _HomepageState objesi yeniden yaratılmıyor; aynı obje “rebuild” oluyor).
* ✅ Yani “Homepage’in sadece build kısmı mı çalışıyor?” → Evet, esas olarak build tekrar çalışır.
❌ “build üstündekiler de çalışıyor mu?” → Hayır, initState gibi lifecycle fonksiyonları tekrar çalışmaz.
  * */

  /*
  * “build 2 kez çağrılabilir ama kullanıcı 2 ekran görmeyebilir” ne demek?

Flutter’da olan şey şu:
build() çalışır → Widget tree hesaplanır
Ekrana gerçek çizim ise frame olarak gelir (60fps gibi)
Eğer:
İlk build() (0 ile) yapıldı
ama o frame ekrana basılmadan hemen setState geldi
ikinci build() (1/2/3 ile) yapıldı
ve ekrana basılan frame zaten ikinci frame oldu
O zaman kullanıcı ilk (0) frame’i hiç görmez.
Yani build çalıştı ama gözle görünen çizim olarak ekrana düşmedi.
  * */



  Future<void> test() async {
    //Burda veri kaydi, okuma vs islemleri yapacagiz
    //Burda dosyadan veri okyacagi icin veri okurken gecikme olursa o dosyadaki veriyi okumadan bir alt satira gecmeyecek
    var shar_pref = await SharedPreferences.getInstance();//Bu sekilde instance yi aliyoruz shared_pref classindan
    //Veri kaydi
    shar_pref.setString("name", "Adem");
    shar_pref.setInt("age", 38);
    shar_pref.setDouble("height", 1.67);
    shar_pref.setBool("isMarried", true);
    List<String> cities = ["Skien", "Porsgrunn","Larvik"];
    shar_pref.setStringList("cities",cities);
    List<String> myFriendList = <String>[];
    myFriendList.add("Sercan");
    myFriendList.add("Yakup");
    shar_pref.setStringList("myfriendlist", myFriendList);


    //Veri silme
     //shar_pref.remove("name");
     //Bu sekilde sildigmz zaman asagida artik noname gelecektir...kalici olarak silmis olacak

    //Veri okuma
    //Simdi eger name isminde key yok ise hata verebilir ondan dolayi biz ?? deger yok ise bos string ver diyebilirz
    String nameFromSharedPref = shar_pref.getString("name") ?? "noname";
    print("nameFromSharedPref: ${nameFromSharedPref}");
    //Bu tarz veritabnain islemlerinde direk run tusuna basarak sonuc alamyabiliriz,
    // ondan doayi stop a basip sonra run a basarak deneyebiilriz
    //Bu name yukarda kaydedilgidi icin artik kalici olarak kaydedilmis oldu..
    // ki zaten yoruma aldik tekrar calistirdik ve gordukki yine name i okudugmzda
    // Adem olarak geldi demekki kalici olarak kaydetmis
    int ageFromShared = shar_pref.getInt("age") ?? 0;
    double heighFromShared = shar_pref.getDouble("height") ?? 0.0;
    bool isMarriedFromShared = shar_pref.getBool("isMarried") ?? false;
    List<String> citiesFromShared = shar_pref.getStringList("cities") ?? <String>[];
    List<String> myFriendsFromShared = shar_pref.getStringList("myfriendlist") ?? <String>[];
    print("ageFromShared: ${ageFromShared}");
    print("heighFromShared: ${heighFromShared}");
    print("isMarriedFromShared: ${isMarriedFromShared}");
    print("citiesFromShared: ${citiesFromShared}");
    print("myFriendsFromShared: ${myFriendsFromShared}");

    if(myFriendsFromShared != null && myFriendsFromShared.isNotEmpty)
      {
        for(var index=0; index < myFriendsFromShared.length; index++){
           var friend = myFriendsFromShared[index];
           print("friend: ${friend}");
        }
      }

    if(citiesFromShared.isNotEmpty)
      {
        for(var city in citiesFromShared)
          {
            print("city!: ${city}");
          }
      }

  }
//En onemli noktalardan bir tanesi shared preferences e kaydettgimz verye biz tum sayfalardan-tum screenlerde eriseibliriz
  @override
  Widget build(BuildContext context) {
    print("BUILD: countNumber=$countNumber");
    return Scaffold(
      appBar: AppBar(title: const Text("Shared Preferences"),),
      body:Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Opening Number: ${countNumber}", style:TextStyle(fontSize: 30)),
          /*  if (!ready)
              const CircularProgressIndicator()
            else
              Text("Opening Number: $countNumber", style: TextStyle(fontSize: 30)),

           */
          ],
        )
      )
    );
  }
}
/*
* Shared preferences i kullanabilmek icin pubspec.yaml da bir kurulum yapacagiz,
* kutuphane kurulumu:
*dependencies:
  flutter:
    sdk: flutter
  shared_preferences:

 * yazip sonra pub get e tiklariz...
*
*
* */