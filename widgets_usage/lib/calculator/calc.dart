import 'package:flutter/material.dart';

class Calc extends StatefulWidget {
  const Calc({super.key});

  @override
  State<Calc> createState() => _CalcState();
}

final rows = [

  ["AC", "C", "%", "÷"],
  ["7", "8", "9", "×"],
  ["4", "5", "6", "−"],
  ["1", "2", "3", "+"],
  ["0",  "=", "⌫"],
];

class _CalcState extends State<Calc> {
  String result = "0";
  String symbol = "";
  var myRes =  0;
  int? valueInput = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Calculator", style:TextStyle(color:Colors.blue))),
      body:Center(
        //Column(children: ...) List<Widget> ister.
        //List.generate(...) List<Widget> döndürür.
        //Sen bunu şöyle yazınca:children: [ Row(...),List.generate(...), // ❌ bu bir Widget değil, bu LISTE
        //children listesi şuna dönüşür:[ Row(...),// Widget ✅,  [Row(...), Row(...), ...] // List<Widget> ❌ (Widget değil)
        //O yüzden “List<Widget> can’t be assigned to Widget” hatası alıyorsun.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
           children: [
           Container(
             width:  200,
             height: 75,
             alignment: Alignment.centerRight,
             decoration: BoxDecoration(
               color: Colors.black87,
               borderRadius: BorderRadius.only(topLeft:Radius.circular(5), topRight: Radius.circular(5)),
               border: Border(
                 left: const BorderSide(color: Colors.black, width: 1,   strokeAlign: BorderSide.strokeAlignInside,),
                 top: const BorderSide(color: Colors.black, width: 1,  strokeAlign: BorderSide.strokeAlignInside,),
               //  bottom: const BorderSide(color: Colors.black, width: 1),//BorderSide.none
                 right: const BorderSide(color: Colors.black, width: 1.3,   strokeAlign: BorderSide.strokeAlignInside,),
               ),
             ),
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Text(result,
                   style: const TextStyle(fontSize: 38, color: Colors.white)),
             ),
           ), ],
           ),
          ...List.generate(rows.length, (rowIndex) {
           // print("rowIndex: ${rowIndex}");
            return buildRow(
              rows,
              rows[rowIndex],
              isLastRow: rowIndex == rows.length - 1,
              isFirstRow: rowIndex == 0,
              onKeyTap: (value) {
                String numberTextValue = "0";
                setState(() {
                  print("value!!!!!!!!!!!!; ${value}");
                  valueInput = int.tryParse(value); // "2" -> 2, "+" -> null
                  final int? res = int.tryParse(result);
                  print("res: ${res}");
                  print("number: $valueInput");
                  print("symbol: $symbol");
                  if (valueInput != null) {//number
                    // burada sayı olarak kullan
                    numberTextValue = valueInput.toString(); // veya ekran string tuttuğu için böyle
                    if(res != null)//number
                      {
                        if(res == 0 && symbol == "")
                          {
                            result = numberTextValue;
                          }else if(valueInput! >= 0)
                          {
                            result = numberTextValue;
                            if(symbol == "+")
                              {
                                myRes = res + valueInput!;
                              }
                          }else{
                          result = numberTextValue;
                        }

                      }else{
                        result = numberTextValue;
                    }
                  } else {//operator
                    print("operator/string: $value");
                    // burada operatör/komut olarak kullan
                    print("isPlust??:  ${value == "+"}");
                    if(value == "+")
                      {
                        symbol = value;
                        print("symbollllllll: ${symbol}");
                      }else if(value == "AC")
                        {
                          result = "0";
                        }else if(value == "=")
                          {
                            symbol = value;
                            //myRes = res + valueInput;
                            result = myRes.toString();
                          }
                  }

                  //result = value; // ✅ burada setState var
                });
              },
            );
          }),
          ],
        ),
      ),
    );
  }
}

Widget calcBtn(String text, {required bool isLastCol,  required bool isLastRow, required bool isWidth2Size,
  required bool isLastItem,required bool isFirstRow,   required VoidCallback onTap}) {
  return GestureDetector(
    onTap:onTap,
        /*
        setState((){
          result = text;
        });*/
      //setState is not defined hatasi aliyorum...
    //Bu hatanın sebebi çok net:
      //setState sadece StatefulWidget’in State sınıfının içinde vardır.
      //Sen calcBtn fonksiyonunu class’ın dışında (global) yazmışsın. O yüzden orada setState yok → “setState is not defined”.
      //Çözüm 1 (en temiz): calcBtn’a callback ver,calcBtn içinden setState çağırma.
      // Onun yerine onTap diye bir fonksiyon parametresi al, setState’i _CalcState içinde çalıştır.

    child: Container(
      width: isWidth2Size ? 100 : 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isLastCol ? Colors.orange : isFirstRow ? Colors.black54 : Colors.black38,
        borderRadius: (isWidth2Size) ?  BorderRadius.only(bottomLeft:Radius.circular(5)) : isLastItem ? BorderRadius.only(bottomRight:Radius.circular(5)) :  BorderRadius.zero,
        border: Border(
          left: const BorderSide(color: Colors.black, width: 1,   strokeAlign: BorderSide.strokeAlignInside,),
          top: const BorderSide(color: Colors.black, width: 1,   strokeAlign: BorderSide.strokeAlignInside,),
          bottom: isLastRow
            ? const BorderSide(color: Colors.black, width: 1,   strokeAlign: BorderSide.strokeAlignInside,)
          : BorderSide.none,
          right: isLastCol
              ? const BorderSide(color: Colors.black, width: 1.3,   strokeAlign: BorderSide.strokeAlignInside,)
              : BorderSide.none,
        ),
      ),
      child: Text(text,
          style: const TextStyle(fontSize: 18, color: Colors.white)),
    ),
  );
}

//labels listesindeki her eleman için bir tane buton (Container) üretip Row içine diziyor. Tek tek 4 tane Container yazmak yerine otomatik yapıyor.
//Widget buildRow(List<List<String>> rows, List<String> labels,  {required bool isLastRow, required bool isFirstRow,required void Function(String value) onKeyTap,
Widget buildRow(List<List<String>> rows, List<String> labels,
    {required bool isLastRow, required bool isFirstRow,required void Function(String value) onKeyTap,}
    ) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(labels.length, (i) {
     // print("i:${i}");
     // print("labels[i]: ${labels[i]}");
     // print("isLastCol: ${ i == labels.length - 1}");
     // print("isLastRow: ${isLastRow}");
     // print("labels: ${labels}");//her bir satirdaki stringleri temsil eder sira ilee yani rows un item idir   ["AC", "C", "%", "÷"],
     // print("rows: ${rows}");//rows:[ ["AC", "C", "%", "÷"], ["7", "8", "9", "×"], ["4", "5", "6", "−"],  ["1", "2", "3", "+"], ["0", ".", "=", "⌫"],
      return calcBtn(
          labels[i],//bu da sira ile satir satir o satirdaki elemanlari verir, sira ile, AC, sonra C, %,÷, 7, 8,..
          isWidth2Size: isLastRow && i == 0,//En alttaki satirdaki ilk eleman 0 2 tane kutu yerini alacak
          isLastItem: i == labels.length - 1 && isLastRow,
          isLastCol: i == labels.length - 1,//her bir satirin son elemani gelince true olur..yani en sagdaki elemanlar icin true dur..
          isLastRow: isLastRow,//Bu da rows icindeki satir dizilerinden en alttaki en son dizi geldiginde o dizinin her elemani icin true gelir
          isFirstRow: isFirstRow,
          onTap: () => onKeyTap(labels[i]),
      );
    }),
      );
}

class Params {
  bool isLastRow;
  bool isFirstRow;
  void Function(String value) onKeyTap;

  Params({required this.isLastRow,required this.isFirstRow, required this.onKeyTap});

}
  /*
  lib/calculator/calc.dart:99:4: Error: Can't find '}' to match '{'. }) {  ^
  * */
  /*
  SORU:baksana simdi burdaki diktortgendeki cizgilerin hepsi left: const BorderSide(color: Colors.black, width: 1),
  border: Border( left: const BorderSide(color: Colors.black, width: 1), top: const BorderSide(color: Colors.black, width: 1),
   bottom: isLastRow ? const BorderSide(color: Colors.black, width: 1) : BorderSide.none,
   right: isLastCol ? const BorderSide(color: Colors.black, width: 1) : BorderSide.none, ),
   yani with 1 color black...ki teyitte ettim renkleri degistirdim..hatta widthi arttirarak test ettim...
   ve hepsi dogru ayni width 1 black...ama neden mesela bazilar daha kalin bazilari daha silik sanki yokmus gibi gozukuyor burdan bakinca...

  Bu gördüğün şey “kodda hepsi width:1 ama ekranda bazı çizgiler ince/silik” olayı genelde Flutter’ın çizgiyi (stroke’u)
   anti-alias ile boyaması + piksel hizası (devicePixelRatio) yüzünden oluyor.
   Yani çizgi mantıksal olarak 1 ama bazı yerlerde çizgi tam fiziksel piksele oturmadığı için
   yarım piksel gibi “bulanık / daha açık” görünüyor. Özellikle:

   Border çizgisi kenarın tam üstüne değil, stroke’un merkezi kenara gelecek şekilde çizilir (yarısı içeride, yarısı dışarıda).
   Layout’ta bazı şeyler .5 gibi kırıklı koordinatlara denk gelirse çizgi anti-alias ile yumuşar → silik görünür.
   Dıştaki rounded corner / clip da kenarları anti-alias’layıp bazı çizgileri daha “soft” gösterebilir.
   Aşağıda bunu düzeltmek için en pratik 2 sağlam yöntem var:

  Kısa teşhis: Senin ekran görüntünde neden bazıları daha silik?
Büyük ihtimalle bazı çizgiler tam piksele oturmuyor (özellikle üstte “0” display alanı, yuvarlatılmış dış border vs. ile birleşince).
Ayrıca dış container’da radius varsa, köşe ve kenar çizgileri anti-alias’a girer.

Tamam, bunu çok somut anlatayım. “Stroke” dediğim şey çizginin kendisi (kalem izi). Flutter bir border çizerken aslında “kalem” gibi düşün: o kalemin kalınlığı width.

1) “Stroke’un merkezi kenara gelir” ne demek?

Bir kutunun kenarı var ya (tam sınır çizgisi). Flutter border’ı genelde şöyle çizer:

width: 1 ise, o çizgi 1 birim kalınlıkta bir şerit.

Bu şeridin tam ortası kutunun kenarına denk getirilir.

Yani çizginin yarısı içeride, yarısı dışarıda kalır.

ASCII ile:

KUTUNUN KENARI (sınır) -> |
Border width=1 çizgi  -> [===]
                         ^ merkez |'e oturuyor

                         Sorun nerede?
Eğer o | çizgisi ekranda tam piksel çizgisine denk gelmiyorsa (0.5 gibi),
 çizginin yarısı bir pikselin üstüne, diğer yarısı diğer pikselin üstüne dağılır. Bu da gözümüze “silik/blur” görünür.

 2) Piksel hizası olayı (neden bazı çizgiler daha silik?)

Telefon ekranı “fiziksel piksel”lerle çiziyor. Flutter’da ise ölçüler “logical pixel” (dp).
Aradaki çeviri devicePixelRatio ile olur.
Örnek:

devicePixelRatio = 2.75 gibi “kırıklı” bir değer olabilir.

Sen width: 50 dersin → bu bazen fiziksel piksele tam bölünmeyebilir.

Sonuç: bazı kutuların kenarı x=100.0 yerine x=100.5 gibi bir yere düşebilir.

İşte o zaman 1px çizgi tam pikselin üstüne oturmaz → anti-alias devreye girer → çizgi “gri/silik” gibi görünür.

Basit analoji

Tam piksele oturan çizgi: net siyah çizgi
3) Neden bazıları kalın, bazıları ince gibi?

Sen diyorsun ki “hepsi width 1”. Doğru. Ama:

Bazıları piksele tam oturuyor → net siyah

Bazıları yarım pikselle kayıyor → daha açık/silik

Bu yüzden “bazıları kalın” gibi algılanıyor aslında “bazıları daha net”.

Silik duran yerleri  right: const BorderSide(color: Colors.black, width: 1.3,   strokeAlign: BorderSide.strokeAlignInside,),
 bu sekilde..ekstra fazladan width verince daha normal diger width 1 i  olup da silik gozukmeyen yerler gibi oluyor
  * */

