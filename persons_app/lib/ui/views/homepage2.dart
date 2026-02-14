import 'package:flutter/material.dart';
import 'package:persons_app/data/entity/person.dart';
import 'package:persons_app/ui/views/detail_page.dart';
import 'package:persons_app/ui/views/register_page.dart';

class Homepage extends StatefulWidget {
/*
  String personName;
  String personNumber;

  Homepage({required this.personName, required this.personNumber});
  */
  //Peki...burda homepage de register de girilen name ve number i nasil persons listeme ekleyerek direk homepage e gelir gelmez liste iceriisnde gozukmesini saglayacam

  //Homepage, Navigator.push(...).then((value){ ... }) içinde o veriyi yakalar ve setState ile people listesine ekler

  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  //Problem ne problem type sorunu yasiyruz...hem integer hem de string kullaniuorsun icerde...nasil olacak bu...
  //Tipini diyorki sen int verecem diyuorsun ama object tipi oolarak beklioyr vs diye bir hata veriyor
  /*COZUM BOYLE OLABLIR BOYLE DUURMLARDA
  * final List<Map<String, dynamic>> people = [
  {"id": 1, "name": "Ahmet", "phone": "555 111 22 33"},
  {"id": 2, "name": "Zeynep", "phone": "555 444 55 66"},
];

  * */
  final List<Map<String, String>> people = [
    {"name": "Adem", "phone": "555 111 22 33"},
    {"name": "Zeynep", "phone": "555 444 55 66"},
    {"name": "Zehra", "phone": "999 444 55 66"},
  ];

  //AMA SIMDILK BIZ INTEGER OLAN DEGERI KALDIRALIM OK
  Future<List<Person>> fetchPersons() async {
    var personList = <Person>[];
    var person1 =  Person(person_id:1, person_name: "Adem", person_tel: "555 111 22 33");
    var person2 =  Person(person_id:2, person_name: "Zeynep", person_tel: "444 666 888 11");
    var person3 =  Person(person_id:3, person_name: "Zehra", person_tel: "222 333 999 01");
    personList.add(person1);
    personList.add(person2);
    personList.add(person3);

    return personList;

  }


  late List<Map<String, String>> filteredPeople;//late diyerek ben bunu sonra atyacam diyorsun bu sekilde atamasan
  // da hata almiyorsun normalde bos birakip gecemezsn hata alirsin en azindan default value atmaak zorundasin
  // ya da git onu nullable yap derler adama
  bool isSearching = false;
  final TextEditingController searchCtrl = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    filteredPeople = List.from(people); // başlangıçta hepsi görünsün
  }

  //Bu fonksiyon yazdığın arama kelimesine göre listeyi daraltıyor:query boşsa → herkes görünsün,query doluysa → name veya phone içinde geçenleri göster
  //setState koymamın sebebi:Liste değişti → UI yeniden çizilsin.
  //where = filtrele, contains = içinde geçiyor mu?
  Future<void> filter(String query) async {
    print("query!!!!!!: ${query}");
    //kullanici search yaparken texfield-input a girdigi text anlik olarak buryaa geliyor
    final q = query.toLowerCase().trim();

    setState(() {
      if (q.isEmpty) {
        filteredPeople = List.from(people);
      } else {
        filteredPeople = people.where((p) {
          final name = p["name"]!.toLowerCase();
          final phone = p["phone"]!.toLowerCase();
          return name.contains(q) || phone.contains(q);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }
  // dispose() nedir, niye yaparız?
  /*
  *Flutter’da bazı şeyler “kaynak” kullanır:
TextEditingController
AnimationController
FocusNode
StreamSubscription vs.
Bunlar arkada:
listener tutar,
hafıza (memory) kullanır,
bazen klavye/focus gibi sistem kaynaklarına bağlanır.
Sayfa kapandığında (widget ekrandan gidince) bu kaynakları serbest bırakmazsan:
memory leak gibi gereksiz kaynak kullanımı olur,
“A TextEditingController was used after being disposed” gibi hatalar görebilirsin,
özellikle uygulama büyüyünce performans düşebilir.
* O yüzden:
* @override
void dispose() {
  searchCtrl.dispose(); // ✅ controller'ı kapat
  super.dispose();      // ✅ Flutter'ın kendi temizliğini de çalıştır
}
Özet: “Bu sayfa öldü, controller’ı da öldür.”
   */


  @override
  //peki neden actions kullanilyor action s icerisinekoyduklarmz ile persons yazisin text icinde de
  // appBar icindeki ttile yanyana oyle mi ayrica peki bunlar ayni hizada mi bulunuyor peki dikey de
  // ve yatay da da neye gore hizalaniyor bunlara bizde ayarlama yapaiblikr miyiz hizalama konusunda
  /*
1) title ile actions yan yana mı?
Evet, pratikte aynı yatay satırda gibi düşün:
title: → solda (leading’den sonra kalan alanda)
actions: → sağda (en sağda, yan yana ikonlar)
Ama teknik olarak AppBar kendi layout’uyla bunları yerleştiriyor (Row gibi).
2) Aynı hizada mı (dikey/yatay)?
Evet:
Dikeyde: AppBar’ın yüksekliğinin ortasına göre hizalanırlar (center-ish).
Yatayda: actions elemanları sağa yaslanır ve yan yana dizilir.
Sen ekstra bir şey yapmasan bile “güzel hizalı” durmasının sebebi AppBar’ın bunu standartlaştırması.
Hizalamayı biz ayarlayabilir miyiz?
Evet, birkaç yaygın ayar var:Başlığı ortalamak (Android’de default sola yakın, iOS’ta ortalı olabilir)
centerTitle: true,
B) Title ile actions arasında boşluğu kontrol etmek
actions ikonlarının sağa yaslanma/padding’ini kontrol için:
actionsPadding: const EdgeInsets.only(right: 8),
(Flutter sürümüne göre actionsPadding varsa kullanırsın; yoksa Padding ile sararsın.)
Action ikonlarını daha farklı hizalamak (çok gerekmez)-actions içine Row, Center, Align koyabilirsin ama çoğu zaman gerek yok:
AppBar yüksekliğini değiştirmek-toolbarHeight:70
Kısa özet (notluk)
title solda başlık
actions sağda ikon/buton alanı
Aynı satırdalar, dikeyde otomatik ortalanırlar
centerTitle, toolbarHeight, Padding ile ince ayar yaparsın

  * */
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//AppBar’da neden isSearching kullandık?Su mantik Normalde: title = "Persons",Search’e basınca: title = TextField-
// Bu switch’i yapmak için bir boolean (aç/kapa) değişkeni lazımdı:
          title: isSearching ?
          TextField(
            controller:searchCtrl,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: "Search....",
              border: InputBorder.none,
            ),
            //onChanged: filter,//Bu islem ile alttaki islem ayni seydir aslinda
            onChanged:(searchedText){
              filter(searchedText);
            }
            //yazdikca filtrele...Burda dikkat et yazdikca filtrelioyr...
            //Burada olan şey şu: TextField sen yazdıkça onChanged callback’ini tetikliyor ve içine otomatik olarak yazdığın anki metni gönderiyor.
            // 1) onChanged: filter nasıl çalışıyor?(String nasıl geliyor?)
            //TextField’ın onChanged parametresi şu tiptedir:ValueChanged<String> onChanged
            //Bu da şu demek:Bu fonksiyon String alacak ve bir şey yapacak.Yani sen şunu yazmış oldun:onChanged: (String text) {filter(text);}
            //Ama Dart’ta şöyle bir kısayol var:Eğer fonksiyonun imzası uyuyorsa (filter String alıyorsa),onChanged: filter yazınca otomatik bağlar.
            //Senin filter fonksiyonun zaten böyle:void filter(String query) { ... }
            //İmza uyuyor → TextField yazdıkça query parametresine yazdığın metin geliyor.
            //Bu yöntem “yazdıkça arama”dır.İstersen “Enter’a basınca ara” mantığı için onSubmitted kullanılır.
            //TextField her tuşa bastığında kendi içindeki metni günceller ve o güncel metni onChanged callback’ine gönderir.
            // Yani bu: onChanged: filter,şunun aynısı:onChanged: (text) {  filter(text); // text = o anki yazı},
            //Bu “otomatik gönderme” olayı TextField’ın kendi davranışı.
            //controller: searchCtrl ne işe yarıyor?Controller şunu sağlar:
            //TextField’ın mevcut metnini dışarıdan okuyabilirsin: searchCtrl.text-TextField’ın metnini dışarıdan değiştirebilirsin: searchCtrl.text = ""
            //clear() yapabilirsin: searchCtrl.clear()
            //Ama onChanged’in çalışması için controller şart değil.
            //Mini Ozet:onChanged → “kullanıcı yazdı, sana yeni text’i haber veriyorum”
            // controller → “TextField’ın text’ine dışarıdan erişmek / değiştirmek istiyorsan kullan”
          )
          : const Text("Appbar Serach"),
          actions: [
            //Ve search ikonuna basınca:arama aç/kapa,kapanınca text’i temizle ve listeyi resetle

            //Arama yapiliyor ise cancel iconu goster, arama yapilmyr ise search iconu goster
            isSearching ?  IconButton(icon: const Icon(Icons.cancel), onPressed: ()
            {
              setState(() {
                isSearching = !isSearching;//cancel butonna tiklaninca arama bitirsin isSearch tersine doner...
                if (!isSearching) {
                  searchCtrl.clear();
                  filteredPeople = List.from(people); // aramayı kapatınca reset
                }
              });
              print("cancelll!!");
            }) :  IconButton(
              icon:const Icon(Icons.search),
              onPressed: (){
                print("search!!!");
                setState(() {
                  isSearching = !isSearching;
                 /*  if (!isSearching) {
                    searchCtrl.clear();
                    filteredPeople = List.from(people); // aramayı kapatınca reset
                  }*/
                });
              },
            ) ,

            IconButton(icon: const Icon(Icons.more_vert), onPressed: () {
              print("settings!!");
            }),
          ],
      ),
        //The following RangeError was thrown building:
      // RangeError (length): Invalid value: Only valid value is 0: 1 boyle bir hata aldim sebeb i nedir?
      //Bir listede olmayan index’e erişmeye çalışmışsın.Örn: listenin length’i 1 iken sen [1] istiyorsun. (tek eleman varsa index sadece 0 olur)
      //Arama senaryosunda bu hata genelde şu yüzden olur:Sen filteredPeople ile listeyi çiziyorsun ama bir
      // yerde hâlâ people[i] gibi başka listeyi index’liyorsun.
      // Örneğin bu çok klasik hata:final p = filteredPeople[i]; // doğru onTap:(){ final original = people[i]; // ❌ yanlış! filtered ile people indexleri aynı olmayabilir
      //Filter sonrasi filteredPeople.length 1 olablir ama people[i] demeye calisinca patlar
      //RangeError kesin çözüm (doğru index kullan)ListView içinde sadece filteredPeople kullanıyorsan, onTap içinde de onunla git:
      //Ama güncelleme/silme gibi işlemde “asıl liste”yi değiştirmek istiyorsan:filtered item’ın people içindeki gerçek index’ini bulman gerekir.
      //Örnek: silme için doğru yöntem final p = filteredPeople[i]; final realIndex = people.indexOf(p); // aynı map referansı ise çalışır
      //setState(() {
      //   people.removeAt(realIndex);
      //   filteredPeople = List.from(people); // veya tekrar filter(searchCtrl.text)
      // });
      //BU SEKILDEE KULLAN!!!!!!!!!!!!!
      // // people[i] = {"name": value.person_name, "phone": value.person_tel};  yerine  final realIndex = people.indexOf(p);
      // people[realIndex] = {"name": value.person_name, "phone": value.person_tel};


      //Tutor ise FutureBuilder<List<Person>> kullandigini performansli sekiklde verileri getirmek istedginde bunu kullandigiji soyledi..
      //yukardaki Future<List<Person>> methodu bu tipteki veriyi dondurdugu icin, FutureBuilder<List<Person>> bu sekilde 
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView.builder(
           // itemCount: people.length,
            itemCount: filteredPeople.length,
            itemBuilder: (context, i) {
              // final p = people[i];
               final p = filteredPeople[i]; //filtered i bassin diyoruz simdide.
               //filteredPeople = ekranda gösterdiğin liste (filtreli hali)
               //Çünkü arama yapınca:people’dan eleman “silmek” istemiyoruz
               // sadece ekranda “şimdilik” az gösteriyoruz ama Arama bittiğinde:
               // tekrar full listeye dönmek istiyoruz..filteredPeople = List.from(people); bu da demek oluyor ki:“Başlangıçta ekranda herkesi göster.”
               print("p::${p}");
               return GestureDetector(
                 onTap: (){
                   //Simdi burda tiklanan datayi bizim person_Detail sayfaisna gondermemiz gerekioyr yani parent dan childa
                   // data gonderecgiz o zaman push ile constructora data gondeririz
                   int person_id = i +1;
                   Person person = Person(person_id: person_id, person_name: p["name"]!, person_tel: p["phone"]!);
                  // Person person = Person(person_id: 1, person_name: "Haakan", person_tel: "532456442");
                   //The argument type of object can not assigned to the parameter type int?
                   //Person(person_id: p["id"]!,person_name:p["name"]! , person_tel: p["phone"]!);
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(person:person)))
                   //BURAYA DIKKAT VERI TRANSFERI YAPTIGMZ ICIN DETAILPAGE IN BASINA CONST KOYAMAYIZ..
                       .then((value){
                          print("value-comesfrom-detail-page: ${value}");
                         /* if (value != null && value is Map<String, String>) {//
                           {  person_id: widget.person.person_id,
                              person_name: tfPersonName.text,
                                person_tel: tfPersonNumber.text,
                            } boyle gonderilme durumunda bu sekilde alabiliriz..datayi..Map mantiginda..
                            setState(() {
                              people[i] = value;
                              // ✅ i. kişiyi komple güncelledik: {"name": "...", "phone": "..."}
                            }); */
                          if (value is Person) {
                            setState(() {
                              // people listen Map ise (senin şu anki yapı):
                              //Aslinda normalde people icindeki id ile value den gelen id yi eslestirip peopla da hangi id ye denk geliyrsa
                              // ona ait degerleri degsitirebiliriz ama burda index uzerinden ypamisiz bu da dogru bir yaklasimdir

                              final realIndex = people.indexOf(p);
                              // people[i] = {"name": value.person_name, "phone": value.person_tel};
                              //yerine
                               people[realIndex] = {"name": value.person_name, "phone": value.person_tel};
                               print("realIndex: ${realIndex}");
                               print("filteredPerson: ${filteredPeople}");
                            });

                          }
                      /*
                      paramtreyei person class i uzerinden gondermeye calistimgzda .then de hata aldik:48:25: Error: The method 'then' isn't defined for the type 'MaterialPageRoute<dynamic>'.
                       - 'MaterialPageRoute' is from 'package:flutter/src/material/page.dart' ('../../../flutter/packages/flutter/lib/src/material/page.dart').
                      Try correcting the name to the name of an existing method, or defining a method named 'then'.
                       .then((value){
                       bu hata nedir nasil cozulur!!!
                       Hata mesajın %100 parantez hatası yüzünden geliyor:
                       then metodu Navigator.push(...)’in döndürdüğü Future üzerinde vardır.
                       Ama senin kodda then yanlışlıkla MaterialPageRoute(...) üzerine bağlanmış görünüyor.
                       MaterialPageRoute(builder: (context) => DetailPage(person: person)).then yerine MaterialPageRoute(builder: (context) => DetailPage(person: person))).then olacak..
                      * */

                          //Bunu güncellemenin mantığı şu:
                     //Detail’e giderken hangi kişinin güncelleneceğini biliyorsun: i (index)
                     //Detail’den pop ile yeni değerler geliyor: value
                     //O index’teki elemanı setState içinde replace ediyorsun
                     //Eğer sadece alan alan güncellemek istersen
                     /*
                     * setState(() {
                          people[i]["name"] = value["name"]!;
                          people[i]["phone"] = value["phone"]!;
                        });
                        * Ama en temiz olanı genelde:
                        ✅ people[i] = value;
                        final people..yapinca
                        * final neyi kilitler?
                        * final → değişkenin kendisini (referansı) kilitler.
                        * Yani:
                        * final people = [
                          {"name": "Ahmet", "phone": "555"},
                        ];
                        * Burada people değişkeni artık hep aynı listeyi işaret eder.
                        Şu yasak ✅❌:
                        * people = [];              // ❌ olmaz
                        people = anotherList;     // ❌ olmaz
                        Çünkü people’ı başka bir listeye “yeniden atayamazsın”.
                        * 2) Ama listenin içini değiştirmek serbest mi?
                          Evet ✅ çünkü liste mutable (değiştirilebilir) bir nesne.
                          Şunlar serbest ✅:
                          people.add({"name":"Zeynep", "phone":"444"}); // ✅ eleman eklemek
                          people.removeAt(0);                           // ✅ eleman silmek
                          people[0] = {"name":"Ali", "phone":"111"};    // ✅ elemanı değiştirmek
                          people[0]["name"] = "Veli";                   // ✅ map içindeki alanı değiştirmek
                          Çünkü bunlar “people değişkenini başka şeye eşitlemiyor”, sadece people’ın gösterdiği listenin içeriğini değiştiriyor.
                          *
                     * */

                   });
                 },
                 child: Container(
                  width: double.infinity,// double.infinity demek “Mümkün olan en geniş width’i al (sonsuz gibi düşün), yani parent’ın izin verdiği kadar yayıl.”
                   //Yani Container ekranda/parent içinde ne kadar yer varsa o kadar genişlemeye çalışır
                   //ListView içinde her satırın (Container’ın) tam genişlikte olmasını sağlar.Kısacası: “tam genişlik” demek.
                   //Kart gibi, soldan sağa dolu görünür, Row içindeki içerik daha düzgün hizalanır
                  margin: const EdgeInsets.symmetric(vertical: 6), // ✅ kutular arası boşluk
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                     children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(p["name"]!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              Text(p["phone"]!, style: TextStyle(color: Colors.grey.shade700)),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                              // silme işlemi: (StatefulWidget içinde)
                            final realIndex = people.indexOf(p);
                               setState(()
                                 {
                                    people.removeAt(realIndex);
                                    filteredPeople = List.from(people); // veya tekrar filter(searchCtrl.text)
                                 }
                               );
                                    },
                                ),
                    ],
                  ),
                 ),
               );
            },
        ),

      ),

      // ✅ Sağ altta sabit duran + butonu..
      // yani ekran da scrolla kisi leri yukari dogru scroll etsek de
      // bu pluss + iconu hep sabit olarak kalacaktir
      //body nin altindakullaniliyor
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // örnek: listeye yeni kişi ekle
          /*setState(() {
            people.add({"name": "Adem", "phone": "444444444"});
          });*/
          Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterPage()))
              .then((value){//kullanici geri Register sayfasindan geri gelirken burasi tetikelnecek
                // then kismi cunku burdaki Navigator.push ile register sayfasina gittigi icin,
            // nerden gitti ise geri gelirkende orasi uzerinde tetiklenecek!!
            //BURASI COK ONEMLI...SAYFA YA GERI DONULDUGUNDE BIZIM YAPMAK ISTEDGIMZ ISLEMLER OLACAK
                print("you come back to homepage-value: ${value}");
                // you come back to homepage-value: {name: Zeynep Erbas, phone: 450343434}
                if(value != null && value is Map<String,String>){
                  setState(() {
                    people.add(value);
                  });
                }

          });
        },
        child: const Icon(Icons.add),
      ),

      // ✅ (opsiyonel) konumu sağ alt yapar (zaten default bu)
     floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      //floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,//sola alta yaslar

    //  floatingActionButtonLocation: FloatingActionButtonLocation.startTop,//sol uste yaslar
     // floatingActionButtonLocation: FloatingActionButtonLocation.endTop,// sag uste yaslar


      bottomNavigationBar: BottomAppBar(
        color: Colors.black54,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text("Footer", style:TextStyle(color:Colors.white)),
        ),
      ),

    );
  }
}

//Scaffold’ın kendi alanı olan floatingActionButton’ını kullanmak ✅
// Çünkü FAB, body’den bağımsız şekilde ekrana “üstten bindirilir”
// (overlay gibi) ve liste scroll olsa bile sağ altta sabit kalır.
//FAB’ın rengi “mavi” geliyorsa bu Theme’in primaryColor’ından gelir.
// (İstersen onu da 2 satırda özelleştiririz.)
//floatingActionButton body’ye eklenmez, Scaffold üstünden yerleşir.
// Bu yüzden “listeden bağımsız” dediğin şey tam olarak böyle çözülür.

/*
* 1) Map<String, String> nedir?

Map = sözlük / dictionary gibi düşün.

List’te elemanlar index ile gider: people[0]

Map’te elemanlar key ile gider: p["name"]

Sen zaten bunu kullanıyorsun:

{"name": "Ahmet", "phone": "555..."}
Bu tam olarak bir Map.

Map<String, String> ne demek?

Map’in tipi:

key (anahtar) tipi = String

value (değer) tipi = String

Yani şöyle demek:

Anahtarlar “name”, “phone” gibi yazıdır (String)
Değerler de “Ahmet”, “555…” gibi yazıdır (String)

Örnek:
Map<String, String> person = {
  "name": "Ahmet",
  "phone": "555 111 22 33",
};


2) Peki final Map<String, String>? newPerson; ne?

Burada 2 şey var:

a) final

Değişkenin kendisi sonradan başka bir Map’e eşitlenmesin (referans sabit).

b) ? (nullable)

Bu çok önemli:

Map<String, String>? demek:

Bu değişken Map de olabilir, null da olabilir.

Niye lazım?
Çünkü bazen Homepage’e “yeni kişi” göndermeyeceksin.
O zaman newPerson = null olur.


3) if (value != null && value is Map<String, String>) ne yapıyor?

Navigator.push(...).then((value) { ... }) içindeki value şudur:

RegisterPage’den Navigator.pop(context, value) ile gelen şey.

Ama kullanıcı:

hiç kaydetmeden geri de çıkabilir

veya yanlış tipte bir şey dönebilir (senin kodun büyüyünce)

O yüzden güvenlik için:

value != null

Boş dönmediyse devam et

value is Map<String, String>

Gelen veri gerçekten “name/phone” Map’i mi?
Evetse ekle.

Bu bir “type check” (tip kontrolü).
*
* PERSON DETAIL SCREEN-NAVIGATION
Her bir kisiye tiklandignda detail_page a gitmesi icin bir tiklama olusturmamz gerekiyor container in kendine ait tiklamasi yok...
* O zaman ne yapyorduk container a tiklama eklemek icin...GestureDetector i Container a secip-enter yaparsak widget secip GestureDedector ekleyebiliyorduk
*
*                  //Biz bu sekilde tiklamasi olmayan bir nesneye tiklama yaptiracagiz zaman bu sekilde tek tap, cift tap, ve uzun tap vs gibi gesture lar verebilyrouz...
                 GestureDetector(
                     onTap:(){
                       print("Container tek tiklandi");
                     },
                     onDoubleTap: () {
                       print("Container Cift tiklandi");
                     },
                     onLongPress: (){
                        print("Container uzerine uzun basildi");
                     },

                     child: Container(width: 400, height: 500, color:Colors.red)
                     //Asagida ki sinirin altina gecihyor dolayisi ile de 89 px asagidaki sinirin altina gecmis ondan dolayi da biz boyle sari-siyah cizgilerle hata goruntusu aliriz..tasma problemi
                   //Bu hatayi nasl cozeriz bu tasarim ekana buyuk geliyorsa scroll ozelligi vererek cozebilirmiyiz..Bunujn icin scaffold daki body deki Center i secip alt enter yapariz..
                   // body: SingleChildScrollView( child: Center(...Artik sayfayi yukari asagi scrolla kaydirabilyoruz...Tasarim ekranin dogal boyutunu gecmezse zaten scroll ozelligi olmayacak
                   // ama ekran boyutunu gecerse o zaman scroll ozelligi gelecektir
                 ),

                //Tiklama ozelligi olmayan gorsele biz tiklayabiliriz bunu da container gibi yapilarda yapabiliyoruz

                //Row’un içinde 2 tane “panel” var. Ama Row’a sadece Container koyarsan:
                // Container kendi içeriği kadar yer kaplar
                // kalan alan boş kalabilir
*
*
* */