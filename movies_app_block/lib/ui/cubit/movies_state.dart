// movies_state.dart
import 'package:movies_app/data/entity/movie.dart';

abstract class MoviesState {}

class MoviesInitial extends MoviesState {}
class MoviesLoading extends MoviesState {}

class MoviesLoaded extends MoviesState {
  final List<Movie> movies;
  MoviesLoaded(this.movies);
}
class MoviesError extends MoviesState {
  final String message;
  MoviesError(this.message);
}

/*
* MoviesState = “state ailesinin” (parent) ortak tipi
MoviesInitial / MoviesLoading / MoviesLoaded / MoviesError = bu ailenin etiket/durum çeşitleri (subclass)
* */
/*
* MoviesInitial çoğu projede şunun için vardır:
“Henüz hiçbir şey yüklenmedi”
“Uygulama açıldı ama fetch başlamadı”
“İlk ekran çiziliyor”
Yani “boş {}” gibi düşünme; bu bir tip. (State’in türü = Initial)
* sen diyorsun ki ya bizm amacimiz zaten orda birsey atamak degil haci
*  bizim amacimzi onu intitial state ama ana MovieState in bir subclasss i dolayisi
*  ile parent ana MovieState dir ayyni zamanda onu extend ettigi icin iste burda etiketledin
* o zaman su ozgurlugun oldu ui da movies.dartta artik movieState ti aldiginda git sunu de
* if(state is MovieMoviesInitial}..buraya return ile istedgini initial ui yi gosterebilrisin...
* ana mantiik bu degil mi o zaman
* SORU?????
* Burda MovieState in abstrac class olma sebebi nedir..normal class olsa idi de bu islemi yapamaz miydik
*Kısa cevap
Evet, normal class da yapsan çalışırdı.
Ama abstract class yapmanın amacı:
“Bu sınıf direkt kullanılmasın, sadece ortak bir tip (base type) olsun.”
* Senin kod üzerinden net anlatım
* abstract class MoviesState {}
Bu şu demek:
 MoviesState() oluşturamazsın
Ama şu olur:
MoviesInitial()
MoviesLoading()
MoviesLoaded(...)
MoviesError(...)
Yani bu class:
 “ortak çatı”
 “tüm state’lerin parent’ı”
Neden gerekli?
Çünkü Cubit şunu ister:
class MoviesCubit extends Cubit<MoviesState>
Burada Cubit diyor ki:

“Benim state’im MoviesState tipinde olacak ama farklı alt türleri olabilir.”
Sen de bu alt türleri yaratıyorsun:
Initial
Loading
Loaded
Error
 Eğer abstract olmasaydı ne olurdu?
class MoviesState {}
 Bu durumda:
MoviesState()
oluşturabilirdin.
Ama bu kötü çünkü:
 Bu state hiçbir anlam taşımıyor
loading mi?
error mu?
data mı var?
Hiç belli değil
 Abstract yapmanın faydası
1) Yanlış kullanımı engeller

Şunu yapamazsın:
* emit(MoviesState()); //
 Bu çok önemli çünkü bu state “boş, anlamsız state” olurdu.
 2) Seni doğru mimariye zorlar
emit(MoviesLoading());
emit(MoviesLoaded(movies));
emit(MoviesError("hata"));
  Yani her zaman anlamlı bir state göndermek zorundasın.
  3) UI tarafında güvenli kontrol
   if (state is MoviesLoaded)
if (state is MoviesError)
    Bu yapı temiz çalışır çünkü:
Her state bir subtype
Hepsi aynı parent’tan geliyor
  Mental model (çok önemli)

Bunu şöyle düşün:
  abstract class Animal {}

class Dog extends Animal {}
class Cat extends Animal {}
  Animal:
direkt kullanılmaz
sadece “tip”tir
   Aynisi:
   * abstract class MoviesState {}

   Özet (net kafaya oturt)

abstract = “bu class sadece base class, direkt kullanılmasın”
MoviesState = ortak tip
MoviesLoaded / Error / Loading = gerçek durumlar
Cubit = bu durumlar arasında geçiş yapar
UI = hangi durumda olduğunu is ile anlar
    En kritik cümle

👉 MoviesState bir veri değil, bir state türü sistemi (state hierarchy) kurmak için var.
    * * */