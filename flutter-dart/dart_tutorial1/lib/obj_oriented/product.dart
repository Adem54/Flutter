class Product
{
  String firstName;
  String title;
  double price;

  //Normal constructordir bu constructor..karistirmayalim. named parameters ile..normal constructor dir ama named parameters dir...
  //Named parameters, bir fonksiyon/constructor çağırırken parametreye isim vererek geçmektir.
  //Ancak Named parameter = çağırırken title: ... gibi isim veriyorsun ( {} ile).Dart’ta {} içine yazılan parametreler named parameter olur:
  //Product({required this.title, required this.price});Çağırırken sıraya göre değil, isimle verirsin:Product(title: "PC", price: 100);
  //Named parameter avantaji:Avantajı:Sira karismaz, Okunabilir, Istersek opsiyonel yaparak defaul degerler atayabilriz...yani o zaman required i kaldirmamiz gerekir
  //Product({required this.firstName,required this.title, this.price = 0 dersek price i opsiyonel yapmis oluruz..
  // Bu durumda hem Product(firstName: "Pc", title: "NewPc"); // price default 0 kullanabiilrsin hem de Product(firstName: "Pc", title: "NewPc", price: 5); // price 5 kullanabilrsin
  //Bir parametre opsiyonel olacaksa (verilmezse default kullan diyorsan), o parametrede required olmaz.
  //Şunu yapamazsın (mantıksız/izin yok):Product({required this.price = 0}); // ❌ Çünkü required “mutlaka ver” der, = 0 “vermezsen 0 al” der — çelişir.
  Product({
    required this.firstName,
    required this.title,
    required this.price
  });

  //Named constructor
  //Constructor overloading i dart ta bu yontemle daha farkli sekilde yapiyoruz
  Product.onlyFirstName(String firstName):firstName = firstName, title = "",price=0;
  //Dart’ta sınıf içinde şunu yazdığın anda: Product.onlyFirstName(String firstName) : ...
  //sen aslında Product class’ının “named constructor”ını tanımlamış oluyorsun. Yani:
  //Product(...) → default / generative constructor
  //Product.onlyFirstName(...) → named constructor
  //Product.onlyTitle(...) → named constructor
  //Product.guest() → named constructor
  //Bunlar named constructor dir methd degil, methodlardan farki return type yazılmaz (void falan yok), class adiyla baslar, amaci nesne uretmektir
  //Burda biz istedigmz her ismi vererek named constructor uretebilyoruz...yani Product. ile baslamak sarti ile...Product.guest(),Product.onlyTitle(...),Product.fromJson(Map json),Product.empty()


  //Named constructor
  Product.onlyTitle(String title):title=title, firstName="", price=0;

  //Named constructor
  Product.onlyNameAndTitle(String firstName, String title):this.firstName = firstName,this.title = title, this.price = 0;
}