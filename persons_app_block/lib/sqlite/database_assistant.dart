import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseAssistant {
  static final String databaseName = "phonebook.sqlite";

  //Veritabani dosyamiza erisim fonksiyonu
  static Future<Database> databasAccess() async {
    String databasePath = join(await getDatabasesPath(), databaseName);
    //TElefondaki veritabani yolunu temsil ediyor
    //veritabani adi ile yoluna erisecegiz..ve sonra da bu ismde veritabni var mi yok mu onu kontrol ederiz daha
    // once kopyalandi ise var diye gelir eger yok ise o zaman da kopyalama islemi yapillacak,
    // daha once kopyalandi ise tekrar tekrar kopyalama ypailmamasi icin

    if(await databaseExists(databasePath)){
      print("Database exists already, no need to copy");
    }else{
      //Bu database klasorumz altindaki phonebook.sqlite a erismek icin
      ByteData data = await rootBundle.load("database/$databaseName");
      //ByteData ve rootBundle alti cizili gelir son 2-3 harflerini silip geriyazarsak services.dart
      // kutphanesini import ederek hata ortadan kalkacaktir
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      //Bu liste phonebook.sqlite dosyasini okumak icin gerekli olan dosyadir ve burda byte a cevrilir
      //Sonra byte imiz buraya kopyalanir ve sonra da return ile opendatabase
      await File(databasePath).writeAsBytes(bytes,flush:true);
      //File in da son 2harfini silip geri yazip dart.io dan import edilerek hata ortadan kalklar
      print("Database is copied.");
    }

    return openDatabase(databasePath);
  }
}
