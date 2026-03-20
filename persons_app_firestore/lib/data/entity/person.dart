class Person {
  String person_id;
  String person_name;
  String person_tel;

  Person({ required this.person_id, required this.person_name, required this.person_tel});

  //Dart direk otomatk olarak parse etmiyor json u bizim manuel bir fonks yazmamiz gerekiyor endtpointin response olarak
  // gelen json i parse edeblmek icin
  //Bize parantezle birlkte json gonderilyor Map<key,value> json icindeki key-value yu temsil ediiyor,
  // key kismi her turlu string olacak person_id,person_name,person_tel ama bunlarin alacagi degerler
  // dinamik degisebilir string,int,bool..
  factory Person.fromJson(Map<dynamic, dynamic> json, String key)//
  {
    //key i ayrica istiyrouz cunku Documentid yi okuyabilmek icin...
    //Firestore person olsutururken direk person_id ye atamiyor kendisi documentid olusturyor biz bu docid yi person id olarak kullancagiz
    return Person(
        person_id: key,//burda person_id yi okusa idik bos gelecekti ondan dolayi boyle yaptik...
        person_name: json["person_name"] as String,
        person_tel: json["person_tel"] as String
    );
  }
}
//Bunlari alttan cizgi ile ayridk veritabani kolonlari ile ayni olmasi icin
//Burasi entity class i yani veritabanimizdaki tablolara karsilk gelen class lari temsil ediyor