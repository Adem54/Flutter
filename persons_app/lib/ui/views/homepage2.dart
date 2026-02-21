import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persons_app/data/entity/person.dart';
import 'package:persons_app/ui/cubit/homepage_cubit.dart';
import 'package:persons_app/ui/views/detail_page.dart';
import 'package:persons_app/ui/views/register_page.dart';

class Homepage2 extends StatefulWidget {
/*
  String personName;
  String personNumber;

  Homepage({required this.personName, required this.personNumber});
  */
  //Peki...burda homepage de register de girilen name ve number i nasil persons listeme ekleyerek direk homepage e gelir gelmez liste iceriisnde gozukmesini saglayacam

  //Homepage, Navigator.push(...).then((value){ ... }) içinde o veriyi yakalar ve setState ile people listesine ekler

  const Homepage2({super.key});
  @override
  State<Homepage2> createState() => _HomepageState2();
}

class _HomepageState2 extends State<Homepage2> {

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
  //BIZ BURDAN FETCHPERSONS METHODUNU YORUMA ALDIK CUNKU ARTIK BIZ BUNU HOMEPAGECUBITTEN ALIIYORUZ...
  /*
  Future<List<Person>> fetchPersons() async {
    var personList = <Person>[];
    var person1 =  Person(person_id:1, person_name: "Adem", person_tel: "555 111 22 33");
    var person2 =  Person(person_id:2, person_name: "Zeynep", person_tel: "444 666 888 11");
    var person3 =  Person(person_id:3, person_name: "Zehra", person_tel: "222 333 999 01");
    personList.add(person1);
    personList.add(person2);
    personList.add(person3);
    return personList;
  } */

  late Future<List<Person>> personsFuture;
  List<Person> persons = [];
  List<Person> filteredPersons = [];

  late List<Map<String, String>> filteredPeople;//late diyerek ben bunu sonra atyacam diyorsun bu sekilde atamasan
  // da hata almiyorsun normalde bos birakip gecemezsn hata alirsin en azindan default value atmaak zorundasin
  // ya da git onu nullable yap derler adama
  bool isSearching = false;
  final TextEditingController searchCtrl = TextEditingController();
/*
  Future<void> deletePerson(int person_id) async{
      print("delete-person_id: ${person_id}");
  } *///Baksana ben burda ; kullaninca hata aliyorum..ve expected class member vs yaziyor ama ; u kaldirinca hata da kalkiyor
 /*
 * Method class scope’ta olmalı-Yani _HomepageState2 sınıfının içinde, ama build() dışında:
 * “; koyunca hata alıyorum, kaldırınca kalkıyor” ne demek?
 * Dart’ta gövdeli (body’si olan) fonksiyon tanımının sonuna ; konmaz.
Sen ; koyunca Dart onu “bu bir declaration (bildirim), gövde yok” gibi algılamaya çalışır ve syntax bozulur.
* Yanlış — gövde varken ; koyamazsın
* Future<void> deletePerson(int personId) async {print("delete-person_id: $personId") }; // ❌ bu olmaz
* Peki ; nerede kullanılır?1) Değişken bitişi-final x = 5;
* Gövdesiz method bildirimi (abstract class / interface gibi yerlerde)
* abstract class Repo { Future<void> deletePerson(int id); // ✅ burada ; var çünkü gövde yok}
* Yani ; şunu demek:Yani ; şunu demek:Ama fonksiyonun zaten { ... } ile bitti. O yüzden ekstra ; yazınca “fazlalık/yanlış” oluyor.
* Bonus: Dart naming kuralı-Dart’ta fonksiyon isimleri genelde küçük harfle başlar:✅ deletePerson
❌ DeletePerson (çalışır ama standart değil)

 * */
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Simdi nasil aldik biz personListimzi ona bakalim, uygulama calisinca bu sayfay gelince initState ilk calisyrdu, ve buraya gleiyor ve
    // HomePageCubit te fetchPersons u cagiriyor, calistiriyor orda da personList i repostorydeki methodu cagirarak personListi alikyor
    // ve de hemen listeyi alir almaz da emit ile bu listeyi tekrar bu sayfaya gonderiyor, yani emit ile gonderdigi icin artik
    // bizim personListi bu sayfada FutureBuilder ile degil BlockBuilder almamiz gerekiyor ki
    // HomepageCubitten emit edilen personlistesini dinleyebilelim ve yakalayabilelim
    context.read<HomepageCubit>().fetchPersons();
    //Simdi ne yapiyruz HomepageCubitimizden degerimizi burda aliyoruz
    /*
    personsFuture = fetchPersons().then((list)
    {
      persons = list;
      filteredPersons = List.from(persons);
      return list; // ✅ Future<List<Person>> beklediği için list dön
    }); */

    filteredPeople = List.from(people); // başlangıçta hepsi görünsün
  }

  //Bu fonksiyon yazdığın arama kelimesine göre listeyi daraltıyor:query boşsa → herkes görünsün,query doluysa → name veya phone içinde geçenleri göster
  //setState koymamın sebebi:Liste değişti → UI yeniden çizilsin.
  //where = filtrele, contains = içinde geçiyor mu?

  //BU ARAMA ISLEMINI DE BIZ YINE HOMPEAGE CUBITTEN CAGIRACAGIZ...ORDA DA REPOSTORYDEN CAGIRILACAK
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
  @override
  //peki neden actions kullanilyor action s icerisinekoyduklarmz ile persons yazisin text icinde de
  // appBar icindeki ttile yanyana oyle mi ayrica peki bunlar ayni hizada mi bulunuyor peki dikey de
  // ve yatay da da neye gore hizalaniyor bunlara bizde ayarlama yapaiblikr miyiz hizalama konusunda

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
             // filter(searchedText);
              //Artik bu filter islemini biz, ne yapariz gidip HomepageCubit icinden cagiririz oray i tetikleriz..!!!!
              context.read<HomepageCubit>().search(searchedText);
            }
            //yazdikca filtrele...Burda dikkat et yazdikca filtrelioyr...
            //Burada olan şey şu: TextField sen yazdıkça onChanged callback’ini tetikliyor ve içine otomatik olarak yazdığın anki metni gönderiyor.
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
                 // filteredPeople = List.from(people); // aramayı kapatınca reset
                  context.read<HomepageCubit>().search(""); // ✅ full listeye dön
                  //“Cancel’da niye fetchPersons çağırmıyoruz da search(“”) diyoruz?”
                  //Sebep A: Fetch = tekrar veri çekmek (pahalı / gereksiz)fetchPersons() repo’ya gider (DB/API).
                  //Cancel’a basınca amacın:yeni veri çekmek değil,mevcut veriyi tekrar full göstermek
                  //O yüzden en hızlı:search(""); Bu _allPersons’tan full listeyi emit eder.
                  //Sebep B: Search state’ini bozmaz
                  //Sen _allPersons’ı zaten en son fetch’te doldurmuştun. Cancel’da tekrar fetch yapmak:
                  //gereksiz network/db..gereksiz gecikme
                  // bazen server’dan değişmiş data getirip UI’ı “zıplatabilir”
                  //Doğru olan: “aramayı kapat → local full listeye dön”.
                  //Mini not: Peki ne zaman fetch tekrar çağrılır?
                  //Şu durumlarda:
                  // Sayfayı “pull to refresh” ile yenilemek istersin
                  // Register’dan geri dönünce “server’dan tekrar çekmek” istersin
                  // DB’de dışardan değişiklik olduysa yeniden okumak istersin
                  // Onun dışında cancel/search temizlemede genelde fetch yapılmaz.
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

      //BU SEKILDEE KULLAN!!!!!!!!!!!!!
      // // people[i] = {"name": value.person_name, "phone": value.person_tel};  yerine  final realIndex = people.indexOf(p);
      // people[realIndex] = {"name": value.person_name, "phone": value.person_tel};
      //Tutor ise FutureBuilder<List<Person>> kullandigini performansli sekiklde verileri getirmek istedginde bunu kullandigiji soyledi..
      //yukardaki Future<List<Person>> methodu bu tipteki veriyi dondurdugu icin, FutureBuilder<List<Person>> bu sekilde
      //Simdi ok yani biz datayi uzak api den alacagimz dan dolayi bu yontem ile datayi guvenli bir sekilde aliriz data nin gelmeme durumna
      // gore de durumun handle edecek sekiklde kendimzi ayarlaabiliyoruz...
      //homepage_cubitten gonderilen-emit edilen personlistesini dinleyebilmek icin(.on mantiginda) alabilmek icin
      // burayi BlockBuilder ile sarmalayacagiz FutureBuilder yerine
        //body: FutureBuilder<List<Person>>(
      body: BlocBuilder<HomepageCubit,List<Person>>(
        //Blockbuilder 1.param:Hangi cubit, 2.paramtre o cubit hangi type i aliyor(class HomepageCubit extends Cubit<List<Person>>)
        //Blockbuilder kullnadigmz icin future:personFeature veya fetchPersons() buna gerek yok artik bunu kullanmayacagiz bu FutureBuilder de ihityac vardi
         // future: fetchPersons(),
         // future:personsFuture,
        //Burda context, tin yaninda direk olarak BlockBuilder ile sarmaladgimz icin biz homepage_cubitten
        // emit edilen gonderilen personList i alacagiz context in yaninda
          builder:(context, personList){//snapshot yerine personList yazdik sadece..snapshotta kalabilirdi..
            // ama biz emit ile gonderilen tetikelknen degeri dinledgimzi gostermek icin yaptik
            if(personList.isNotEmpty) {//simdi personList homepage_cubitten geldigi icin orda data getirildi, sadece o data buraya emit edildi..
              // yani biz burda data var mi diye kontrolu artik aslinda direk repostory de yapilacak daata nin fetch edildigi yer orasi
              // ve ordan bize direk olarak personList in kendisi gonderiliyor zaten,
              // ve default olarak da zaten [] atanmisti dolayisi ile artik BlocBuilder ile isEmpty veya isNotEmpty kontrolu yapacagiz
            //snapshot ile data var mi getirecegi data var mi onu kontrol ediyor
            //if(snapshot.hasData) {//Eger data var ise o zaman listelemeyi yapabilirz diyoruz...
               // var personList = snapshot.data; Biz zaten personList i aldigimz icin buna BlocBuilder icinde gerek yok artik,
              // bu da FutureBuilder de ihtiyac olan birseydi
                //datayi aldiktan sonra bu datayi ListView.builder uzerinden listeleyecegiz...
                return ListView.builder(
                  // itemCount: personList!.length,//personList in null gelme durumunda patlamamasi icin..
                  itemCount: personList.length,//Artik Blocbuilder kullandgimz icin personList!.length unleme e gerek yok,
                  // personList!.length FutureBuilder icin gecerli idi
                    itemBuilder:(context, index){
                     //itemBuilder itemCount taki lengt e  gore calisiyor bak dikkat
                      var person = personList[index];
                      //Card a tiklayinca ne yapacak person detayina gidecek ama Card in kendsinin tiklama ozelligi
                      // yok boyle durumlarda ne yapiyorduk, GestureDedector ekliyorduk Card i seceriz alt-enter
                      // wrap widget deriz ve GestureDedector ile wrap yaparak artik onTap yapabilir hale gelmis olacagiz
                      return GestureDetector(
                        onTap: (){
                          print("person: ${person}");
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(person:person)))
                              .then((value){
                                print("you come back to Homepage2");
                                //Ana sayfaya geri donuldugunde de biz List<Person> listesini veritabanindan fetch edecek fonks cagiraagiz ki
                                // detailpage de update islemi yapilabiliyrdu eger herangi bir update islemi gerceklesmis ise database
                                // de o degisiklkleri hemen alarak kullanicya ui da gosterebilmek icin
                                context.read<HomepageCubit>().fetchPersons();
                            print("value-comesfrom-detail-page: ${value}");
                            if (value is Person) {
                              setState(() {
                                // people listen Map ise (senin şu anki yapı):
                                //Aslinda normalde people icindeki id ile value den gelen id yi eslestirip peopla da hangi id ye denk geliyrsa
                                // ona ait degerleri degsitirebiliriz ama burda index uzerinden ypamisiz bu da dogru bir yaklasimdir

                                //  asıl listeyi güncelle..simdi dikat yukarda Listview icinde donmesi icinkullanilan
                                // personList icerisinde biz gidip de update-delete islemini yapmamiz dogru degil,
                                // bizim bu isi en ustte tanimladigimz persons veya peopla her ne ise ana liste
                                // uzerinden yapammiz gerekiyor bunu bilelim...iste bu diger react vs ye gore burda biraz daha farkli isliyor
                              //  final realIndex = persons!.indexWhere((p) => p.person_id == value.person_id);
                                 final realIndex = persons.indexWhere((p) => p.person_id == value.person_id);
                                 //persons artik cubitten geldigi icin oradan person olarak geliyor ondna dolalyi artik ! kullanmamia gereki yok
                                if (realIndex != -1) {
                                  persons[realIndex] = value;
                                }

                                // ✅ ekranda gösterilen listeyi de güncelle (arama açık olabilir)
                                final visibleIndex = filteredPersons.indexWhere((p) => p.person_id == value.person_id);
                                if (visibleIndex != -1) {
                                  filteredPersons[visibleIndex] = value;
                                }

                              });
                            }
                          });
                        },
                        child: Card( //Container yerine burda Card kullandik...dikkat edelim....
                          //Simdi bu kutularin card larin yukseklingi arttimrk istioruz o zaman aklmiza hemen ne gelecek SizedBox eklyelim row a disindan,
                          // ve bu SizedBox a biz widht,height verebilyoruz...Row u sec alt-enter yap wrap SizedBox yap
                          color: Colors.cyan,
                          child:SizedBox(
                            height: 80,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(person.person_name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                       // const SizedBox(height: 4),
                                        Text(person.person_tel, style: TextStyle(color: Colors.grey.shade700)),
                                      ],
                                    ),
                                  //Dikkat edelim..burda Expanded yerine Spacer kullanarak dedik ki sen bu IconButton u saga dogru
                                  // ne kadar bosluk var sa ittir,dedk ve Expand ile aslnda yaptgimz isi burda Spacer ile yaptik burda
                                  const Spacer(),
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      print("Delete!!!!!!!!!");
                                      // silme işlemi: (StatefulWidget içinde)
                                      ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        //backgroundColor: Colors.black38,
                                        content:  Text("Are you sure to delete the person: ${person.person_name}"),
                                        action: SnackBarAction(label: "Yes", onPressed: (){
                                            print("Yes button is clicked for deleted-oper");

                                          //  final realIndex = personList.indexOf(person);BU YANKIS YAKLASIMDIR
                                            // personList icerisinde biz gidip de update-delete islemini yapmamiz dogru degil,
                                            // bizim bu isi en ustte tanimladigimz persons veya peopla her ne ise ana liste
                                            // uzerinden yapammiz gerekiyor bunu bilelim...iste bu diger react vs ye gore burda biraz daha farkli isliyor
                                            //final realIndex = persons!.indexWhere((p) => p.person_id == person.person_id);
                                            final realIndex = persons.indexWhere((p) => p.person_id == person.person_id);//Arrtik direk List<Perosn> u cubit ten aldigmz icin ! ile null kontrolune gerek yok
                                            context.read<HomepageCubit>().deletePerson(person.person_id);
                                            //HomepageCubit teki deletePerson methodunu tetikleriz o da gidip veritabani islemlerini yaptigmz
                                            // ortak methodlari barindirdigmz yer olan repostory deki deletePerosn i tetikler ve delete islemimiz
                                            // bu sekilde veritabaninda gerceklesmis olur

                                            setState(()
                                                {

                                                  //Delete islemi, delete request gondeririz aslinda veri tabanina
                                                  if (realIndex != -1) {
                                                    persons.removeAt(realIndex);
                                                  }

                                                }
                                            );
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: const Text("Deleted"),)
                                            );

                                          //Delete request must be triggered..async delete func must be deleted!

                                        })
                                      )
                                      );

                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );

                    },

                );
            }else {
             // return const Center();//Data yok ise bos birsayfa goster

             // if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
              //Burasi zaten else..birde burd if kullanacaksan onun else olma durumujnda da return yapman gerekiyor
              // yani bu mutlaka return ile donmeli cunku widget tan inherit edilmis flutterda bircok class burda da
              // bu yukardan else olarak gburya gelen de widgettir ve else icinde direk return edilmelidir
              //Bu hata nin sebebi yukardaki aciklamadir: Error: A non-null value must be returned since the return type 'Widget' doesn't allow null.
              return const Center(child: CircularProgressIndicator());
            }


          }
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
                //Ana sayfaya geri donuldugunde de biz List<Person> listesini veritabanindan fetch edecek fonks cagiraagiz ki
                // register page de insert islemi yapilabiliyrdu eger herangi bir insert islemi gerceklesmis ise database
                // de o degisiklkleri hemen alarak kullanicya ui da gosterebilmek icin
                context.read<HomepageCubit>().fetchPersons();

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

      //BOTTOMNAVIGATIONBAR-FOOTER
/*
      bottomNavigationBar: BottomAppBar(
        color: Colors.black54,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text("Footer", style:TextStyle(color:Colors.white)),
        ),
      ), */

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