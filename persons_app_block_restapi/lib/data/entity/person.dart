class Person {
  String person_id;
  String person_name;
  String person_tel;

  Person({ required this.person_id, required this.person_name, required this.person_tel});


  //Dart direk otomatk olarak parse etmiyor json u bizim manuel bir fonks yazmamiz gerekiyor endtpointin response olarak
  // gelen json i parse edeblmek icin
  //Bize parantezle birlkte json gonderilyor Map<key,value> json icindeki key-value yu temsil ediiyor,
  // key kismi her turlu string olacak person_id,person_name,person_tel ama bunlarin alacagi degerler
  // dinamik degisebilir string,int,bool..
  factory Person.fromJson(Map<String, dynamic> json)
  {
    return Person(
        person_id: json["person_id"] as String,
        person_name: json["person_name"] as String,
        person_tel: json["person_tel"] as String
    );
  }
}
//Bunlari alttan cizgi ile ayridk veritabani kolonlari ile ayni olmasi icin
//Burasi entity class i yani veritabanimizdaki tablolara karsilk gelen class lari temsil ediyor

/*
* Constructor (kurucu) nedir?
Önce temel:
Bir class’tan nesne üretirken çalışan şey:
* Ornegin:var p = Person("1","Adem","46456546");
*
* Problem: Tek constructor bazen yetmez
* Gerçek hayatta bir nesneyi farklı şekillerde oluşturmak isteriz:
API’den (JSON)
Boş haliyle
Sadece id ile
Full data ile
* C#’ta ne yapıyorsun?
* public Person(string name) { }
public Person(int id) { }
public Person(string name, string tel) { }
* Dart’ta çözüm: Named Constructor
* Dart diyor ki:
“Aynı constructor’ı overload etmek yerine, isim verelim”
* class Person {
  String name;

  // normal constructor
  Person(this.name);

  // named constructor
  Person.fromJson(Map<String, dynamic> json)
      : name = json["name"];

  // başka bir named constructor
  Person.empty() : name = "";
}
* Kullanım:
* var p1 = Person("Ali");          // normal
var p2 = Person.fromJson(json);  // named
var p3 = Person.empty();         // named
* Mantık:

👉 Named constructor = “farklı amaçlar için farklı giriş noktaları”
* yani named constructor da ben istedigim ismi verebilme ozgurlugum mu var
*  ayni javascriptte prototyping yaptimgz gibi... Person. deyip
* Evet, istediğin ismi verebilirsin
❗ Ama bu JavaScript prototype gibi dinamik bir şey değil

* 1) Evet, isim tamamen sana ait
* Şunu yazabilirsin:
* class Person {
  String name;

  Person(this.name);

  Person.fromJson(Map<String, dynamic> json)
      : name = json["name"];

  Person.fromXml(String xml)
      : name = "xml";

  Person.abiBuNey(String x)
      : name = x;
}
* Kullanım:
* Person.fromJson(...)
Person.fromXml(...)
Person.abiBuNey(...)
*
* Yani:
Person. dedikten sonra gelen isim = tamamen senin verdiğin isim
* Ama bu JavaScript gibi değil ❗
* JavaScript’te:
* Person.prototype.fromJson = function() {}
* Runtime’da (çalışırken) ekliyorsun
*
* Dart’ta:
👉 Her şey compile-time (derleme zamanı)
Sonradan ekleyemezsin
Dinamik genişletme yok
Class tanımı sabittir
*
* 3) Aslında bu neye daha çok benziyor?
* C#’ta şuna benzer:
* public static Person FromJson(...) { }
public static Person FromXml(...) { }
* Ama Dart farkı:
👉 Bu method değil, constructor gibi davranıyor
* 4) Neden Person. ile çağrılıyor?
Çünkü:
Bunlar class seviyesinde constructor’lar
instance değil
* Person.fromJson(...)  // doğru
* ❌ Şu yanlış:
* var p = Person("Ali");
p.fromJson(...) // olmaz
*
* 5) En net tanım
👉 Named constructor:
Class içinde, nesne oluşturmak için tanımlanmış, ismi senin verdiğin alternatif constructor’lardır
* Tek cümlelik netlik

✔ İsim → tamamen senin
❌ Ama sistem → JS gibi dinamik değil
✔ Daha çok → C# static method gibi
✔ Ama → constructor gibi çalışıyor
*
* factory nedir?
* Burayı iyi kavra — en kritik nokta 💡
* Normal constructor ne yapar?
👉 HER ZAMAN yeni nesne üretir
* var a = Person("Ali");
var b = Person("Ali");
print(a == b); // false (farklı nesneler)
* Factory constructor ne yapar?
👉 Yeni nesne üretmek zorunda değildir
* factory Person.fromJson(...) {
  return Person(...);
}
* Ama isterse:
Aynı nesneyi döndürebilir
Cache kullanabilir
Başka class döndürebilir
*
* ! nasil baska class  , baska instance mi diyecektin yoksa yani Person dan baska bir class mi dondurebilir?
* Evet, gerçekten başka bir class döndürebilir
❗ Ama şart şu: Dönen şey, beklenen tipe uyumlu olmalı
* 1) Nasıl yani “başka class” döndürmek?
Dart’ta bir factory constructor şunu diyebilir:
“Ben Person gibi görünüyorum ama aslında sana farklı bir alt sınıf vereceğim”
*
* Önce tek cümle:
Factory = “Sen Person istiyorsun, ben sana uygun olanı veririm.”
* abstract class Person {
  String name;

  Person(this.name);

  factory Person.fromJson(Map<String, dynamic> json) {
    if (json["type"] == "student") {
      return Student(json["name"]);
    } else {
      return Teacher(json["name"]);
    }
  }
}

class Student extends Person {
  Student(String name) : super(name);
}

class Teacher extends Person {
  Teacher(String name) : super(name);
}
* Kullanım:
* var p = Person.fromJson({
  "type": "student",
  "name": "Ali"
});
* Ne oldu şimdi?

Sen dedin ki:

👉 “Bana bir Person ver”

Ama aslında gelen:

👉 Student
* Bunu gözünde şöyle canlandır:
Sen:

“Bana bir Person ver”

Factory:

“Tamam… bakıyorum…
Bu bir student → sana Student veriyorum”
* Kritik nokta
Person p = Person.fromJson(...)

👉 Senin değişkenin tipi: Person
👉 Ama içindeki gerçek nesne: Student
* Neden bu sorun değil
Çünkü:
👉 Student zaten Person
(inheritance sayesinde)
* ❗ Neden bu normal constructor ile olmaz?
* Normal constructor:
* Person(...)
* HER ZAMAN:
sadece Person üretir ❌
* Ama factory:
* factory Person(...)
* Diyebilir ki:
Student ver
Teacher ver
eski nesneyi ver
hiç üretme
*
* NET ÖZET

Inheritance:
👉 Sen seçersin → Student()

Factory:
👉 Sistem seçer → Person.fromJson()

💡 Son çivi

Factory constructor, “neyi oluşturacağını gizleyen akıllı constructor”dır
* ama parametrye gonderdigin deger ile belirlenioir neticeede degil mi
*  sen nerde nneye ihtiyacin var ise ona gore kullanbiliyorsun
* Evet, çoğu zaman karar parametreye göre verilir
* Person.fromJson(json)
* İçeride:
* if (json["type"] == "student") {
  return Student(...);
}
* Yani:
Evet → gelen veriye göre karar veriyor
* ❗ Ama önemli nokta şu:
👉 Kararı SEN değil, factory veriyor
* Sen sadece:Person.fromJson(json)
* dersin
Ama şunu DEMEZSin:
* Student.fromJson(json)
Teacher.fromJson(json)
* “Ben sadece veriyi veriyorum, hangi tipe ihtiyacım olduğunu düşünmek zorunda değilim —
* factory benim yerime karar veriyor”
* Bu neden önemli?
Çünkü büyük projede:
5 farklı subtype olabilir
API değişebilir
yeni tipler eklenebilir
Ama senin kodun değişmez:
* var p = Person.fromJson(json);
👉 Hep aynı kalır
* Çok net karşılaştırma
❌ Factory yoksa:
* if (json["type"] == "student") {
  return Student.fromJson(json);
} else {
  return Teacher.fromJson(json);
}
* 👉 Bu kontrol HER YERDE yazılır
* ✅ Factory varsa:
* var p = Person.fromJson(json);
* Temiz, merkezi, güvenli
* 🔚 SON NETLİK

✔ Evet → karar çoğu zaman parametreye bağlı
❗ Ama → kontrol sende değil, class’ın içinde

* Gerçek hayatta neden kullanılır?
* API parsing (en önemli kullanım)
* factory Person.fromJson(Map<String, dynamic> json) {
  switch (json["type"]) {
    case "student":
      return Student.fromJson(json);
    case "teacher":
      return Teacher.fromJson(json);
    default:
      throw Exception("Unknown type");
  }
}
* Sen sadece:
* var p = Person.fromJson(json);
*
* Inheritance tek başına bunu yapamaz
* Şunu yapamazsın:Person.fromJson(json); // otomatik karar versin
* Çünkü:
constructor dışarıdan çağrılır
kendi içinde “hangi class?” kararını vermez
* Inheritance:

👉 “Ben hangi class’ı kullanacağımı biliyorum”

Factory:

👉 “Ben bilmiyorum, class kendi karar versin”
* Tek cümlelik final

Inheritance “tip uyumu” sağlar,
factory ise “hangi tipin oluşturulacağını seçme mekanizmasıdır”.
* */