import 'package:persons_app/data/entity/person.dart';

class PersonResponse {
  List<Person> persons;
  int success;

  PersonResponse({required this.persons, required this.success});

//Json parse kisminda boyle manuel bir fonsk ihityacimz var dartta kendisi endpointten gelen responsu
// otomatik yapmadigi iicn boyle bir manuel fonsk ile yapariz o isi
  factory PersonResponse.fromJson(Map<String, dynamic> json)
  {
    print("json: ${json}");
    var jsonPersons = json["persons"] as List;//Dikkat burasi List<Person> degil sadece List
    //Burda json array geliyor yani icerisinde json objeleri bulunduran json array ok..
    // bunun tipi Person diyemeyiz henuz buraya dikkat
    int success = json["success"] as int;

    var persons = jsonPersons.map((jsonPerson)=>Person.fromJson(jsonPerson)).toList();
    return PersonResponse(persons: persons, success: success);
  }
}
/*
 var jsonPersons = json["persons"] as List;
* Tam burada olan şey şu: json["persons"] sana JSON array getiriyor.
*  JSON array Dart tarafında List olarak gelir ama içindeki elemanlar Person değil,
*  genelde Map<String, dynamic> (yani “json object”) olur.

var persons = jsonPersons.map((jsonPerson)=>Person.fromJson(jsonPerson)).toList();
3 adım yapıyor:

1) jsonPersons nedir?
var jsonPersons = json["persons"] as List;

Bu, örneğin şu JSON’u temsil ediyor:
"persons": [
  { "person_id": "1", "person_name": "Ali", "person_tel": "555" },
  { "person_id": "2", "person_name": "Ayşe", "person_tel": "444" }
]
Dart’ta jsonPersons ≈ List<dynamic> gibidir.
İçindeki her eleman: dynamic (ama gerçekte Map).
2) map(...) ne yapıyor?

map bir listeyi başka bir listeye dönüştürmek için kullanılır.
Girdi: List<dynamic> (içinde json objeleri var)
Çıktı: Iterable<Person> (Person’lara dönüştürülmüş)
Şu kısmın anlamı:
jsonPersons.map((jsonPerson) => Person.fromJson(jsonPerson))
jsonPerson = listedeki tek bir eleman (1 JSON object)
Person.fromJson(jsonPerson) = o JSON object’i Person nesnesine çevir
Yani her eleman tek tek Person’a çevriliyor.
3) Peki toList() neden var?

Çünkü map List döndürmez, Iterable döndürür.
map(...) sonucu: Iterable<Person>
Senin alanın: List<Person> persons;
Bu yüzden en sona:
.toList()

ekleyip Iterable<Person> → List<Person> yapıyorsun.

✅ Evet, en sonda listeye çevirmek gerekiyor, çünkü PersonResponse.persons tipi List<Person>.
* */