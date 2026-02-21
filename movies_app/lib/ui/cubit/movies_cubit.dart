import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/entity/movie.dart';
import 'package:movies_app/data/repo/movie_dao_repostory.dart';
import 'package:movies_app/ui/cubit/movies_state.dart';

//Dikkat edelim sayfamizin statei o sayfa icerisinde degismesi ile sayfanin ui ini degistirecek olan verilerdir
//Mesela sayfa yuklenirken ne gosterecegiz sayfaya, sayfa yuklendiginde ne gosterecegiz(movieList), default olark ne gostereegiz initial,
// bir de error cikarsa ne gosterecegiz
//Neticede sayfa da kullanilacak olan stateleri mantik olarak bir class icinde toplayarak ki
// her bir class bir type dir bildigmz gibi o class i o typi state olarak veririz ve artik
// bu state ler her degistiginde biz emit gonderiyoruz ya o emit state in degismesine
// bakar state degismis ise o UI yi tetikler ve UI da da Blockbuilder tarafindan dinlenir ve yakalanir
class MoviesCubit extends Cubit<MoviesState> {

  MoviesCubit():super(MoviesInitial());
  var movieRepo = MovieDaoRepostory();


  Future<void> fetchMovies() async {
    try
    {
      emit(MoviesLoading());
      final movies = await movieRepo.fetchMovies();
      emit(MoviesLoaded(movies));
    }catch(e)
    {
      emit(MoviesError(e.toString()));
    }

  }
}
//Burda veritabanindan gelen verileri aliriz..ve eger ki ui da gosterilmeden once yapilacak islem
// var ise de onu da burda yapariz ki ui temiz kalsin her zaman

/*
pubspec.yaml da flutter_bloc kutuphaneisni yuklemeyi unutma cubit-bloc yapisini kullnabilmeki  icin
* # versions available, run `flutter pub outdated`.
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc:
*
* */
/*
   //super(MoviesInitial()) ne yapıyor?
  // Cubit’in bir state akışı var. Cubit oluşturulduğu anda (constructor çalışınca) bu akışın
  // ilk değeri olmak zorunda.
  // MoviesCubit() : super(MoviesInitial()); Bu satır şunu demek:“Bu Cubit daha hiçbir şey yapmadan önce, state’im MoviesInitial olsun.”
  //Yani initial state = bir başlangıç etiketi / durum göstergesi.MoviesInitial extends MoviesState {} boş ya, ne taşıyor?
  //Evet, hiç veri taşımıyor. Bu normal.
  //MoviesInitial çoğu projede şunun için vardır:“Henüz hiçbir şey yüklenmedi”
  // “Uygulama açıldı ama fetch başlamadı , “İlk ekran çiziliyor”
  //Yani “boş {}” gibi düşünme; bu bir tip. (State’in türü = Initial)
  //* MoviesState = “state ailesinin” (parent) ortak tipi
  // MoviesInitial / MoviesLoading / MoviesLoaded / MoviesError = bu ailenin etiket/durum çeşitleri (subclass)
  //super(MoviesInitial());diyerek Cubit’e şunu diyorsun:“Ben daha hiçbir şey yapmadan önce state’im Initial olsun.”
  //Ve UI’da da:if (state is MoviesInitial) {  return ...;}
  //yazabilme “özgürlüğünü” kazanıyorsun. Çünkü state’in tipi artık sadece MoviesState değil;
  // hangi alt tür olduğuna göre UI davranışını seçiyorsun.
  //Yani senin dediğin gibi:amaç initial’da “veri atamak” değil,amaç state’i “etiketlemek / sınıflandırmak”
  //UI’da da bu etikete göre “ilk ekran ne göstersin?” kararını vermek.
  //Kısaca:Initial = veri değil, durum bilgisi (tag).is MoviesInitial = “şu an hangi durumdayız?” kontrolü.
  //o bloğun içinde istediğin initial UI’yi döndürürsün (boş, placeholder, loading, vs.).
  //MoviesLoaded(movies) = hem “Loaded” etiketi hem data (movies) taşıyor
  //MoviesInitial() = sadece “Initial” etiketi taşıyor (data yok)

“Madem initState’de hemen fetch çağırıyorum, MoviesInitial ne işe yarıyor?”
İşte kritik nokta:
Flutter build sırası
Widget açılırken genelde şu olur:
Cubit (BlocProvider ile) oluşturulur → state = MoviesInitial
Widget’ın build()’ı ilk kez çalışır → BlocBuilder state olarak MoviesInitial görür
Sonra initState() çalışır → fetchMovies() çağrılır
fetchMovies() içinde emit(MoviesLoading()) → BlocBuilder yeniden build olur
emit(MoviesLoaded(movies)) → tekrar build olur
Yani sen initState içinde hemen fetch çağırıyor olsan bile, UI ilk frame’de MoviesInitial yakalayabilir.
(Bu timing çok kısa ama mümkündür.)

Bu yüzden builder içinde Initial için bir dönüş yazmak mantıklı:
boş göster (SizedBox.shrink)
veya loading göster,veya placeholder göster

“Initial’de biz bir şey atamadık, nasıl oluyor?”
Çünkü “initial value” dediğimiz şey:
bir veri olmak zorunda değil,
sadece state objesi olmak zorunda.
Bu da bir objedir:
MoviesInitial()İçinde alan yok ama kendisi bir state.

 */
4) Cubit initial’ı bir “default” gibi düşün
class MyCubit extends Cubit<int> {
  MyCubit() : super(0);
}
Burada initial state 0. Çünkü state tipi int.
Senin state tipin MoviesState (abstract).
O yüzden “ilk state” olarak onun bir subclass’ını vermen gerekiyor:
super(MoviesInitial())
Bu, 0 gibi “default” rolü görüyor ama veri değil, durum.

5) O zaman MoviesInitial yerine MoviesLoading verebilir miyim?
 Evet, çoğu kişi şöyle yapar:
MoviesCubit() : super(MoviesLoading());
Ve UI’da initial case yazmaya gerek kalmaz.

Ama MoviesInitial kullanmanın artısı:

“hiç başlamadı” ile “yükleniyor” durumunu ayırırsın.

bazen sayfa açılır ama fetch’i kullanıcı tetikler (butonla) → o zaman initial gerçekten anlamlıdır.
 6) Senin senaryonda en pratik seçenek

Sen initState’de otomatik fetch yapıyorsun ya, 2 seçenek:

Seçenek A: Initial’da da loading göster
if (state is MoviesInitial) {
  return const Center(child: CircularProgressIndicator());
}
Seçenek B: Initial’ı kaldır, direkt Loading ile başlat
MoviesCubit() : super(MoviesLoading());
Ben genelde B yapıyorum (senin gibi sayfa açılır açılmaz fetch varsa).

//Eğer Cubit’in state’i sadece List<Movie> olsaydı ve constructor’da boş listeyle başlatsaydın:
//class MoviesCubit extends Cubit<List<Movie>> {
// MoviesCubit() : super(List<Movie>[]);   Future<void> fetchMovies() async {
// final movies = await repo.fetchMovies();   emit(movies);
//UI tarafında ilk build’de state zaten [] olacağı için:ilk frame’de UI boş liste görür
//sen de muhtemelen GridView.builder(itemCount: movies.length) yapınca itemCount = 0 olurekran “boş” görünür
// (hiç kart yok)Bu “istek gidene kadar geçen sürede” kullanıcıya boş sayfa gibi yansır.
//List<Moive>[] initial state → UI’da “boş data” gibi görünür.
//Bu yüzden çoğu kişi bu yaklaşımda şöyle bir kontrol ekler:
//if (movies.isEmpty) {  return const Center(child: CircularProgressIndicator());
Ama burada bir problem var:
 Loading’de de liste boş olabilir
 Gerçekten “film yok” durumunda da liste boş olabilir
Yani movies.isEmpty ile:
“yükleniyor” mu
“gerçekten veri yok” mu
ayıramazsın.
O yüzden state sınıfları (Initial/Loading/Loaded/Error) daha iyi
Çünkü:
MoviesLoading → loading göstereceğini kesin bilirsin
MoviesLoaded([]) → gerçekten boş sonuç geldiğini bilirsin (“No movies” yazarsın)
MoviesError → hata UI’sı
Kısa özet

Evet:
Sadece List<Movie> state kullanırsan, initial [] → UI ilk anda boş görünür.
Bu yaklaşım “hızlı” ama loading/empty ayrımını zorlaştırır.
State sınıflarıyla bu ayrım netleşir.

*/

