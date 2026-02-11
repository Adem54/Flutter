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

  final people = [
    {"name": "Ahmet", "phone": "555 111 22 33"},
    {"name": "Zeynep", "phone": "555 444 55 66"},
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Homepage")),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView.builder(
            itemCount: people.length,
            itemBuilder: (context, i) {
               final p = people[i];
               print("p::${p}");
               return GestureDetector(
                 onTap: (){
                   //Simdi burda tiklanan datayi bizim person_Detail sayfaisna gondermemiz gerekioyr yani parent dan childa
                   // data gonderecgiz o zaman push ile constructora data gondeririz
                   Person person = Person(person_id:1,person_name:p["name"]! , person_tel: p["phone"]!);
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(person:person)))
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
                              people[i] = {"name": value.person_name, "phone": value.person_tel};
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
                              // setState(() => people.removeAt(i));
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