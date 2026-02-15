class Product {
  int id;
  String title;
  String description;
  double price;
  String image;

  Product({required this.id, required this.title, required this.description, required this.price, required this.image});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"] as int,
      title: json["title"] as String,
      description: json["description"] as String,
      price: (json["price"] as num).toDouble(),//price bazen int gibi gelebilir, o yüzden (num).toDouble() güvenli.
      image: json["image"] as String,
    );
  }
  /*
  //factory Product.fromJson(Map<String, dynamic> json) şu demek:
// “Elimde JSON (Map) var, bundan bir Product nesnesi üretmek için özel bir constructor yazıyorum.”
1) JSON Flutter’a nasıl geliyor?
API’den gelen şey aslında böyle bir veri:
{
  "id": 1,
  "title": "T-shirt",
  "price": 12.5,
  "image": "https://..."
}
Dart bunu decode edince genelde şuna dönüşür:Map<String, dynamic> json = {
  "id": 1,
  "title": "T-shirt",
  "price": 12.5,
  "image": "https://..."
};
Yani: String key’ler + karışık tip value’lar(dynamic)
2) Peki biz niye fromJson istiyoruz?
Çünkü UI’da Map ile uğraşmak istemiyoruz:
❌ Böyle yazmak yorucu ve hataya açık:Text(json["title"])
Text("${json["price"]}")
✅ Biz şunu istiyoruz:
Product p = ...
Text(p.title)
Text("${p.price}")
İşte fromJson bu dönüşümü yapar: Map → Product
3) factory ne demek?Normal constructor şudur:Product(...);
factory ise “constructor gibi görünür ama” şunu yapabilirsin:
Her zaman yeni obje üretmek zorunda değildir
İsterse var olan bir objeyi döndürebilir
İsterse farklı bir alt tür döndürebilir
İçinde dönüşüm/parse mantığı yazmak için çok uygundur
Ama senin kullanımında en basit anlamı:
“JSON’dan Product üretmek için özel kurallı constructor.”
4) Burada ne oluyor?
factory Product.fromJson(Map<String, dynamic> json) {
  return Product(
    id: json["id"] as int,
    title: json["title"] as String,
    description: json["description"] as String,
    price: (json["price"] as num).toDouble(),
    image: json["image"] as String,
  );
}

json["id"] Map’ten “id”yi alır (dynamic gelir)
as int ile “bunun int olduğunu varsayıyorum” dersin
price için num→double yaparsın (çünkü API bazen 12 bazen 12.5 gönderebilir)
Sonuç: elinde artık tam tipli Product nesnesi olur.

5) “factory olmasa da olur muydu?”Evet, aynı işi normal named constructor ile de yapabilirsin:
Product.fromJson(Map<String, dynamic> json)
  : id = json["id"] as int,
    title = json["title"] as String,
    ...
Ama factory özellikle şu yüzden çok kullanılır:
parse sırasında kontrol/şart koymak kolay
gerekirse return ile farklı şey döndürebilirsin

Notluk tek cümle
Product.fromJson = JSON Map’ini alıp, uygulamada rahat kullanacağın Product objesine çeviren “dönüştürücü constructor”.

*/

}