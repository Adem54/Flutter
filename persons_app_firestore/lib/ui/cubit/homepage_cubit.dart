import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persons_app/data/entity/person.dart';
import 'package:persons_app/data/repo/persons_dao_repostory.dart';

class HomepageCubit extends Cubit<List<Person>> {
  HomepageCubit():super(<Person>[]);//void olsa idi 0 yazacaktik...
  var personDaoRepo = PersonsDaoRepostory();
  // ✅ Orijinal tam liste (source of truth)
  List<Person> _allPersons = [];
  //Firestore Persons tablomuza baglantiyi sagladgimz kodu boyle yerlestirirz
  var collectionPersons = FirebaseFirestore.instance.collection("Persons");

  //burasi Future<void> olacak neden cunku burda biz fonks return islemini emit uzerinden yapiyoruz...
  Future<void> fetchPersons() async {
    //snapshots yapisi gercek zamanli okuma alt yapisi
    collectionPersons.snapshots().listen((event)
    {
        var personList = <Person>[];
        //event ile tum dokumanlari alacagiz...her bir kayita dokumant deniyor
        var documents = event.docs;
        for(var document in documents)
          {
            //document firebase db deki her bir person recordunu temsil eder
            var key = document.id;//documentID yi verir
            var data = document.data();//person bilgisini veriyor yani person_name, person_id,person_tel i veriyor data
            var person = Person.fromJson(data, key);
            personList.add(person);//Bu sekilde firebsase db deki tum person larimzi personList imize eklemis olacak
          }
        emit(personList);
        //Evet burda artik direk firestore dan gercek zamanli okumayi uygulamis olduk....
      //Dikkat snapshots sayesinde artik bu kodlama bizim veritabanimizi dinliyor ve veritabaninda degisiklk
      // oldugu anda burasi otomatik calisacak ve arayuzu guncelleyecek..HARIKAA
      //KI direk firestore db de herhangi bir kaydimizi actik ve update yaptik name ve tel de ve
      // bnun aninda mobile uygulamamizda bu degisikligi aldigmzi gorebiliyoruz, hatta ayni sekilde
      // kaydi sildigmizde de siliniyor biz mobile de ekstra tetikeme yapmiyoruz...anlik olarak degisiyor...
      //Direk uygulamamiz uzerindedn ekleme yaptimgzda da hem veritabaninda da ekleyecek ve o
      // degisiklik aninda da mobile uygulamada da gozukecek real-time dinleme snpashot dan doalyi
      //Artik bizim silme isleminde arayuzu guncellmek icin veritabanindaki degisikligi almak icin yaptigim
      // bu fetch ismine ihtiyacimz yok(  //await personDaoRepo.fetchPersons();) silme isleminden sonra cunku, zaten realtime olarak veritabnainda
      // olan her turlu degisiklikgi alabiliyoruz...

      //Detay sayfasinda edit yapip sonra ana sayfaya geri donerken degisikigi veritabanindan alabilmek
      // icin ui-homepage_cubit.dart ta yaptigimz fetch islemnie de gerek yok artik
      //context.read<HomepageCubit>().fetchPersons();
      //Bu isleme ihtiaycimz kalmadi firestore da databasedeki degiskligi realtime olarak alaibldigmz icin
      //Ayni sekilde hompeage_cubit.dart da register islemini yaptiktan sonra ki datbase de degisiligi almak
      // icin yaptigm fetch islemine de gerek yok
    });
  }


  void search(String query) {
    //snapshots yapisi gercek zamanli okuma alt yapisi
    collectionPersons.snapshots().listen((event)
    {
      var personList = <Person>[];
      //event ile tum dokumanlari alacagiz...her bir kayita dokumant deniyor
      var documents = event.docs;
      for(var document in documents)
      {
        //document firebase db deki her bir person recordunu temsil eder
        var key = document.id;//documentID yi verir
        var data = document.data();//person bilgisini veriyor yani person_name, person_id,person_tel i veriyor data
        var person = Person.fromJson(data, key);

        //Aramada bu sekilde yani araninlan text icinde olan personlari getirecek liste olarak
        if(person.person_name.toLowerCase().contains(query.toLowerCase()))
          {
            personList.add(person);//Bu sekilde firebsase db deki tum person larimzi personList imize eklemis olacak
          }
      }
      emit(personList);
    });

  }
  //Bu search methodu nun database uzerinden cagrilmasi gerekli sartlar olusurda datatbase e gitmek gerekir
  // ise o zaman tabi ki biz bu islemin database de yapilacak kisini repostory ye yerlestirecegiz

  Future<void> deletePerson(String person_id) async {
    await personDaoRepo.deletePerson(person_id);
    //Ardindan da tum kisileri yukleyecegiz..
    //Biz veritabaninda islemleri yaptik eyvallah ama hala ui da tum personlar duruyor
    // yani biz veritabaninda person silindikten sonra veritbaninin update edilmis List<Person>
    // in ui da da gelmesini istyoruz..ondan dolayyi tekrar person listesini fetch ederiz...BU COK ONEMLI BILELIM...
    //await personDaoRepo.fetchPersons();
    //Artik bizim silme isleminde arayuzu guncellmek icin veritabanindaki degisikligi almak icin yaptigim
    // bu fetch ismine ihtiyacimz yok silme isleminden sonra cunku, zaten realtime olarak veritabnainda
    // olan her turlu degisiklikgi alabiliyoruz...
  }

}

/*
* 3 tane islem var
* 1-Sayfa yuklenir yuklenmez List<Person> datasi fetch edilip kullanicya gosterilecek
* 2-Search islemi yapilacak ki bununda tip List<Person> olarak return edilecek,
*  yani kullanici search islemi yaptiginda List<Person> donecek
* 3-Delete islemi yapacak, burda da Delete yaptiginda List<Person> dan delete yapilan person cikmissekilde gelecek
* */

/*
Filtreleme islemi
* Hedef Mimari
PersonsDaoRepository → veriyi getirir (şimdilik fake liste, sonra DB/API)
HomepageCubit → tek kaynak state: ekranda görünen List<Person>
Homepage2 → arama yazıldıkça cubit.search(query) çağırır, BlocBuilder zaten günceller.
Kritik: Cubit, filtreleme yapabilmek için “orijinal listeyi” de içinde tutmalı. Çünkü arama kapatılınca full listeye dönmek lazım.
* */
/*
*  HomepageCubit’in state’i (List<Person>) ne zaman değişirse, builder tekrar çalışır.
*  HomepageCubit’in  un stati List<Person> mu bunu surdan mi anlariz...
* class HomepageCubit extends Cubit<List<Person>> { cubitler de mantk boyle midir...
*
* Evet, bunu tam olarak buradan anlıyoruz ✅
* class HomepageCubit extends Cubit<List<Person>> { ... }
Bu Cubit’in state tipi List<Person>’dır.
* Yani:
* HomepageCubit bir state taşır
*o state’in türü List<Person> (kişilerin listesi)
* emit(...) ederken de List<Person> göndermen gerekir
* Örnek:
* emit(personList); // personList: List<Person>
Cubit’lerde mantık hep böyle mi?
* Evet. Cubit/Bloc’ta generic type (<> içi) state’i tanımlar.
* Örnekler

Sayaç (int state):
* class CounterCubit extends Cubit<int> {
  CounterCubit(): super(0);
  void inc() => emit(state + 1);
}
Tema (bool state):
* class ThemeCubit extends Cubit<bool> {
  ThemeCubit(): super(false);
  void toggle() => emit(!state);
}
Model state (Person state):
* class SelectedPersonCubit extends Cubit<Person?> {
  SelectedPersonCubit(): super(null);
  void select(Person p) => emit(p);
}
Kendi state class’ını kullanmak (en profesyonel yol):
* class HomepageState {
  final List<Person> persons;
  final bool loading;
  final String? error;
  HomepageState({required this.persons, required this.loading, this.error});
}

class HomepageCubit extends Cubit<HomepageState> { ... }
“BlocBuilder neyi dinliyor?” kısmı
* Sen şunu yazınca:
* BlocBuilder<HomepageCubit, List<Person>>(...)
1)param: hangi Cubit’i dinleyecek → HomepageCubit
* 2)param: o Cubit’in state tipi ne → List<Person>
Yani BlocBuilder diyor ki:
* HomepageCubit’in List<Person> state’i değiştikçe ben rebuild edeceğim.
* Kısacası: Evet, Cubit’te generic type neyse state odur.
*
* BIR YORUM VE SORU:
*
* O ZAMAN benim aklima gelen sormayi dusundugum soru nun cevabi bu mu oluyor:class HomepageState {
  final List<Person> persons;
  final bool loading;
  final String? error;
  HomepageState({required this.persons, required this.loading, this.error});
}

class HomepageCubit extends Cubit<HomepageState> { ... }
* aklima gelen soru su idi peki ben ornegin bir homepage.dart gibi veya baska bir screen-page dosyasiinda
* ornegin bircok interaction olan bir sayfa diyelim ki yani bir yerde List<Person> baska bir buton da int,
* baska ibrinde bool, bir degigerinde string vs...gibi bir cok farkli state var tur var ee her birisi icin gidip de
* ben cubit mi  yazacagim 1 tane home page icin gidip 5 farkli cubit mi  yazacagim oyle yapacak sak o zaman
* cubiot kullanmak kolaylktan cok zorluga donusmez mi?
*
* Evet—aklına gelen sorunun cevabı tam olarak bu ✅
Ve hayır: “Bir sayfada 5 farklı state var diye 5 ayrı cubit yazmak zorunda mıyım?” → Genelde hayır.
*
* 1) Cubit’in state tipi tek olmak zorunda, ama o state’in içinde her şey olabilir
Cubit’in generic’i tek tip ister:
* 1) Cubit’in state tipi tek olmak zorunda, ama o state’in içinde her şey olabilir
Cubit’in generic’i tek tip ister:
* Ama HomepageState içine istediğin kadar alan koyarsın:

List<Person> (liste)
bool isSearching
String query
int selectedIndex
bool loading
String? error
vb.
*
* Yani tek cubit + tek state class ile bir sayfadaki bir sürü farklı state’i yönetebilirsin.
*
* 2) “5 farklı Cubit mi yazacağız?” ne zaman olur?
Bazen olur ama bu bir “zorunluluk” değil; daha çok modülerlik.
Tek Cubit yeterli olan durum (çoğu ekran)
*
* Ekrandaki her şey birbirine bağlıysa:
listeyi çek
loading/error yönet
search query
filtrelenmiş liste
delete/update
Bunlar aynı “feature” → tek HomepageCubit mantıklı.
*
* Birden fazla Cubit ne zaman mantıklı?
Eğer sayfada birbirinden bağımsız iki büyük feature varsa, ayırmak güzel olur.
*
* Örnek:

Home’da hem “Persons listesi” hem “Cart” hem “Theme” gibi bağımsız şeyler
veya aynı sayfada iki ayrı API akışı
Bu durumda iki cubit yazmak işleri temizler.
* Ama “her küçük bool için ayrı cubit” yazmak şart değil.
*
* 3) Pratik örnek: Tek state ile her şeyi toplamak
* class HomepageState {
  final List<Person> persons;
  final bool loading;
  final String? error;

  final bool isSearching;
  final String query;

  const HomepageState({
    required this.persons,
    required this.loading,
    required this.isSearching,
    required this.query,
    this.error,
  });

  factory HomepageState.initial() => const HomepageState(
    persons: [],
    loading: false,
    isSearching: false,
    query: "",
    error: null,
  );

  HomepageState copyWith({
    List<Person>? persons,
    bool? loading,
    String? error,
    bool? isSearching,
    String? query,
  }) {
    return HomepageState(
      persons: persons ?? this.persons,
      loading: loading ?? this.loading,
      error: error,
      isSearching: isSearching ?? this.isSearching,
      query: query ?? this.query,
    );
  }
}
*
* Cubit
*
* class HomepageCubit extends Cubit<HomepageState> {
  HomepageCubit() : super(HomepageState.initial());

  List<Person> _allPersons = [];

  Future<void> fetchPersons() async {
    emit(state.copyWith(loading: true, error: null));
    try {
      _allPersons = await repo.fetchPersons();
      emit(state.copyWith(loading: false, persons: List.from(_allPersons)));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  void search(String q) {
    final query = q.trim().toLowerCase();
    if (query.isEmpty) {
      emit(state.copyWith(query: "", persons: List.from(_allPersons)));
    } else {
      final filtered = _allPersons.where((p) {
        final name = (p.person_name ?? "").toLowerCase();
        final tel = (p.person_tel ?? "").toLowerCase();
        return name.contains(query) || tel.contains(query);
      }).toList();
      emit(state.copyWith(query: q, persons: filtered));
    }
  }

  void setSearching(bool v) => emit(state.copyWith(isSearching: v));
}
* UI:
*BlocBuilder<HomepageCubit, HomepageState>(
  builder: (context, s) {
    if (s.loading) return const Center(child: CircularProgressIndicator());
    if (s.error != null) return Center(child: Text(s.error!));
    return ListView.builder(
      itemCount: s.persons.length,
      itemBuilder: (_, i) => Text(s.persons[i].person_name ?? ""),
    );
  },
);
*
* Bu şekilde tek cubit ile:
loading/error
list
search mode
query
hepsi yönetilir.

* 4) Kısa cevap
Cubit’in state’i tek tip olmak zorunda.
Ama o state class olursa içinde her türden alan taşıyabilir.
O yüzden “5 state var → 5 cubit” zorunluluğu yok.
Çoğu sayfa için 1 cubit + 1 state class en mantıklısı.
*
* */