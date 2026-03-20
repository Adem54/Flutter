//Database access object-Dao
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:persons_app/data/entity/person.dart';

class PersonsDaoRepostory
{
  //Tabloya baglanti bu sekilde gerceklesiyor yani bakiyor bu var mi yoksa olusturyor herhalde cunku
  // biz kendimz bu tablo yu manuel olusturmadik firestore de ama direk data ekledik ve baktikki bu tabloya data eklenmis
  var collectionPersons = FirebaseFirestore.instance.collection("Persons");
  //boyle bir tablomuz olacak ve bu sayede tablomuza erisecegiz

  //SAVE ISLEMINDE HERHANGI BIR RETURN ILE DATA ALIP BU RETURN EDILEN DATAYI UI YA GONDERME
  // GIBI BIR ISLEM YAPMADIGMIZ ICIN UBISLEMI REPO DA YAPABILIRIZ...RETURN YAPIP DA GELEN DATAYI UI DA
  // GOSTERME ISLEMLERINDE BU ISLMEI CUBITTE YAPMAMIZ GEREKIR
  Future<void> Save(String person_name, String person_number) async{
    print("save the added person: ${person_name} - ${person_number}");
    var newPerson = HashMap<String,dynamic>();
    newPerson["person_id"] = "";//bos birakacagiz cunku ilk kayitta bos olacak daha sonra okurken collectionid yi okuyacagiz
    newPerson["person_name"] = person_name;
    newPerson["person_tel"] = person_number;
    collectionPersons.add(newPerson);
  }

//FIRESTORE DA UPDATE VE DELETE ISLEMINI REPODA YAPABILRIIZ CUNKU BURDA HERHANGI BIR RETURNE IHTIYACIMZ OLMAYACAK!!!
  //Firestore de calistigimzda person_id yi document id den alacagiz o da string...
  Future<void> Update(String person_id, String person_name, String person_number) async {
    print("update-person_name and- person-number: ${person_id} - ${person_name} - ${person_number}");
    var updatePerson = HashMap<String,dynamic>();
    updatePerson["person_name"] = person_name;
    updatePerson["person_tel"] = person_number;
    //Bize id gerekiyor..documentId..biz verimzi okurken hatirlayalim..person_id ye documentid yi atamistik..
    //Burdaki id gidiyor orda document_id  olarak ve gidip document_id yi bulur...
    collectionPersons.doc(person_id).update(updatePerson);
  }
//Burda biz update requesti gonddrerek endpointe database de bu data nin guncellenmesini salgayacagiz

  //AMA SIMDILK BIZ INTEGER OLAN DEGERI KALDIRALIM OK
  //Firesotore dan okuma islemini biz repodan yapamiyoruz cunku return edemiyoruz
  // bu firesotre a ozgu bir durum ondan dolayi
  // biz okuma islemini direk cubit te yapacagiz
  /*
  Future<List<Person>> fetchPersons() async {

  } */
//SAVE-UPDATE-DELETE I REPO DA YAPABLIORUZ CUNKU UI YA RETURN ETTTGIMZ BIRSEY YOK ARAYUZE VERI DONDURMUYORUZ
// GONDERMIORUZ BU METHODLARNI SONUCUNDA AMA READ-FETCH-SEARCH ISLEMLERINDE UI YA BIZ VERI RETURN
// EDIYORUZ ONDAN DOLAYI VERI RETURN EDIYORSAK REPO DA YAPAMIYORUZ DIREK CUBITTE YAPMAMIZ GEREKIYOR
//Firestore de calistigimzda person_id yi document id den alacagiz o da string...
  Future<void> deletePerson(String person_id) async{
    print("delete-person_id: ${person_id}");
    collectionPersons.doc(person_id).delete();

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
* */