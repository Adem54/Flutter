Future<void> main() async
{

  print("get data from database");
  var data = await getDataFromDB();

  print("data-fetched: ${data}");//Dikkat burasini data yi almadan once hemen okudu...okumaya calisti ve yukardaki datayi da alamadigi icin burda hata verdi..
  //Bunu cozmek icinde bizim getDataFromDB basna await yazalim ve bekletelim...ki datayi alip da bir sonraki satira gecsin datayi almadan bir sonraki satira gecmesin
  //Simdi hataisz bir sekkidle data yi aldiktan sonra data-fetched datasini ekrana basti...
  //await getDataFromDB() burda await kullaniyorsan o zaman main fonks da async ve
  // de async kullaniyrosak da o zaman da sadece void olan main fonks nunu Future<void> de kullanmalyiz
}

//Bu islem asenkron yani zaman alan ve uzak data, database veya api den gelen, veya service den gelen bir data ise
// o zmaan asenknron yapmaliyiz ki..diger islemler kilitlenmeden devam etsin...
//Asenkron olmasi icin, ise Future degeri ile yazmaliyiz bir fonksiyonu
Future<List<Product>> getDataFromDB() async
{
  for(var index=0; index<6; index++)
  {
    Future.delayed(Duration(seconds:index),()=>print("Data : %${index*20} "));
  }//Burda gecikme yi simule etmek icin yaptik burayi
  List<Product> products;
  products = [Product(id: 1, title: "Pc1", description: "HP mark1"),Product(id: 2, title: "Pc2", description: "HP mark2")];
  return Future.delayed(Duration(seconds:5), ()=>products);//5 saniye bekledikten sonra gosterecegiz datayi db veya api den getirirken ki gecikmeyi simule etmek icin
  //return await products;
}

class Product {
  int id;
  String title;
  String description;

  Product({required this.id, required this.title, required this.description});
}