import 'dart:io';

void main()
{
  //Tarih / saat (expire time vb.)
  DateTime now = DateTime.now();
  DateTime expiresAt = DateTime(2026, 1, 15, 23, 59);

  //Süre (kullanma süresi, 30 gün, 2 saat vb.): Duration
  Duration trial = const Duration(days: 30);
  Duration couponValidFor = const Duration(hours: 12);

  //“Expire time” hesaplama örneği
  final createdAt = DateTime.now();
  final expiresAt2 = createdAt.add(const Duration(days: 7));
  final isExpired = DateTime.now().isAfter(expiresAt);

//API’den geliyorsa (genelde string ISO 8601): String → DateTime.parse
  final expiresAt3 = DateTime.parse("2026-01-15T23:59:00Z");
  //Not: Sunucudan gelirken genelde UTC (Z) formatı daha güvenlidir.

  //Resim formatı / resim “değeri”
  //Sadece format (png/jpg/webp): enum

}

//Sadece format (png/jpg/webp): enum
enum ImageFormat { png, jpg, webp }
final format = ImageFormat.png;

//Resmin dosya yolu (telefon dosyası): String
final path = "C:/images/photo.png"; // veya mobile path

//URL (internetten): Uri (veya String)
final url = Uri.parse("https://example.com/a.png");

//Dosyanın kendisi (mobil/desktop): File (dart:io)
final file = File("C:/images/photo.png");



