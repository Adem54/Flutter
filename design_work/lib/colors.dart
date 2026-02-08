 import 'dart:ui';

var mainColor = const Color(0xFFCB2020);
//0 ise gorunmez, FF ise gorunur anlamina gelir, geriye de 6 haneli hexedecimal i yazmis oluruz
 //FF saydamilik opacity degeri..bu sabit olacasgi icin const yaptik...
 var fontColor1 = const Color(0xFFFFFFFF);
 var fontColor2 = const Color(0xFF636363);
/*
const mainColor = Color(0xFFCB2020);
const fontColor1 = Color(0xFFFFFFFF);
const fontColor2 = Color(0xFF636363);

* Böyle yazınca:
Değerler compile-time constant olur
Yanlışlıkla sonradan değiştirilemez (daha güvenli)
Stil olarak Flutter’da daha tercih edilir
“const ile tanımlanmış değeri var’a atamak sıkıntı mı?”
Hayır, sıkıntı değil.
var sadece “değişkenin tipini çıkar” demek. Ama var olunca teoride yeniden atama yapabilirsin:
* */