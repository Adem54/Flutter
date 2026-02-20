//Database access object-Dao
import 'package:persons_app/data/entity/person.dart';

class PersonsDaoRepostory
{

  Future<void> Save(String person_name, String person_number) async{
    print("save the added person: ${person_name} - ${person_number}");
  }

  Future<void> Update(int person_id, String person_name, String person_number) async {
    print("update-person_name and- person-number: ${person_id} - ${person_name} - ${person_number}");
  }
//Burda biz update requesti gonddrerek endpointe database de bu data nin guncellenmesini salgayacagiz

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

  Future<void> deletePerson(int person_id) async{
    print("delete-person_id: ${person_id}");
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