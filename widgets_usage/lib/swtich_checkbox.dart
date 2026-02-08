import 'package:flutter/material.dart';

class SwtichCheckbox extends StatefulWidget {
  const SwtichCheckbox({super.key});

  @override
  State<SwtichCheckbox> createState() => _SwtichCheckboxState();
}

class _SwtichCheckboxState extends State<SwtichCheckbox> {
  //switch-checkbox variables
  bool switchControl = false;
  bool checkboxControl = false;
  bool isShow = false;

  //radio-btn icin
  int? selectedClub = 0;//0 vererek ilk default olarak hicbirisi secilmis olmasin,1:Barcelona, 2:RealMadrid
  bool progressControl = false;
  double sliderProgress = 30.0;

  //Bunlari kalender icin kullanacagiz...
  var tfHour = TextEditingController();
  var tfDate = TextEditingController();

  //dropdownlist variables
  var countyrList = <String>[]; //noktali virgulu sil geri yaz hata ortdan kayboluyor...alti cizili hata vs gosteriyor bazen gereksiz yere
  String selectedCountry = "Norway";//Varsayilan olarak selected country norway olsun

  //Flutter da ekran geldiginde, ekran gelir gelmez enddpointten-database den  veri alip ui da gosterme veya
  // okuma veri listeleme islemleri initstate methodu icerisinde yazilir hemen burda,
  // zaten init yazarsak otomatik kendsi initState override nmlethodunu getirecektir
  //Bundan dolayi bunu simulet etmek icin bizde bos countryList i olusuturup initState icerisinde icerisine degerler aktaracagiz...
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countyrList.add("Norway");
    countyrList.add("Denmark");
    countyrList.add("Finland");
    countyrList.add("Izland");
    countyrList.add("Italy");
  }//kapanma suslu parantezini silip geri yazarsak gelen hata gidyor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text("SwitchCheckbox")),
      //simdi Row u SizedBox ile wrap yapmak icin Row u sectim ve alt-enter yapip wrap sizedbox dedim..Cunku dikkat edelim
        //size i ekrani tamamen yatayda kaplamasin ve ben yatay-ve-dikey de size ini kontrol edebileyim isitorum ondan dolay
        //SizedBox ile wrap yapiyorum!!!
        body: SingleChildScrollView( //Ekran da kullanilan bazi widget larin ekrana sigmamasi ve ekranin dogal boyutunu asmasi sonucu ortaya cikan hatayi scroll ekleyerek cozer...
          child: Center(
            child:Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //SwitchListTitle-slider imiz in bizim istedigmz kadar yer kaplamasi icin,
                    // bunu herzamanki gibi boyle durumlarda Sizedbox icine alip,width,heigh veriyorduk..o zaman SwitchListTile secip
                    //sonra wrap SizedBox deriz ve sonra da widht-heigh vererek alani istedgimz gibi sinirlandirabiliriz
                    SizedBox(
                      width: 200,
                      child: SwitchListTile(
                          title: const Text("Dart!"),
                          //Dart yazisi sagda, slider iconu ise solda olmaisni istorum...switch demek burda kucuk slider lar varya tikliyoruz
                          //slider true oluyor, tikliyoruz false olyor ya....
                          controlAffinity: ListTileControlAffinity.leading,//slider iconu solda olsun diyoruz bu sekilde ve Dart yazisi da sagda oluyor
                          value: switchControl,
                          onChanged: (data){
          
                            //parametreden data yi getirecek...true-false durmunu getirecek bize..dikkat edelim..
                            setState(() {
                              print("slider-is-triggered! ${data}");
                              switchControl = data;
                            });
                          }),
                    ),
                    //Checkbox da bu slider-SwitchListTile ile ayni mantikta yaziliyor
                    SizedBox(
                      width: 200,
                      child: CheckboxListTile(
                          title: const Text("Flutter!"),
                          //Dart yazisi sagda, slider iconu ise solda olmaisni istorum...switch demek burda kucuk slider lar varya tikliyoruz
                          //slider true oluyor, tikliyoruz false olyor ya....
                          controlAffinity: ListTileControlAffinity.leading,//slider iconu solda olsun diyoruz bu sekilde ve Dart yazisi da sagda oluyor
                          value: checkboxControl,
                          onChanged: (data){//veri geliyor ama checboxda gelen veri nullable geliyor yani null olablir
                            // ondan dolayi data nin sonuna ! koyarak bunu cozeriz-switchControl = data!;
                            //parametreden data yi getirecek...true-false durmunu getirecek bize..dikkat edelim..
          
                            setState(() {
                              print("checkbox-is-triggered! ${data}");
                              checkboxControl = data!;
                            });
                          }),
                    )
                  ],
                ),
                //Burda ElevatedButton a tiklayinca slider ve checkbox statusu ekrana basalim!!!
                ElevatedButton(
                    onPressed: (){
                      //Sunu hicbirzaman unutmayalim, setState icerisinde yapmazsak build gerceklesmez
                      // ve biz yaptimgz degiskligin etkisini goremeyiz
                      setState(() {
                        isShow = !isShow;
                      });
                    },
                    child: const Text("show",style: TextStyle(color:Colors.orange))
                ),
                Text(isShow ? "slider is ${switchControl} and checkbox is ${checkboxControl}" : ""),
          
                //Radio button icin tekrar bir row olusutyoruz...Radio button birden fazla secenek icerisinden
                // tek secim yapilma durumunda kullanilir genellikle -married-or-not..2 veya daha fazla secim arasindan 1 secim...
                // checkbox  bildigmz gibi bircok secenek arasindan birden fazla secim yapmak istedgimzde kullaniyorduk
                RadioGroup<int>(
                  groupValue: selectedClub,
                  onChanged: (val) {
                    setState(() {
                      selectedClub = val;
                      print("radio selected: $val");
                    });
                  },
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //RadioListTile- imiz in bizim istedigmz kadar yer kaplamasi icin,
                      // bunu herzamanki gibi boyle durumlarda Sizedbox icine alip,width,heigh veriyorduk..o zaman SwitchListTile secip
                      //sonra wrap SizedBox deriz ve sonra da widht-heigh vererek alani istedgimz gibi sinirlandirabiliriz
                      SizedBox(
                        width: 200,
                        child: RadioListTile<int>(
                            title: const Text("Barcelona!"),
                            //Dart yazisi sagda, slider iconu ise solda olmaisni istorum...switch demek burda kucuk slider lar varya tikliyoruz
                            //slider true oluyor, tikliyoruz false olyor ya....
                            controlAffinity:ListTileControlAffinity.leading,
                            value: 1,
                            //groupValue: 1,//groupValue is depreceated and shouldn't be used.Use a RadioGroup anchestor to manage group value...
                            //onChanged: (data){//onchange is depreceated and shouldn't be used
                              //Bu iki depreceated olan lara vs bakacagiz..ok
                              //yeni Flutter sürümlerinde (3.32+ pre’den sonra) Radio / RadioListTile içindeki groupValue ve onChanged deprecate edildi.
                              // Yerine artık bir üstte RadioGroup kullanman bekleniyor
                              //parametreden data yi getirecek...true-false durmunu getirecek bize..dikkat edelim..
                            ),
                      ),
                      //
                      SizedBox(
                        width: 200,
                        child: RadioListTile<int>(
                            title: const Text("RealMadrid!"),
                            //Dart yazisi sagda, slider iconu ise solda olmaisni istorum...switch demek burda kucuk slider lar varya tikliyoruz
                            //slider true oluyor, tikliyoruz false olyor ya....
                            controlAffinity: ListTileControlAffinity.leading,//slider iconu solda olsun diyoruz bu sekilde ve Dart yazisi da sagda oluyor
                            value: 2  ,
                            //onChanged: (data){}//veri geliyor ama checboxda gelen veri nullable geliyor yani null olablir
                              // ondan dolayi data nin sonuna ! koyarak bunu cozeriz-switchControl = data!;
                              //parametreden data yi getirecek...true-false durmunu getirecek bize..dikkat edelim..
                            ),
                      )
                    ],
                  ),
                ),
                Text(selectedClub == 1 ? "Barcelona is selected-radio ${selectedClub} " : selectedClub == 2 ?
                "RealMadrid is selected-radio ${selectedClub}"  : "No radiobutton is choosen ${selectedClub}"),
                //PROGRESSBAR-SPINNER
                //Simdi de progress-bar ornegin..Start butonuna basinca baslasin, Stop butonuna basinca durdursun
                //Progress in visibilitysini degistireegiz..ondan dolayi da bool deger kullanacagiz
                Padding(
                  padding: const EdgeInsets.only(top:18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: (){
                            //Sunu hicbirzaman unutmayalim, setState icerisinde yapmazsak build gerceklesmez
                            // ve biz yaptimgz degiskligin etkisini goremeyiz
                            setState(() {
                              progressControl = true;//Progressbar i baslatmak istedimgzde true atariz progressControle burda
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6), // <-- az radius
                            ),
                            backgroundColor: Colors.blue
                          ),
                        child: const Text(
                          "Start",
                            style:TextStyle(color:Colors.white)
                        ),
                      ),
                      //Progress-bar-progressControl
                      //CircularProgressIndicator bu spinner gibi progressbar i temmsil eder, Visiblity yi eklrken CircularProgressIndicator seceriz
                      // ve wrap widget deriz ve oraya Visibility yazariz..cunku wrap listesnde visibility gelmiyor...kendimiz yazmamiz gerkiyor
                      //
                      Visibility(
                          visible: progressControl,//iste visibile olmayi progressControl bool degiskenimz uzerinden kontorl edecegiz
                          child: const CircularProgressIndicator()
                      ),
                      ElevatedButton(
                        onPressed: (){
                          //Sunu hicbirzaman unutmayalim, setState icerisinde yapmazsak build gerceklesmez
                          // ve biz yaptimgz degiskligin etkisini goremeyiz
                          setState(() {
                            progressControl = false;//Progressbar i durdumrak istedimgzde false atariz progressControle burda..
                            // ki visible i false olur ve gozukmez
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6), // <-- az radius
                          ),
                            backgroundColor: Colors.blue
                        ),
                        child: const Text(
                          "Stop",
                          style:TextStyle(color:Colors.white)
                        ),
                      ),
                    ],
                  ),
                ),
                //slider..kaydirdikca bize double sayi uretecek..saga dogru artacak, sola dogru azalacak
                //sliderProgress
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //silip tekrar yazinca bazi hatalar gidebiliyor....
                  //Text lerin icerisine string deger vermemiz gerekir ondan dolayi toString diyerek stringe cevirmemiz gerekiyor
                  Text(sliderProgress.toString()),
                  Text(sliderProgress.toInt().toString()),
                  //Eger kusurati almak istemezsek sliderProgress.toInt().toString() yapariz
                  // ve artik ondalikli kisim gelmez o zaman
                  Slider(
                    value:sliderProgress,
                    min: 0,
                    max: 100,
                      //onChanged:(){})
                  //Hata aliyoruz Slider in onChanged fonks da Neden;Slider’ın onChanged parametresi double alan bir fonksiyon ister:
                  //Tipi: ValueChanged<double> yani void Function(double value)Sen ise şunu yazmışsın:onChanged: () { ... }   // ❌ parametresiz void Function()
                  //Bu yüzden “void Function() assign edilemez” hatası geliyor.
                onChanged: (double value) {
                  setState(() {
                    sliderProgress = value;
                    print("sliderProgress: ${sliderProgress} ");
                  });
                },
                    //onChanged: (value) => setState(() => sliderProgress = value),
                  ),
                ]
              ),
          
                //Kalender kullaniminida buraya ekleyelim!!
                //tfHour ve tfDate e TextEditingController(); a, bagladik...kalender icin..textField kullanaagiz cunku
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children:
                 [
                   //Simdi bizim bu hour Textfield inin kapladigii yeri de kontrol etmek istiuyoruz...sinirlamka istiyoruz
                   //o zaman boyle durumlarda ne yapariz..TextField i sec alt-enter ile Wrap Sizedbox ekleriz..
                    SizedBox(
                      width: 120,
                      child: TextField(
                        controller:tfHour,
                        decoration: const InputDecoration(hintText: "Hour"),
                      ),
                    ),
                   //icon a tiklayinca islem olacagi icin, iconbutton kullanilir..
                   IconButton(
                     onPressed: (){
                       //icona tiklaninca saatin goruntulenme islemini iste bu showTimePicker ile yapiyoruz..
                       //initialTime olarak sistemin var olan saatini alacagiz
                       //initialTime a biz..TimeOfDay.fromDateTime(DateTime.now()) verdigmz icin ilk acildiginda sistemin-simulator un saatini alarak gelecektir
                       showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(DateTime.now()))
                           .then((value){
                              //ISTE BURASI BIZE SECILEN HOUR DEGERIJNI VERECEK BIZDE BUNU tfHour.text e atayacagiz.
                         //tfHour.text a atadgimz zaman artik bu ordaki TextField imzin icerisine gelmis olacak secilen hour-minute kismi...
                              tfHour.text = "${value!.hour} : ${value!.minute}";
                              print("tfHour.text is: ${tfHour!.text}");
                              //The property hour can't be unconditionally accessed because the receiver can be "null"..nullable hatasidir bu
                         //Bunu value null olabilir diyor..sen hour cagiriyorsun..iste jscriptte de alip da ? cozdgm hata bura ! ile cozulur
                         //${value!.hour} bu sekilde!!!
                       });
                       //Biryerde hata var ise flutter da onu silip tekrar yazarsak hata kayboluuyor bunu bilelim...onemli..
                     },
                     icon:const Icon(Icons.access_time)
                   ),//sonuna virgul koymadan hata veriyor surekli..
                   //birde icon olusturalim..ki bu icona basinca bu houru ayarlayacagiz..
          
                   //Simdi bizim bu hour Textfield inin kapladigii yeri de kontrol etmek istiuyoruz...sinirlamka istiyoruz
                   //o zaman boyle durumlarda ne yapariz..TextField i sec alt-enter ile Wrap Sizedbox ekleriz..
                   SizedBox(
                     width: 120,
                     child: TextField(
                       controller:tfDate,
                       decoration: const InputDecoration(hintText: "Date"),
                     ),
                   ),
                   //icon a tiklayinca islem olacagi icin, iconbutton kullanilir..
                   IconButton(
                       onPressed: (){
                         showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2030))
                             .then((value){
                                   tfDate.text = "${value!.day} / ${value!.month} / ${value!.year}";
                                   print("tfDate.text is: ${tfDate!.text}");
                         });//yina alti cizili vs birseyler geliyor sadece nokatli virgulleri vs kaldir geri yaz...hatalat cozuluyor!!
                       },
                       icon:const Icon(Icons.date_range)
                   ),//sonuna virgul koymadan hata veriyor surekli..
                   //birde icon olusturalim..ki bu icona basinca bu houru ayarlayacagiz..
          
          
                 ],
               ),
          
                //DROPDOWN MENU--DROPDOWN LIST I UYGULAYACAGIZ...dropdown list icinde ogsterceimiz listeyi en yukarda tanimlariz..
                Padding(
                  padding: const EdgeInsets.only(top:12),
                  child: DropdownButton(
                      value:selectedCountry,
                      icon:const Icon(Icons.arrow_drop_down),
                      items: countyrList.map((country){
                        return DropdownMenuItem(value:country, child:Text(country),);
                      }).toList(),//Bu islem sayesinde biz DropdownMenuItem listesi elde edince artik dropdown listsinde gosterebilecek
                      //onChanged da da secilen ulkeyi alacagiz..
                      onChanged: (chosenCountry)
                      {
                        setState(() {
                          selectedCountry = chosenCountry!;//String? can't be assigned variable of String hatasini chosenCountry! yapark cozeriz-nullable
                          //hata gitmezse noktali virgulu sil geri yaz..
                          print("selectedCountry: ${selectedCountry}");
                          //secilen ulkeyi aliyoruz burda
                        });
                        //Soyle bir hata mesaji aldim ilk calistirinca
                        //DropdownButton's valu:Norway..Either zero or 2 or more..
                        //DropdownMenuItem's were detected with the same value ..see also
                        //Bu hata DropdownButton’ın value’su (Norway) ile items listesindeki değerlerin eşleşmemesinden oluyor.
                        //“DropdownButton’ın value’su: Norway. Ama items içinde Norway değerine sahip tam 1 tane eleman olmalı. 0 tane var (ya da 2+ tane var).”
                        //selectedCountry = "Norway" ama countyrList içine Norway eklememişsin countryList.add("Nowray") i de initialState icinde ekluyeince hatamiz cozuldu
                      }
                  ),
                ),
          
                 //Biz bu sekilde tiklamasi olmayan bir nesneye tiklama yaptiracagiz zaman bu sekilde tek tap, cift tap, ve uzun tap vs gibi gesture lar verebilyrouz...
                 GestureDetector(
                     onTap:(){
                       print("Container tek tiklandi");
                     },
                     onDoubleTap: () {
                       print("Container Cift tiklandi");
                     },
                     onLongPress: (){
                        print("Container uzerine uzun basildi");
                     },
          
                     child: Container(width: 400, height: 500, color:Colors.red)
                     //Asagida ki sinirin altina gecihyor dolayisi ile de 89 px asagidaki sinirin altina gecmis ondan dolayi da biz boyle sari-siyah cizgilerle hata goruntusu aliriz..tasma problemi
                   //Bu hatayi nasl cozeriz bu tasarim ekana buyuk geliyorsa scroll ozelligi vererek cozebilirmiyiz..Bunujn icin scaffold daki body deki Center i secip alt enter yapariz..
                   // body: SingleChildScrollView( child: Center(...Artik sayfayi yukari asagi scrolla kaydirabilyoruz...Tasarim ekranin dogal boyutunu gecmezse zaten scroll ozelligi olmayacak
                   // ama ekran boyutunu gecerse o zaman scroll ozelligi gelecektir
                 ),
             
                //Tiklama ozelligi olmayan gorsele biz tiklayabiliriz bunu da container gibi yapilarda yapabiliyoruz
          
                //Row’un içinde 2 tane “panel” var. Ama Row’a sadece Container koyarsan:
                // Container kendi içeriği kadar yer kaplar
                // kalan alan boş kalabilir
                // veya taşma/ölçüm sorunları çıkabilir
                ///Expanded burada şunu diyor,Row içindeki boş alanı paylaş, panel tam genişlesin.”
            ],
            )
          ),
        )
    );
  }
}
