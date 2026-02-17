import 'package:block_pattern_usage/data/repo/mathematic_repostory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//<> icerisne ne koyacagiz, homepage.dart a gidip bakariz, benim Cubit degerim hangi degeri ara yuze gonderecek
//homepage de biz ara yuzde int result u gostermeye calisiyoruz..her iki button isleminde de..dolayisi ile Cubit<int> olacak
//homepage ara yuzde int result verisini yonetiliyor tiklanan buton lar int result degerini dinamk sekkilde girilen degere gore yonetiyor
//Eger ki ornegin arayuze veri aktrmayacaksak, o zaman Cubit<void> olabilir
class HomepageCubit extends Cubit<int> {
   HomepageCubit():super(0);//0 varsayilan degr, yani ui ya gonderilecek int result un default degeridir

   MathematicRepostory mat_repo = MathematicRepostory();
    void sum(String inputNumber1, String inputNumber2){
       /* int input1 = int.parse(inputNumber1) ?? 0;
        int input2 = int.parse(inputNumber2) ?? 0;
        int sumData = input1 + input2;
         Bu islemler repostory de yapilacak artik...dikkat edelim....burda degil
        */
      int sumData = mat_repo.sum(inputNumber1,inputNumber2);
        //Biz burda direk olarak setState calistiramayiz ama ne yapariz emit ile tetikleme yapabilyoruz...Burdan setState i tetikleyebilirz
        emit(sumData);//trigger and send data...
      //iSTERSEK SOYLEDE YAPABILIRZ DIREK YAZARIZ.. emit(mat_repo.sum(inputNumber1,inputNumber2));
      //emit ile veri gonderdik ama orda da dinleme yapsinin kurmamiz gerekiyor bu tetiklenen ve gonderilen datayi alabilmek icin...
      //emit ile gonderilen ve tetiklenen islemi biz gidip homepage.dart ta kullanaagiz dkkat edelim ve
      // biz dinledigmz zaman da result verisini homepage de almis olacagiz
    }

   void multiple(String inputNumber1, String inputNumber2){
    /* int input1 = int.parse(inputNumber1) ?? 0;
     int input2 = int.parse(inputNumber2) ?? 0;
     int multipleData = input1 * input2;
      Bu islemler repostory de yapilacak artik...dikkat edelim....burda degil
      */

     int multipleData = mat_repo.multiple(inputNumber1,inputNumber2);
     //Biz burda direk olarak setState calistiramayiz ama ne yapariz emit ile tetikleme yapabilyoruz...Burdan setState i tetikleyebilirz
     emit(multipleData);//trigger and send data...
     //iSTERSEK SOYLEDE YAPABILIRZ DIREK YAZARIZ.. emit(mat_repo.multiple(inputNumber1,inputNumber2));
     //emit ile veri gonderdik ama orda da dinleme yapsinin kurmamiz gerekiyor bu tetiklenen ve gonderilen datayi alabilmek icin...
   }

   //!!!ISTE CUBIT IN GOREVI TAM OLARAK SU KI REPOSTORY DE VAR OLAN METHODLAR UZERINDEN ISLEMLERI YAPMAK VERIYI ALMAK,
// VE ALDIGI SONUCU EMIT UZERINDEN ARA YUZE GONDERMEK!!!!COK SADECE VA BASIT!!! CUBIT IN OZELLIGI KUTUPHANEDEN
// GELEN FLUTTER_BLOC DAN GELEN EMIT ILE UI-ARAYUZU BESLEYEBILIYOR
//CUBIT YONETICI POZISYONUNDA REPOSTORYEYE ISLEM YAPTIRIR ORDAN GELEN DATAYI ALIR VE ONU EMIT ILE UI YA GONDERIRZ..
// .UI TARAFINDA DEFAULT VALUE YI KENDI CONSTRUCOR PARAMETRESINDE ATMAASINI YAPAR, VE UI ICINDE KI METOT TETIKLENIR..
// INPUTLARI UI DAN ALIR, UI DAN ALDIGI INPUTLAR DA KULLANARAK REPOSTORYDEN GELEN METHODU TETIKLER ORDAN ALDIGI RESPONSU
// EMIT ILE UI YA TEKRAR GONDERIR..VE BUNLMARIN HEPSI HIC SETSTATE KULLANMADAN OLUR


}

/*
***************COOOK ONEMLI- flutter_bloc kutuphanesini pubspec.yaml da eklemeliyiz Cubit i kullanabilmek icin *********
Cubit ile calismak icin Bloc kutuphanesini kurmamiz gerekiyor
pubspec.yaml a gideriz ve flutter_bloc: u flutter ile ayni hizaya yaszariz ve karsina
 flutter_bloc: birsey yazmasak boyle birakirsak en guncel surumu getirri veya istedigmz bir surum var ise onu karsina yazari
# the latest version available on pub.dev. To see which dependencies have newer
# versions available, run `flutter pub outdated`.
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc:

ekledikten sonra pub get e basarak yuklenemsini saglariz..
Her sayfaya ait bir cubit olacak!!
* *
*
* */
/*

Bu cubic imizi app imize main.dart icinde tanitmammiz gerekiyor!!!!!!!!!!!!!!!!!!
main.dartta ypama sebegimz tum uygulamada etki etmesi icin
Widget build(BuildContext context) {
  return MultiBlocProvider(//MaterialApp i secip alt-enter yaparak widget ekleriz ve
    // MultiBlocProvider seceriz HomepageCubit yapimizi tanitmak icin
      providers: [BlocProvider(create: (context)=>HomepageCubit())],//Kac tane cubitimiz var ise hepsini burda tanitmamiz gerekiyoir
      child: MaterialApp(
        title: 'Flutter Demo',

          */