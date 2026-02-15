import 'package:flutter/material.dart';
import 'package:products_app/data/entity/product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:products_app/ui/views/product_detail.dart';


class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products", style:TextStyle(fontSize: 16)),),
      body:FutureBuilder<List<Product>>(
        future:productFuture,
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
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context,index){
                final product = products[index];
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
                return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       //Dikkat edelim biz burda asagdiki butonu da center a aldik..crossAxisAlignment: CrossAxisAlignment.center,
                        // ile ama biz gidip ElevatedButton un kendisini Center icine wrap yaparak da ortalayiblirdik unutmayalim
                       children: [
                         GestureDetector(
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
                           child: ListTile(
                               leading: Image.network(product.image, width: 40,height: 40, fit:BoxFit.cover),
                               title:Text(product.title),
                               subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
                               trailing: const Icon(Icons.chevron_right)),
                         ),
                             //trailing: const Icon(Icons.chevron_right) tek başına tıklanabilir (onTap’li) değildir.Icon sadece görsel bir widget.
                             //Ona basınca bir şey olmasını istiyorsan tıklanabilir bir widget ile sarman gerekir
                         //ElevatedButton(onPressed:(){}, child: const Text("Add to Card"),)
                         ElevatedButton.icon(onPressed: (){},icon:const Icon(Icons.add_shopping_cart), label:const Text("Add to cart")),
                         //hata vardi en sondaki virgulu kaldirdim geri yazdim hata gitti
                       ],
                      ),
                    )
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
