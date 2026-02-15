import 'package:flutter/material.dart';
import 'package:products_app/data/entity/product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:products_app/ui/views/product_detail.dart';


class Products3 extends StatefulWidget {
  const Products3({super.key});

  @override
  State<Products3> createState() => _ProductsState3();
}

class _ProductsState3 extends State<Products3> {

  late Future<List<Product>> productFuture;

Future<List<Product>> fetchProducts() async{
  final uri = Uri.parse("https://fakestoreapi.com/products");
  final res = await http.get(uri);
  //http yi gidip pubspec.yaml da flutter: sdk:flutter altinda flutter: in hizasinda  http: ^1.2.2 i yazdk ve get diye bastim sayfa ustunde,
  // sonra burdaki islemde http alti cizili hata verdi ve  android studio yu kapatip tekrar actik hata duzelmedi,
  //sonra Dosyanın en üstüne doğru import’u ekledin mi?import 'package:http/http.dart' as http; bu importu ekleyince hata kayboldu
  //Yine hata glmeye devam ederse import tamam, andorid studio acilip kapatildi tamam o zaman..pubspec.yaml’da dependency doğru yerde ve doğru girintide mi?
  //Sunlar cok yapiilan hatalar:http: satırını flutter: ile aynı hizada yazmamak,dev_dependencies altına koymak,tab/bozuk girinti
  if (res.statusCode != 200) {
    throw Exception("API error: ${res.statusCode}");
  }
  final List data = jsonDecode(res.body) as List;
  return data.map((e)=>Product.fromJson(e as Map<String, dynamic>)).toList();
}
  late Future<List<Product>> productFuture2;
  List<Product> myProducts = [];
  Future<List<Product>> loadProducts() async {
    var productLists = <Product>[];
    var u1 = Product(id: 1 , title: "Macbook Pro 14", image : "bilgisayar.png",price: 43000, description: "");
    var u2 = Product(id: 2 , title: "Rayban Club Master", image : "gozluk.png",price: 2500, description: "");
    var u3 = Product(id: 3 , title: "Sony ZX Series", image : "kulaklik.png",price: 40000, description: "");
    var u4 = Product(id: 4 , title: "Gio Armani", image : "parfum.png",price: 2000, description: "");
    var u5 = Product(id: 5 , title: "Casio X Series", image : "saat.png",price: 8000, description: "");
    var u6 = Product(id: 6 , title: "Dyson V8", image : "supurge.png",price: 18000, description: "");
    var u7 = Product(id: 7 , title: "IPhone 13", image : "telefon.png",price: 32000, description: "");
    productLists.add(u1);
    productLists.add(u2);
    productLists.add(u3);
    productLists.add(u4);
    productLists.add(u5);
    productLists.add(u6);
    productLists.add(u7);
    return productLists;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //https://fakestoreapi.com/products
    //Burda neden await ile cagirmiyoruz..bu onemli..bunu anlayalim..
    //Neden await kullanmıyoruz?Çünkü fetchProducts() zaten Future döndürüyor ve FutureBuilder bu Future’ı bekleyip UI’ı yönetiyor
    //Yani şunu yapıyoruz:productsFuture = fetchProducts();Bu satır “isteği başlatır” ve Future’ı saklar.beklerken loading.gelince liste..hata olursa error
    //Dart/Flutter’da initState() metodunun imzası sabittir:@override void initState()..Bunu async yapamazsın (yapsan bile override bozulur / tavsiye edilmez).
    productFuture = fetchProducts();//1 kere invoike et burda
    print("productFuture: ${productFuture}");
    //print(productFuture) yazdirirsan sana “Instance of Future<List<Product>>” yazar çünkü o daha data değil, data’nın geleceği bir “Future”.
    //Senin görmek istediğin şey Future’ın içindeki gerçek liste. Onu 2 şekilde görürsün:
    //FutureBuilder içinde print (en doğru yer)
    productFuture2 = loadProducts().then((list){
      myProducts = list;
      //print("myProducts: ${myProducts}");
      for(var i=0; i<myProducts.length; i++)
        {
          print("product-title: ${myProducts[i].title}");
        }
      return list;
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products", style:TextStyle(fontSize: 16)),),
      body:FutureBuilder<List<Product>>(
      //  future:productFuture,
       future:loadProducts(),//buraya direk methodu da cagirabilirz async, olan
          // ya da onu initState icinde bir Future<List<Product>> a aktraip productFuture gibi bir degeri de verebilirz buraya
        builder:(context, snapshot){//The widget is a potantial non-nullable type...yani burda return etmemiz gerekiyor herturlu null hata verir widgetda
          if(snapshot.connectionState == ConnectionState.waiting)
            {
             // return const Center(child:CircularProgressIndicator());
              // return const LinearProgressIndicator();
              return const Center(
                  child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 32, width: 32, child: CircularProgressIndicator(strokeWidth: 3)),
                    SizedBox(height: 12),
                    Text("Loading products..."),
                  ],
                ),
              );
            }

          if(snapshot.hasError){
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          //Dikkat edelim...biz fetch islemi ile future<List<Prouduct>> type inda aliriz intial icerisinde..
          // ama asil datayi iste burda FutureBuilder ile aliriz..
          final products = snapshot.data ?? [];
          print("products-length: ${products.length}");
          if(products.isNotEmpty){
            print("firsttitle: ${products.first.title}");
          }

          //We can use here productList here or, we can just use snapshot.data,
          // but whern we need to delete or update we must apply both delete,or update
          // request to api and we must apply delete or update to the local productList..
          // not the list that comes from snapshot.data......
          if(snapshot.hasData){
            return ListView.builder(
             // itemCount: products.length,
              itemCount: myProducts.length,//null olma durumu olursa myProducts!.lenght yapariz
              itemBuilder: (context,index){
                //final product = products[index];
                var product = myProducts[index];
                //ListTile bu işin “hazır layout sihirbazı”. Senin Row/Column ile kurduğun düzenin hazır paketlenmiş hali gibi düşünebilirsin.
                //ListTile = “Liste satırı” için hazır bir şablon.
                //leading ile ayni satirda en sola koyacagin i getirirsin, title-subtitle title ustte subtitlte ise bir altta
                // indent-bosluk birarak biraz daha icerde gelir, trailign de ayni satir da en sagda..demek
                //Yani Row gibi ama daha düzenli, otomatik padding/hizalama veriyor.
                //Image.network nedir?İnternetteki bir görsel URL’sini alır ve gösterir.Image.network(product.image).
                // .BoxFit.cover çok kullanılır çünkü:resim bozulmaz..kare alan dolu görünür..taşan yerler kırpılır
                //Satırın sağ tarafındaki alan.
                //“Buna tıklarsan detay sayfası var.”
                //Neden Row gibi aynı satıra yerleşti?Çünkü ListTile aslında arka planda “kendi Row/Column düzenini” kuruyor:
                //Senin tek tek Expanded/Row/Column uğraşmana gerek kalmadan.
                //ListTile’ın kendi onTap’i var. GestureDetector’a bile gerek kalmaz:
                return GestureDetector(
                  onTap:(){
                    print("tapped...Product-detail!!!!!!");

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(product:product)));
                    //Buraya tiklayinca ...navigator calisti ama boylede bir console a mesaj geldi zaten diger sayfaya gecmesi biraz zaman aldi..
                    //I/Choreographer(19877): Skipped 96 frames!  The application may be doing too much work on its main thread.
                    // D/WindowOnBackDispatcher(19877): setTopOnBackInvokedCallback (unwrapped): io.flutter.embedding.android.FlutterActivity$1@f12badd
                    //Bu su demek:UI thread (main thread) o an çok meşguldü, 96 frame çizilemedi → kısa süreli takılma / kasma.
                    //En sık nedenleri (senin kod bağlamında):Image.network(...) ile çok resim aynı anda yüklenmesi (özellikle liste içinde)
                    //debug modda daha fazla kasma olması (release’te azalır)debug modda daha fazla kasma olması (release’te azalır)
                    //Ne yapabilirsin:
                    // Resme cacheWidth/cacheHeight ver (daha küçük decode etsin):cacheWidth: 80,cacheHeight: 80,...
                    // ListView.builder kullan (zaten kullanıyorsun muhtemelen)
                    //setTopOnBackInvokedCallback ..bu ne?Bu Android’in geri tuşu/back callback logu. Flutter/Android embedding log’u.Genelde zararsız.
                  },
                  child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        //   Image.network(product.image, width: 80,height: 80, fit:BoxFit.cover),
                            //Bestpractise image i biz width-height ile boytularini sinirlandirmak istiyoruz bunun icinde SizedBox kullaniriz
                            SizedBox(width:128, height: 128, child: Image.asset("images/${product.image}")),
                            //Resim ile yandaki urun title,price ve buton arasinda bosluk birakmak istiyrouz..bunuda SizedBox ile verebilirz
                            SizedBox(width: 40,),
                            //Resimden sonraki yer ekranin sag tarafinin tamamen kaplamasi icin Expanded yapalim..Bu tasma problemini cozmek icin...
                            //Expanded → Row’daki Column “kalan alan kadar” genişlesin, ekrandan taşmasın.
                            //“Expanded olmadan Column zaten boşluğu kaplamıyor mu?”Hayır, işin püf noktası bu.
                            //Row’un kuralı:Row içindeki çocuklar varsayılan olarak “kendi doğal boyutları” kadar yer kaplar.
                            //Yani sen Expanded koymadan şöyleyken:[Image(40px)] [Column(başlık ne kadar uzunsa o kadar)]
                            //Column “kalan boşluğu kaplayayım” demez; tam tersine:içindeki en geniş child (mesela uzun title veya geniş buton)
                            // ne kadar istiyorsa o kadar büyür,bu da Row’un ekranı aşmasına sebep olur → overflow
                            //Expanded ne yapıyor?Row’a şunu dedirtiyor:“Bu Column kalan alanın sınırları içinde yaşasın.
                            // ”Yani Column artık sınırsız büyüyemez, ekrana göre sınırlanır. Bu sayede taşma kesilir.
                            //“Expanded yerine SizedBox ile yapsak olmaz mı?Kısmen olur ama aynı şey değil.SizedBox(width: X) = Sabit boşluk.Ekran büyür/küçülür ama o boşluk hep X kalır.
                            // ”Expanded = Oransal/esnek boşluk,Ekran büyürse boşluk büyür, küçülürse boşluk küçülür.Yani “ekrana göre % gibi davranır”.
                            //Senin istediğin “kalan alanın bir kısmı boş kalsın” ise Expanded daha doğru, çünkü responsive.
                            //“Peki taşmayı engellemek için Expanded yerine SizedBox kullanabilir miydik?”
                            //Taşmanın ana sebebi şu:Column’un genişliği sınırsız büyüyor.Bunu sabit genişlik vererek de kontrol edebilirsin, mesela:
                            //SizedBox(  width: 200, child: Column(...), Ama bu:küçük ekranda taşabilir,büyük ekranda gereksiz dar kalır
                            //O yüzden taşma problemlerinde genelde:✅ Expanded/Flexible + Text(maxLines, ellipsis) en sağlam çözümdür.
                            Expanded(
                              flex:2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //Text(maxLines + ellipsis) ne yapıyor?maxLines: 2 → en fazla 2 satır yaz,ellipsis → taşacaksa sonuna ... koy ve kes
                                  Text(product.title, overflow:TextOverflow.ellipsis,maxLines: 2,),
                                  //Text(maxLines + ellipsis) → uzun başlıklar satırı patlatmasın.
                                  const SizedBox(height: 4),
                                  //A RenderFlex overflowed by 167 pixels on the right.The following assertion was thrown during layout:
                                  //Bu hata Row taşması (RenderFlex overflow): solda resim var, sağda Column var;
                                  // Column’un içindeki Text(product.title) + buton ekran genişliğinden büyük olunca Row sağdan taşıyor.
                                  //Çözüm: Row içindeki “sağ taraf”ı Expanded/Flexible yapıp, title’ı kısalt (maxLines/ellipsis). Gerekirse butonu da “sığacak şekilde” ayarla.
                                  //Etki: “John Hardy Women’s Legends Naga Gold & Silver ...” gibi uzun başlıklar sonsuza uzayıp Row’u patlatmaz,2 satırda biter gerisi ... olur
                                  Text("\$${product.price.toStringAsFixed(2)}", style:const TextStyle(fontSize: 20)),
                                  const SizedBox(height: 8),
                                  //SizedBox(width: double.infinity) niye “tam genişlik” yapıyor?SizedBox çocuğuna bir ölçü (constraint) verir.
                                  //width: double.infinity demek:“Parent ne kadar izin veriyorsa o kadar geniş ol”.Sen bunu Column’un içinde kullanınca şu olur:
                                  //Column’un genişliği (Expanded sayesinde) zaten “kalan alan kadar”SizedBox(width: double.infinity) da butona der ki:
                                  //“Column’un genişliği kadar yayıl”
                                  //Etki: Buton “Add to cart” yazısı uzun olsa bile daha rahat sığar, sağa taşma ihtimali azalır. Ayrıca görsel olarak daha “kartın altına oturan” bir buton olur.
                                  //Eğer bunu yapmazsan, ElevatedButton.icon kendi “doğal genişliği” kadar olur (icon+text ne kadar yer istiyorsa).
                                  // Dar ekranda bu bazen taşmaya daha yatkın olur.
                                  SizedBox(
                                     // width:double.infinity,//parentin genisligini tamamen al..kullanaibldin maksimum alani kullan...
                                      child: ElevatedButton.icon(onPressed: (){
                                        print("${product.title} is added to Cart!!!!!!");
                                      },icon:const Icon(Icons.add_shopping_cart), label:const Text("Add to cart"))),
                                  //Simdi bu ElevatedButton.icon da biz im onTap imiiz var buray tiklayinca sadece burasi tetikleniyor
                                  //Ama bu ElevatedButton.icon u da kapsayan Card a da bir GestureDedector ile onTap ozelligi verdk..
                                  // yani aslinda bu ElevatedButton.icon da Card in icinde oldugu icin buraya tiklayinca
                                  // acaba Card a verdgimz GestureDedoctor ile onTap da tetiklenir mi onun ekstra ayar yapmak gerekir mi diye dusunmustum
                                  // web de boyle oluyrdu ama burda direk her iksini birbirinden ayirmis otomatik olarak
                                  // onun icin boyle bir sorunu dusnmemize gerek yok flutter da
                                ],
                              ),
                            ),
                            //Expanded(flex:1,child: SizedBox())
                            //Sagda bos alan, verdik sirf bir ussteki Expanded column sagdaki bos alanin tamamini kullanmasin diye
                            //BU HARIKA BESTPRACTISE...EXPANDE VERDIGMZ ALAN ILLAKI KALAN BOLSUGU TAMAMINI DOLDURMASIN ISTERSEK HEMEN EN SAGA BIR TANE SIZEDBOX ATIYORUZ
                            // SONRA ONU EXPANDED ILE SARALIM VE FLEX ILE ORANLARI AYARLAYALIM...
                          ],
                        ),
                      )
                    ),
                );

                //ListTile Flutter’daki hazır “liste satırı” widget’ı. Senin ListView.builder her ürün için bir “satır” çiziyor ya;
                // işte o satırı hızlıca güzel göstermek için ListTile kullanıyoruz.

              },
            );
          }else{
            return const Center(
              child: const Text("There is no product-data"),
            );//Bazen ); hata gelir sadece ;  kaldir geri yaz hata kaybolur
          }

        }
      )
    );
  }
}
/*
* Mini özet (tek cümlelik)
Expanded: “Column ekran sınırına uysun, sınırsız büyümesin”
SizedBox(double.infinity): “Buton Column genişliğini doldursun”
maxLines + ellipsis: “Uzun başlık taşmasın, kesilsin”
* */