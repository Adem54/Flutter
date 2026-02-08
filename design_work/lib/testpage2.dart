import 'package:flutter/material.dart';
//simdi biz class ismini yazariz kendimiz...Homepage ismini vererek...Homepage buyuk olacak..
class Testpage2 extends StatefulWidget{
  const Testpage2({super.key});
  //StatefullWidget in son 2 harfi silip tekrar yazarsak oneriler getirir material dart i seceriz..
  // yuklariya material dart i import eder ve tum hatalar silinir
  @override
  State<Testpage2> createState() => _TestState2();
}
//Ustteki Homepage class yapisi alttaki _HomepageState yapisini temsil ediyor,
// ama biz Homepage ile ilgli tasarimlari _HomepageState deki build mehtodu icerisinde yapacagiz
//_State yazan yere de _HomepageState yazacagz

//Dikkat edelim _HomepageState zaten Homepage i aliyor State icinde..
// ve bu _HomePageState e Homepage ozelligini zaten aktariyor bu sekilde ve
// biz zaten burda _HomepageState icinde Homepage i aslinda degistirmis olacagiz..build icerisinde
class _TestState2 extends State<Testpage2> {
  @override
  Widget build(BuildContext context) {
    //Degisikliklerimiz i burda yapacagiz...
    //return const Placeholder();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("2 Kolon Örneği", style: TextStyle(fontSize: 24)),
      ),
      body: SafeArea(
        child: Row(
          children: [
            // 1. KOLON (sol panel) - background color
            Expanded(
              flex: 1,
              child: Container(
                color: const Color(0xFFE3F2FD), // açık mavi arka plan
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Sol Kolon", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: 12),
                    Text("• Menü", style: TextStyle(fontSize: 18)),
                    SizedBox(height: 8),
                    Text("• Kategoriler", style: TextStyle(fontSize: 18)),
                    SizedBox(height: 8),
                    Text("• Ayarlar", style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),

            // 2. KOLON (sağ panel) - farklı içerik
            Expanded(
              flex: 2,
              child: Container(
                color: const Color(0xFFFFF3E0), // açık turuncu arka plan
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Sağ Kolon", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),

                    // sağ kolonda 1 satır: 1-2-3
                    Row(
                      children: const [
                        Chip(label: Text("1")),
                        SizedBox(width: 8),
                        Chip(label: Text("2")),
                        SizedBox(width: 8),
                        Chip(label: Text("3")),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // sağ kolonda 2 satır: 4-5
                    Row(
                      children: const [
                        Chip(label: Text("4")),
                        SizedBox(width: 8),
                        Chip(label: Text("5")),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // sağ kolonda 3. satır: tek parça (6)
                    const Chip(label: Text("6")),

                    const Spacer(),

                    // en altta bir buton
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: null,
                        child: const Text("Örnek Buton"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/*
SafeArea ne yapar?

Ekranın çentik (notch), status bar, gesture bar gibi alanlarına girmemeni sağlar.

İçeriği otomatik olarak biraz içeri iter.

📱 Özellikle:

iPhone çentikleri

Android navigation bar

Neden Center değil?

Önceki örnekte:

İçeriği ortalamak istiyorduk → Center

Burada:

Tüm ekranı kaplayan panel layout yapıyoruz

Ortalamak istemiyoruz
→ SafeArea daha mantıklı

Center = hizalama için
SafeArea = güvenli alan için

2️⃣ Row neden en dışta?
child: Row(
  children: [

  Bu şunu söylüyor:

“Ben ekranı yan yana parçalara böleceğim”

Yani:

Solda bir panel

Sağda bir panel

💡 Bu satır layout’un ana kararıdır.

Expanded nedir?
Expanded(
  flex: 1,
  child: Container(...)
),
Expanded(
  flex: 2,
  child: Container(...)
),

Expanded ne yapar?

Row veya Column içindeki boş alanı paylaştırır.

Burada:

Toplam alan = 1 + 2 = 3 parça

Sol kolon → 1/3

Sağ kolon → 2/3

| SOL |     SAĞ      |
| 1x  |      2x      |

❗ Expanded tek başına kullanılmaz
→ mutlaka Row veya Column içinde olur

Container neden var?
Container(
  color: ...
  padding: ...
  child: Column(...)
)


Container burada:

Arka plan rengi verir

İç boşluk (padding) verir

Görsel bir “panel” hissi oluşturur

Container = kutu

5️⃣ Kolonların içinde neden Column var?
child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [...]
)


Çünkü:

Panel içindeki içerikler alt alta

Menü, yazılar, satırlar vs.

Yani:

Panel = dikey içerik → Column

Column içinde neden Row’lar var?
Row(
  children: const [
    Chip(label: Text("1")),
    ...
  ],
),
Çünkü:

Aynı satırda birden fazla parça var

1–2–3 yan yana

4–5 yan yana

Bu tam olarak senin dediğin şey 👇

“kolon içinde row”

Spacer() ne yapıyor?
const Spacer(),


Column içindeki boş alanı yukarı iter

Altındaki butonu en alta yapıştırır

Bunu şöyle düşünebilirsin:

“Araya esnek boşluk koy”

Genel akış (en önemli kısım)
Ne oluyor burada?

SafeArea
 └── Row (ekranı yan yana böl)
     ├── Expanded (1x)
     │    └── Container
     │         └── Column (dikey içerik)
     └── Expanded (2x)
          └── Container
               └── Column
                    ├── Row (1-2-3)
                    ├── Row (4-5)
                    └── Chip (6)

                    Tek cümlelik özet (bunu ezberle)

Flutter’da layout; önce ana yönü seçersin (Row/Column),
sonra her panel kendi içinde tekrar Row/Column kullanır. Expanded alanı paylaştırır, SafeArea ekranın güvenli alanını korur.

Expanded row alanlarini paylasitrmak icin mi vardir...sadece..yoksa column icinde expanded kullanildigi durujmlar olur mu
❌ Expanded sadece Row için değildir
✅ Expanded, Row ve Column içinde çalışır

Ama nasıl çalıştığı, içinde bulunduğu yapıya göre değişir.

ÇOK İYİ SORU 🔥
Kısa cevapla başlayayım, sonra netleştireyim:

❌ Expanded sadece Row için değildir
✅ Expanded, Row ve Column içinde çalışır

Ama nasıl çalıştığı, içinde bulunduğu yapıya göre değişir.

Expanded ne yapar? (temel tanım)

Expanded, bulunduğu ana eksendeki (main axis) boş alanı paylaşır.

Row → yatay eksen

Column → dikey eksen

1️⃣ Row içinde Expanded
Row(
  children: [
    Expanded(child: A),
    Expanded(child: B),
  ],
)


➡️ Ekranı yatayda böler
➡️ Genişliği paylaştırır

|   A   |   B   |


Flex kullanırsan:

Expanded(flex: 1, child: A),
Expanded(flex: 2, child: B),

|  A  |     B     |

2️⃣ Column içinde Expanded
Column(
  children: [
    Expanded(child: A),
    Expanded(child: B),
  ],
)


➡️ Bu sefer yüksekliği paylaştırır

+-------+
|   A   |
+-------+
|   B   |
+-------+


Yani:

Column → yukarıdan aşağı alan paylaşımı

3️⃣ Çok kritik kural ❗

Expanded sadece Row, Column veya Flex içinde çalışır

❌ Şu yanlış:

Center(
  child: Expanded(child: A), // HATA
)


Çünkü:

Center bir Flex değildir

4️⃣ Column içinde Expanded ne zaman kullanılır?
Örnek 1 – Alt butonu sabitlemek
Column(
  children: [
    Text("Başlık"),
    Expanded(child: ListView(...)),
    ElevatedButton(...)
  ],
)

➡️ Liste tüm boş alanı kaplar
➡️ Buton altta kalır

Örnek 2 – Ekranı dikey bölmek
Column(
  children: [
    Expanded(flex: 1, child: Header()),
    Expanded(flex: 3, child: Content()),
  ],
)

5️⃣ Expanded vs SizedBox
Amaç	Ne kullanılır
Esnek alan paylaşımı	Expanded
Sabit boşluk	SizedBox
Minimum alan + esneklik	Flexible
🧠 Zihinsel model (altın kural)

Expanded = “Ana eksende kalan boşluğu bana ver”
Ana eksen = Row → yatay
Ana eksen = Column → dikey
Kısa cevap (senin soruna birebir)
Expanded sadece row alanlarını paylaşmak için değildir.
Column içinde de kullanılır ve o zaman yüksekliği paylaştırır
* */