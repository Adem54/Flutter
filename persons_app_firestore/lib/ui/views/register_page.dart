import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persons_app/ui/cubit/register_page_cubit.dart';
import 'package:persons_app/ui/views/homepage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var tfPersonName = TextEditingController();
  var tfPersonNumber = TextEditingController();
  //TextEditingController sinifindan geliyor ve bu bize herhangi bir yerden veri okuyaiblmemizi saglar


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text("Register new person!")),
      body:Center(
        child: Padding(
          //padding: const EdgeInsets.all(24.0),
          padding: const EdgeInsets.only(left: 50, right: 50),
          //enteresan 24 yaptgimzda TextField cizgileri cok net, ama 36 yaptigmzda Person name,
          // kismi daha silik gozukuyor
          //Burda da gorebildgimz sekilde, bir kisim bosluklari padding ile koyabildik
          // ama daha kontrollu ve detayli width kontrolu icin ki ozellikle TextField gibi alnlarin width kontrolu icin SizedBox kullandik...
          //Simdi, Sizedbox u biz hatirlayalim..yanyana olan 2 widget yani row icindekik veya
          // column icindeki alt alta olan 2 widget arasina boslugu eger mainAxisAlignment kullanarak
          // koymak istemiyorsak o zaman SizedBox kullanarak koyabiirz bunu unutmayalim
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(controller: tfPersonName, decoration: const InputDecoration(hintText: "Person name!"),),
                TextField(controller: tfPersonNumber, decoration: const InputDecoration(hintText: "Person number!"),),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                    onPressed: (){
                       print("tfPersonName: ${tfPersonName.text}");
                       var personName = tfPersonName.text;
                       print("tfPersonName: ${tfPersonNumber.text}");
                       var personNumber = tfPersonNumber.text;
                       //context.read i biz flutter_bloc import sayesinde okuruz ve RegisterPageCubit
                       // sayesinde de RegisterPageCubit icindeki Save methoduna erisir burdan
                       context.read<RegisterPageCubit>().Save(personName, personNumber);
                     // Navigator.push(context, MaterialPageRoute(builder: (context)=> Homepage(personName:personName,personNumber:personNumber)));

                       //push ile degil, de pop ile geldigi yere gonderecegiz ve bu sekiiolde de datayi eklemek icin..
                       Navigator.pop(context, {"name": personName, "phone": personNumber});
                       //Burda datayi biz burda homepage yani girilen person datasini homepage denki persons listesine gonderiyoruz yani bir nevi geldgimz sayfa olan parent-homepage
                      //reguster use person datasi girilen child screen o zaman child screen den data parent e giderken,
                      // pop ile gondeririz ki homepage deki push ile buraya gelinirken ki navigator icindeki then ile burdan gonderilen data alinabilir kolayca
                       //Iste burayi dogru anlayalim..burda gonderdigmz veri, Homepage Navagtor.push ile gonderilen yerde then icindeki value uzerinden gonderilyor unutmyalim
                      //Ordaki value yi yazdiridgmzda su sekilde oraya gitmis oluyor:  you come back to homepage-value: {name: Zeynep Erbas, phone: 450343434}
                    },
                    child: Text("Save", style: TextStyle(color:Colors.white),))
              ],
            ),
          ),
        ),

      )
    );
  }
}

/*
Diyelim ki homepage degil de Persons ekranimiz olsa idi...personlari listeledgimz
Persons ekranındasın diyelim: + ile Navigator.push(RegisterPage) yaptın ya…
Register bitince pop(data) der ve hangi sayfa push ettiyse (Persons) ona geri döner. Yani akış aynı.

1) pop(data) ne zaman?

Form/işlem sayfası açıp sonuçla geri dönmek için.

Örnekler:

“Yeni kişi ekle” (Register) → kaydet → geri dön ve yeni kişiyi gönder

“Filtre seç” sayfası → seç → geri dön ve seçimi gönder

“Fotoğraf seç” → seç → geri dön ve dosyayı gönder

Bu mantık:
👉 Child page sonuç üretir, parent yakalar.

2) Constructor ile push yapıp veri gönderme ne zaman?

Bu tam tersi yön: Parent → Child’a veri gönderirsin.

Yani bir sayfa diğerini açarken der ki:
“Sana şu verilerle açıl.”
En yaygın senaryolar

A) Detay sayfası
Liste ekranındasın → bir kişiye tıkladın → detay sayfasına o kişiyi gönderirsin.

Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => PersonDetailPage(person: p),
  ),
);

B) Edit (düzenleme) sayfası
Var olan kişiyi düzenlemek için formu dolu açarsın.


Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => EditPersonPage(person: p),
  ),
);

C) Sayfanın başlangıç parametreleri
Örn: userId, categoryId, tabIndex, title gibi.


3) “Constructor ile Homepage’e veri yollayıp, Homepage’de listeye eklemek” nasıl olur?

Olur ama bu, genelde Homepage’i yeniden oluşturup yeni data ile açmak demek. İki yöntem var:

Yöntem 1 — Homepage açılır açılmaz listeye ekle (initState)

Homepage’e constructor ile newPerson gönder:

class Homepage extends StatefulWidget {
  final Map<String, String>? newPerson;
  const Homepage({super.key, this.newPerson});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final List<Map<String, String>> people = [
    {"name": "Ahmet", "phone": "555 111 22 33"},
    {"name": "Zeynep", "phone": "555 444 55 66"},
  ];

  @override
  void initState() {
    super.initState();
    if (widget.newPerson != null) {
      people.add(widget.newPerson!); // ✅ açılır açılmaz ekler
    }
  }

  @override
  Widget build(BuildContext context) { ... }
}

Ama şunu bil: Bu yaklaşımda sen “Homepage’e geri dönmek” yerine yeniden Homepage push etmiş oluyorsun. Navigation şişebilir.

Yöntem 2 — Mevcut Homepage’i güncelle (önerilen)

Bu yüzden senin senaryonda en doğrusu:
✅ Register → pop(data)
✅ Homepage/Persons → .then ile yakala → setState ile listeye ekle

4) Kural gibi akılda kalsın

Constructor ile veri gönderme = “sayfa açılırken ihtiyacı olan bilgi”
pop ile veri döndürme = “sayfa bir işlem yaptı, sonucu geri veriyor”

Senin “kişi ekledim, listeye yansısın” senaryosu → %90 pop/then.

Navigation şişebilir” ne demek?

Navigation, Flutter’da sayfaların üst üste yığıldığı bir stack gibidir.

Örnek:

Uygulama açıldı → Homepage

Sen Register’a gittin → push(Register)

Sonra Register’dan Homepage’e tekrar push edersen:

stack: Homepage -> Register -> Homepage

Sonra geri basarsan:

Homepage’den geri → Register’a dönersin (!!)

Register’dan geri → eski Homepage’e dönersin

Yani aynı sayfayı tekrar tekrar push edersen:

✅ Back tuşu saçma davranır
✅ Hafıza / state karmaşası olabilir
✅ “Neden geri basınca register geliyor?” dersin

İşte buna “navigation şişmesi” diyordum:
stack gereksiz sayfalarla doluyor.

Doğru akış

Register açılır: push(Register)

Kayıt biter: pop(data) → eski sayfaya geri dön ve veriyi ver

Stack temiz kalır:
Homepage -> Register (sonra pop ile tekrar Homepage)

İstersen sana tek cümlelik ezber:

push = yeni sayfa aç

pop = geri dön

pop(data) = geri dön + veri gönder

yani diyorsunki arkadas sen zaten homepage den register a gelmissin o zaman ne diye bir dha push ile hojmepage e
 yonleneceksin pop ile geri gitsene homepage e bu natural davranisti.r...ne diye dolambacli is yapiyorsun,,,gereksiz stack olustuyrorsun....

 Senin akışın zaten şu:

Homepage → (push) Register

O zaman kayıt bitince yapılması gereken “doğal” hareket:

Register → (pop) Homepage’e geri dön + veriyi gönder

Çünkü Register sayfası “araya giren” bir sayfa. İşini bitirince kapanmalı.

Neden tekrar push(Homepage) yanlış oluyor?

Çünkü şöyle bir yığın (stack) yapıyorsun:

Homepage (ilk)

Register

Homepage (ikinci kez)

Sonra geri basınca:

“yeni Homepage” kapanır → Register görünür

tekrar geri → eski Homepage

Kullanıcı “Ben kaydettim niye geri basınca register geldi?” der.

İşte bu da gereksiz, dolambaçlı ve kafa karıştıran navigation.

Doğru zihniyet

push: “yeni sayfa açıyorum”

pop: “bu sayfayı kapatıyorum, bir öncekiye dönüyorum”

pop(data): “bu sayfayı kapatıyorum + sonucu bir öncekiye bırakıyorum”

Register bir “form/işlem” ekranı olduğu için %90 kural:
✅ push ile açılır, pop ile kapanır.

* */