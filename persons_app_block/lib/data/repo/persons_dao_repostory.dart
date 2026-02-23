//Database access object-Dao
import 'package:persons_app/data/entity/person.dart';
import 'package:persons_app/sqlite/database_assistant.dart';

class PersonsDaoRepostory {

  Future<void> Save(String person_name, String person_number) async {
    print("save the added person: ${person_name} - ${person_number}");
    //1-Database e eriselim ilk olarak
    var db = await DatabaseAssistant.databasAccess();

    //kayit yapacagim person objesini map olarak vermemiz gerekiyor
    var newPerson = Map<String, dynamic>();
    newPerson["person_name"] = person_name;
    newPerson["person_tel"] = person_number;

    await db.insert("person",
        newPerson); //"person" tablo adi, newPerson da yeni kisi objesi map olarak ama
    //id yi kendisi auto-inc oldugu icin kendisi otomatik atayacaktir
  }

  Future<void> Update(int person_id, String person_name,
      String person_number) async {
    print(
        "update-person_name and- person-number: ${person_id} - ${person_name} - ${person_number}");
    //1-Database e eriselim ilk olarak
    var db = await DatabaseAssistant.databasAccess();

    //kayit yapacagim person objesini map olarak vermemiz gerekiyor
    var updatePerson = Map<String, dynamic>();

    updatePerson["person_name"] = person_name;
    updatePerson["person_tel"] = person_number;
    await db.update(
        "person", updatePerson, where: "person_id=?", whereArgs: [person_id]);
  }

//Burda biz update requesti gonddrerek endpointe database de bu data nin guncellenmesini salgayacagiz

  //AMA SIMDILK BIZ INTEGER OLAN DEGERI KALDIRALIM OK
  Future<List<Person>> fetchPersons() async {
    /*var personList = <Person>[];
    var person1 =  Person(person_id:1, person_name: "Adem", person_tel: "555 111 22 33");
    var person2 =  Person(person_id:2, person_name: "Zeynep", person_tel: "444 666 888 11");
    var person3 =  Person(person_id:3, person_name: "Zehra", person_tel: "222 333 999 01");
    personList.add(person1);
    personList.add(person2);
    personList.add(person3);
    return personList; */

    //1-Database e eriselim ilk olarak
    var db = await DatabaseAssistant.databasAccess();
    //<Map<String, dynamic>> bu nedir?
    //Bu Map sayesinde her bir tablodaki satiri-recordu yani Map e cevirecektir
    //Her bir recordda farkli type int,String.. column datalar olacagi icin key her zamn string oluyor
    // cunku key-value mantigi ile alior ama value bazen string, bazen int, bool vs olabileegi icin dynamic aliyor
    //Bizim kac satirmz var ise sorgudan fetch edilen hepsini maps olarak bize verecek
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM person");
    //maps i listeye cevirecegiz

    return List.generate(maps.length, (index) {
      var row = maps[index]; //Bu da bize her bir satiri verecek index 0 ile baslayacak
      print("row: ${row}");
      // row: {person_id: 1, person_name: Ali, person_tel: 999999}
      // row: {person_id: 2, person_name: Ece, person_tel: 888888}
      //Bu satiri person objesine donusturelim
      return Person(person_id: row["person_id"],
          person_name: row["person_name"],
          person_tel: row["person_tel"]);
    });
    //Emulator uzerinde daha once calisma yapildigi zaman bazen kopyalam islemin dogru yapmiyor
    // bu durumda device_manager a gelip ayarlar iconu 3 nokte ya tiklayip wipe data ya tiklariz
    // ama once durduruz emualatoru sonra wipe data deriz sonra calstiririz..ve de artik database/phonebook.sqlite
    // icindeki person verilierimz gelmis oluyor
    //NASIL OLDU GEENEL OALRAK OZETLERSEK
    //Biz bir veritabani olusturduk dbBrowser sqllite arayuzu ile ve icerisinde person isminde tablo ve 2 tane de personekledik
    //Sonra bu olusurken phonebook.sqlite dosyasi Flutter klasorumuz altinda olusturmustuk ve bu dosyayi kopyalip
    // persons_app_block/ altinda ana proje database klasoru olstuurp onun altina yapistirdik
    //Sonra da uygulamamiz calismaya baslayinca database/phonebook.sqlite  i aldi ve telefona aktardi
    // ve artik bizim datbase/phonebook.sqlite dosyasi ile telefonumuza aktardigimiz veritabaninin baglantisi yok
    // artik birbirinden bagimsiz sadece uygulama calisirken datatabase klasoru altindan dosyasyi alip telefona aktardi o kadar..
    //Flutter alinta ilk olarak dbBrowserSqllite ta olusturugmz phonebook.sqlite ile zaten hic alakasi ve baglantisi yok
    // onun biz sadece kopyasini alip database/phonebook.sqlite a yapistirmistik
    //Bu aktarma islemi ve erisimi de biz iste var db = await DatabaseAssistant.databasAccess(); bunun ile sagladik
    //pubspec e ekledigmz kutuphanleri ve database/phonebook.sqlite i load etmeyi de unutmamamiz gerekiyor
    /*
    * KUTUPHANELERI EKLEMEYI UNUTMAYALIM-SQL LITE I KULLANACAGIMZ ICIN ONUN LA ILGLI path: ve sqflite kutphaneinsi ekleriz!!!!!!!
* Sql lite i kullanabilmemiz icin pubspec.yaml da bir kutuphane ekleyecegiz:
* sqflite ismindekutuphaenimizi flutter_bloc: altinda path:(kopyalama islemi yapmak icin veritabanina erismeye caliskren onunla ilgil
*  bir kutupoane> dedikten sonra onun da altina sqflite: ekleriz..
*dependencies:
  flutter:
    sdk: flutter
  flutter_bloc:
  path:
  sqflite:
  *
  * *********database/phonebook.sqlite dosysini pubspec.yaml de sistemimize tanittmamiz gerekiyor ********************
flutter:

  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the material Icons class.
  uses-material-design: true

  assets:
    - database/phonebook.sqlite
  # To add assets to your application, add an assets section, like this:

  pub get diyerek bu dosyasimizi da sistemimizn tanimasini saglariz

  Ayrica bizim ekledigmz diger kutuphanlerimiz ise asagidaki amaclar icin var idi
  path: bu kopyalama islemlerini yapmamizi saglar
  sqflite: bu da sqllite ile calisabilmemizi saglar

  Artik veirtabani islemleri icin haziriz, veriliermiz direk phonebook.sqlite dan aliriz repostorymizi icerisinde

    * */
  }

  Future<List<Person>> search(String searchText) async {
    //1-Database e eriselim ilk olarak
    var db = await DatabaseAssistant.databasAccess();
    //<Map<String, dynamic>> bu nedir?
    //Bu Map sayesinde her bir tablodaki satiri-recordu yani Map e cevirecektir
    //Her bir recordda farkli type int,String.. column datalar olacagi icin key her zamn string oluyor
    // cunku key-value mantigi ile alior ama value bazen string, bazen int, bool vs olabileegi icin dynamic aliyor
    //Bizim kac satirmz var ise sorgudan fetch edilen hepsini maps olarak bize verecek
    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM person where person_name like '%$searchText%'");
    //maps i listeye cevirecegiz

    return List.generate(maps.length, (index){
      var row = maps[index];//Bu da bize her bir satiri verecek index 0 ile baslayacak
      print("row: ${row}");
      // row: {person_id: 1, person_name: Ali, person_tel: 999999}
      // row: {person_id: 2, person_name: Ece, person_tel: 888888}
      //Bu satiri person objesine donusturelim
      return Person(person_id: row["person_id"], person_name: row["person_name"], person_tel: row["person_tel"]);
    });

}

  Future<void> deletePerson(int person_id) async{
    print("delete-person_id: ${person_id}");
    //1-Database e eriselim ilk olarak
    var db = await DatabaseAssistant.databasAccess();

    //kayit yapacagim person objesini map olarak vermemiz gerekiyor
    await db.delete("person",where:"person_id=?", whereArgs: [person_id]);
  }


 // Future<void> filter(String query, List<Person> people) async {}
//Repository’nin işi “data source”. Filtre UI işidir. Şimdilik repository’de filter(...) yapma.
//Repository’de sadece bu kalsın:  Future<List<Person>> fetchPersons() async {
//Sonra API/DB olunca fetchPersons() gerçek çağrı yapacak.

}
/*
Filtreleme islemi
* Hedef Mimari
PersonsDaoRepository → veriyi getirir (şimdilik fake liste, sonra DB/API)
HomepageCubit → tek kaynak state: ekranda görünen List<Person>
Homepage2 → arama yazıldıkça cubit.search(query) çağırır, BlocBuilder zaten günceller.
Kritik: Cubit, filtreleme yapabilmek için “orijinal listeyi” de içinde tutmalı. Çünkü arama kapatılınca full listeye dönmek lazım.
* */

/*
* Artik veritabani ile ilgili yapacagimz kodlamalarda bu sayfaya repostory ye odaklancagiz...
*
* BURDA UYGULAMA MIMARISINDEKI HARIKA KISIM SU KI..BIZ SADECE GELIP BURAYA VERIABANI ILE ILGLI
* ASYNC-AWAIT ISLEMLERINI YAPARIZ...VE ARAYUZDE DEGISIKLIK YAPMAMIZA GEREK KALMAZ
* */