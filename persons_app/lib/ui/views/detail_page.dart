import 'package:flutter/material.dart';
import 'package:persons_app/data/entity/person.dart';

class DetailPage extends StatefulWidget {
 // String personName;
 // String personNumber;
  Person person;

  DetailPage({required this.person}); //DetailPage({required this.personName, required this.personNumber});


  //const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var tfPersonName = TextEditingController();
  var tfPersonNumber = TextEditingController();

  Future<void> Update(String person_name, String person_number) async {
      print("update-person_name and- person-number: ${person_name} - ${person_number}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("initState!!!");

    // ✅ DetailPage’e gelen veriyi TextField’lara bas..DIKKAT EDELIM DetailPage E  GELEN VERYI BIZ widget. diyerek erisebiliyoruz
    tfPersonName.text = widget.person.person_name;
    tfPersonNumber.text = widget.person.person_tel;
    //✅ Böyle yapınca sayfa açılır açılmaz TextField’lar dolu görünür.
  }
  //TextField’da değişince controller otomatik güncellenir mi? onChange lazım mı?
  //Eğer TextField(controller: tfPersonName, ...) yazdıysan:
  //✅ Evet, kullanıcı yazdıkça tfPersonName.text otomatik güncellenir.
  //Yani butona bastığında şunu almak yeterli:
  //final personName = tfPersonName.text;
  // final personNumber = tfPersonNumber.text;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("PersonDetail")),
      body:Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 50, left: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(controller: tfPersonName,  decoration: const InputDecoration(hintText: "Person name!"),),
                  TextField(controller: tfPersonNumber, decoration: const InputDecoration(hintText: "Person number!"),),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                      onPressed: (){
                        print("tfPersonName: ${tfPersonName.text}");
                        var personName = tfPersonName.text;
                        print("tfPersonName: ${tfPersonNumber.text}");
                        var personNumber = tfPersonNumber.text;
                        Update(personName, personNumber);
                        //
                        final updatedPerson = Person(
                          person_id: widget.person.person_id, // id aynı kalsın
                          person_name: tfPersonName.text,
                          person_tel: tfPersonNumber.text,
                        );
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=> Homepage(personName:personName,personNumber:personNumber)));

                        //push ile degil, de pop ile geldigi yere gonderecegiz ve bu sekiiolde de datayi eklemek icin..
                        //Person person = Person(person_id:1,person_name: personName, person_tel: personNumber);
                        Navigator.pop(context, updatedPerson);//{person: updatedPerson} bu yanlis..
                        //Burda datayi biz burda homepage yani girilen person datasini homepage denki persons listesine gonderiyoruz yani bir nevi geldgimz sayfa olan parent-homepage
                        //reguster use person datasi girilen child screen o zaman child screen den data parent e giderken,
                        // pop ile gondeririz ki homepage deki push ile buraya gelinirken ki navigator icindeki then ile burdan gonderilen data alinabilir kolayca
                        //Iste burayi dogru anlayalim..burda gonderdigmz veri, Homepage Navagtor.push ile gonderilen yerde then icindeki value uzerinden gonderilyor unutmyalim
                        //Ordaki value yi yazdiridgmzda su sekilde oraya gitmis oluyor:  you come back to homepage-value: {name: Zeynep Erbas, phone: 450343434}
                      },
                      child: Text("Update", style: TextStyle(color:Colors.white),))
                ],
              ),
            ),
      )
    );
  }
}
/*
************  HOMEPAGE A DATA GERI GONDERIRKEN GONDERME STRUCTURINA GORE HOMEPAGE DE ALINACAKTIR!!!   ********************

Data update edilip gonderilirken, veya data girince bu data niin tekrar home page geldigi yere gonderilmesi,
 gonderilme structuruna gore homepage de alinmasi gerekiyor bu onemli bir seydir..
 * 1) Navigator.pop(context, {"name": ..., "phone": ...}) → Map döndürür
 * Bu yazdığın şey bir Map literal:
 * {"name": personName, "phone": personNumber}
 * Bu yüzden Homepage tarafında şöyle yakalarsın:
 * .then((value) {
  if (value != null && value is Map<String, String>) {
    // value["name"], value["phone"] var
  }
});

* ✅ Bu yöntem “hızlı ve basit”tir.
Ama dezavantajı: her yerde "name", "phone" key’lerini yazarsın, typo olursa hata çıkar
En temel tip örnekleri
int → tam sayı: 5, 42
double → ondalıklı: 3.14
String → yazı: "Ahmet"
bool → true/false
List → liste: [1,2,3]
Map → key-value sözlüğü: {"name":"Ahmet"}
Person → senin yazdığın class (özel tip)

*

* 2) Navigator.pop(context, updatedPerson) → Person döndürür
Burada bir class instance dönüyorsun:
* Person updatedPerson = Person(...);
Navigator.pop(context, updatedPerson);
Homepage tarafında şöyle yakalarsın:
* .then((value) {
  if (value is Person) {
    // value.person_name, value.person_tel
  }
});

✅ Bu yöntem “daha profesyonel / daha güvenli”dir.
Çünkü alan adları sabit: person_name, person_tel vs.
Yanlış key yazma derdin yok.

* 3) “Map mantığında Person gibi döndürmek” ne demek?
Sen şunu demek istiyorsun:
“Person döndürmek yerine Map döndüreyim ama Map’in içinde person_id, person_name, person_tel olsun.”
Evet, yapılır. Mesela:
DetailPage (pop ile Map dön)

Navigator.pop(context, {
  "person_id": widget.person.person_id.toString(),
  "person_name": tfPersonName.text,
  "person_tel": tfPersonNumber.text,
});
Homepage (then ile Map yakala)
.then((value) {
  if (value is Map<String, String>) {
    setState(() {
      people[i] = {
        "name": value["person_name"]!,
        "phone": value["person_tel"]!,
      };
    });
  }
});
Burada dikkat: Map<String, String> diyorsan person_id da String olmalı.
İstersen Map<String, dynamic> yaparsın, o zaman id int kalabilir:
Navigator.pop(context, {
  "person_id": widget.person.person_id,  // int
  "person_name": tfPersonName.text,      // String
  "person_tel": tfPersonNumber.text,     // String
});
Ve Homepage’de:
* if (value is Map<String, dynamic>) { ... }

4) Hangisini seçmeliyim?
Senin projede en doğru seçim:

✅ Person class’ın varsa → Person döndür.

Çünkü:
tip güvenli
daha az hata
kod büyüyünce daha temiz
Map, genelde:
hızlı prototip
JSON / API’den gelen raw data
class yazmak istemediğin basit örnekler
* */