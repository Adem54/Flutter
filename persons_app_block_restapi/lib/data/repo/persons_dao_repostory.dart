//Database access object-Dao
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:persons_app/data/entity/person.dart';
import 'package:persons_app/data/entity/person_response.dart';

class PersonsDaoRepostory
{

  //Read-okuma islemini fonks uzernden yapacagiz..
  List<Person> parsePersons(dynamic data){
    //jsonResp-string formatinda bunun json formatinda fromJson paramtresine verilmesi gerekir
    //jsonResp: personlist ve success in oldugu liste
  //  return PersonResponse.fromJson(json.decode(jsonResp)).persons;
    // Dio genelde Map döndürür
    if (data is Map<String, dynamic>) {
      return PersonResponse.fromJson(data).persons;
    }
    // Bazı durumlarda String gelebilir
    if (data is String) {
      final decoded = json.decode(data) as Map<String, dynamic>;
      return PersonResponse.fromJson(decoded).persons;
    }

    throw Exception("Beklenmeyen response tipi: ${data.runtimeType}");
  }


  Future<void> Save(String person_name, String person_number) async{
    print("save the added person: ${person_name} - ${person_number}");
    var url = "http://kasimadalan.pe.hu/kisiler/insert_kisiler.php";
    //Bu url normalde bize uygumuyor biz sadece burayi gostermek icin kullaniyoruz burasi pratikte claismiyor
    // biz bizm person clasiimiza uygun insert endpoint olusturursak o zaman prtaikte de calisacaktir
    //Bize cevap gelecek ama farkli bir yontemle olacak ama once request ile gondereegimz verilri gondermemiz gerekiyor
    var requestData = { "person_name":person_name,  "person_tel":person_number };
    //post yontemi ile gondereeggiz
    var response = await Dio().post(url, data: FormData.fromMap(requestData));
    print("person-insert: ${response.data.toString()}");
  }

  //Burda biz update requesti gonddrerek endpointe database de bu data nin guncellenmesini salgayacagiz
  Future<void> Update(int person_id, String person_name, String person_number) async {
    print("update-person_name and- person-number: ${person_id} - ${person_name} - ${person_number}");
    var url = "http://kasimadalan.pe.hu/kisiler/update_kisiler.php";
    //Bu url normalde bize uygumuyor biz sadece burayi gostermek icin kullaniyoruz burasi pratikte claismiyor
    // biz bizm person clasiimiza uygun update endpoint olusturursak o zaman prtaikte de calisacaktir
    //Bize cevap gelecek ama farkli bir yontemle olacak ama once request ile gondereegimz verilri gondermemiz gerekiyor
    var requestData = {"person_id":person_id, "person_name":person_name,  "person_tel":person_number };
    //post yontemi ile gondereeggiz
    var response = await Dio().post(url, data: FormData.fromMap(requestData));
    print("person-update: ${response.data.toString()}");
  }

  Future<void> deletePerson(int person_id) async{
    print("delete-person_id: ${person_id}");
    var url = "http://kasimadalan.pe.hu/kisiler/delete_kisiler.php";
    //Bu url normalde bize uygumuyor biz sadece burayi gostermek icin kullaniyoruz burasi pratikte claismiyor
    // biz bizm person clasiimiza uygun delete endpoint olusturursak o zaman prtaikte de calisacaktir
    //Bize cevap gelecek ama farkli bir yontemle olacak ama once request ile gondereegimz verilri gondermemiz gerekiyor
    var requestData = {"person_id":person_id};
    //post yontemi ile gondereeggiz
    var response = await Dio().post(url, data: FormData.fromMap(requestData));
    print("person-delete: ${response.data.toString()}");
  }

  Future<List<Person>> search(String searchText) async{
    print("delete-person_id: ${searchText}");
    var url = "http://kasimadalan.pe.hu/kisiler/tum_kisiler_arama.php";
    //Bu url normalde bize uygumuyor biz sadece burayi gostermek icin kullaniyoruz burasi pratikte claismiyor
    // biz bizm person clasiimiza uygun delete endpoint olusturursak o zaman prtaikte de calisacaktir
    //Bize cevap gelecek ama farkli bir yontemle olacak ama once request ile gondereegimz verilri gondermemiz gerekiyor
    var requestData = {"person_name":searchText};
    //post yontemi ile gondereeggiz
    var response = await Dio().post(url, data: FormData.fromMap(requestData));
    return parsePersons(response.data);
  }

  //AMA SIMDILK BIZ INTEGER OLAN DEGERI KALDIRALIM OK
  Future<List<Person>> fetchPersons() async {
    /*
    var personList = <Person>[];
    var person1 =  Person(person_id:"1", person_name: "Ademm", person_tel: "555 111 22 33");
    var person2 =  Person(person_id:"2", person_name: "Zeynep", person_tel: "444 666 888 11");
    var person3 =  Person(person_id:"3", person_name: "Zehra", person_tel: "222 333 999 01");
    personList.add(person1);
    personList.add(person2);
    personList.add(person3);
    return personList;*/
    //persons-endpoint:http://kasimadalan.pe.hu/kisiler/tum_kisiler.php
    //var url = "http://kasimadalan.pe.hu/kisiler/tum_kisiler.php";
    var url = "https://mocki.io/v1/28d8ae56-fdde-4c47-b088-88c3b57daa2c";
    var response = await Dio().get(url);//web servisimiz bu get istegi olduguicin get diyuoruz
    print("response: ${response}");
    //Dio’nun Response objesini yazdırıyor; o JSON gibi görünebilir. Ama sen parse’a response değil,
    //response.data çoğu zaman zaten Map (decode edilmiş)
    //Sen toString() yapınca JSON standardı bozuluyor → json.decode patlıyor
    return parsePersons(response.data);
  }
  /*
  * “Response zaten JSON değil mi?” → Evet ama iki anlamı var
  * JSON kelimesi günlük konuşmada 2 şeyi anlatır:
  * JSON metni (String)
Örn:{"success":1,"persons":[{"person_id":"1"}]}
* Bu sadece yazı (metin).

Decode edilmiş JSON (Map/List)
* {
  "success": 1,
  "persons": [
    {"person_id":"1"}
  ]
}
* Bu artık Dart’ın içinde veri yapısı: Map + List.
* Dio’nun farkı: JSON’u çoğu zaman otomatik decode eder

Sen Dio().get(url) yaptığında Dio genelde şunu yapar:
Sunucudan gelen body JSON metni olsa bile,
Dio bunu okur ve otomatik parse/decode edip sana response.data olarak verir.
Yani senin durumda:
✅ response.data = Map (decode edilmiş JSON)
Bu yüzden response.data.runtimeType genelde:
Map<String, dynamic> (kök JSON object ise)
veya List<dynamic> (kök JSON array ise)
*
* Doğru mantık: 3 katman dönüşüm
Bu dönüşümleri kafana çak:
A) Network katmanı
Sunucudan gelen veri: String (JSON text)
B) Decode katmanı
JSON text → Map/List
Bunu ya Dio yapar ya sen json.decode ile yaparsın
C) Model katmanı
Map/List → Senin class’ların (PersonResponse, Person)
* Senin çalışan akışın (adım adım)
1) Dio isteği
var response = await Dio().get(url);
* 2) Dio response.data’yı verdi
Senin endpoint root’u { ... } olduğu için:
response.data bir Map.
* {
  "persons": [ {..}, {..} ],
  "success": 1
}
* 3) Sen Map’i modele çevirdin
* return PersonResponse.fromJson(response.data).persons;
* 4) PersonResponse.fromJson içi
* var jsonPersons = json["persons"] as List<dynamic>;
var persons = jsonPersons
  .map((e) => Person.fromJson(e as Map<String, dynamic>))
  .toList();
  * Burada olan:
json["persons"] → JSON array → List<dynamic>
map(...) → listedeki her elemanı Person’a çevirir
toList() → iterable’ı gerçek List<Person> yapar
*
* 6) Peki neden parsePersons(dynamic data) yaptık?
Çünkü her zaman aynı kütüphaneyi kullanmayabilirsin.
http paketi: response.body çoğunlukla String
dio paketi: response.data çoğunlukla Map/List
Sen dynamic yapınca fonksiyonun şuna dayanıklı oluyor:
data Map gelirse → direkt fromJson(Map)
data String gelirse → önce json.decode → sonra fromJson(Map)
Yani dynamic burada “kötü” değil; iki farklı client tipini tek yerde desteklemek için pratik.
*
* 7) En temiz profesyonel kural (aklında kalsın)
Eğer elindeki şey String ise:
✅ json.decode(string) yap
Eğer elindeki şey Map/List ise:
✅ decode etme, direkt fromJson yap
❌ toString() ile JSON üretmeye çalışma
*
* 8) Senin final “ideal” kod (Dio için)
Dio kullanıyorsan en kısa doğru yol:
* Future<List<Person>> fetchPersons() async {
  final url = "https://mocki.io/v1/28d8ae56-fdde-4c47-b088-88c3b57daa2c";
  final response = await Dio().get(url);

  final map = response.data as Map<String, dynamic>;
  return PersonResponse.fromJson(map).persons;
}
  * */



  /*
  * Restarted application in 5 264ms.
E/flutter ( 5719): [ERROR:flutter/runtime/dart_vm_initializer.cc(40)] Unhandled Exception: FormatException: Unexpected character (at character 2)
E/flutter ( 5719): {persons: [{person_id: 19306, person_name: Ahmett, person_tel: 00001}, {per...
E/flutter ( 5719):  ^ yaptim ve bu hatayi aldim...
  * */

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
/*
* RESTFUL API ILE CALISMAK!!!!!
* 1.pubspec.yaml da  dependencies altinda flutter seviyesinde dio: yazip pub get diyerek dio nun son versiyonunu yukleriz
pubspec.yaml
* dependencies:
  flutter:
    sdk: flutter
  flutter_bloc:
  dio:
* */