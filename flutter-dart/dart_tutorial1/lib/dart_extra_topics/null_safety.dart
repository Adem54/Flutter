void main()
{
  //Null safety..Uygulamanin kirilmasina sebep olabilen hatalara sebep olabilryor.
  //Bir degisken veya fonsk sonucu null, obje null olabiliyor..bu durumda ne yapacagini bilemedigi icin kendisini kapatiyor
  //Uygulamlarin cokmesine sebep oldugu icin null-safe denilen ekstra null kontrolunu yapan sistemler gelistirilmistir..bunlar nasil kullaniliyor dartta bakalim
  //Nullable-Null Safety-Optional(Swift) diye de duyulabilir
  //null:nil(Swift):Nan swiffte de bu sekiklde karsimiza cikabilir

  String str = "Hello";
  //String message = null;//string turunu verdik ve null yapmak istiyoruz..ama null u direk atayamayiz...
  //Ama null yapacaksak o zaman nullable yapmaliyiz..yani String? message = null; yapabiliriz
  String? message = null;

  var strUpperCase = str.toUpperCase();//Hatasiz bir sekilde gerceklestirdi

  message = "How are you";
  //1.yontem ? ile nullable kontrolu yapmak
  var messageUpperCase = message?.toUpperCase();//The method 'toUpperCase' can't be unconditionally invoked because the receiver can be 'null'.
  //Yani null olma ihtimali oldugundan dolayi toUpperCase kullanirken de ayni javascriptteki optional chainin deki gibi ? isaret i ile kullanirsak eger ki null ise hic toUpperCase()
  //methiodunu cagirmaz ve bizde....bu sekilde hatasiz hallederiz
  //Bu ? sayesinde uygulamanin cokmesini engellemis oluyor coook kritiktir kullanmak...uygulamayi cokmekten kurtarir..

  //2.yontem: ! kullanarak nullable durumunun handle edilmesi
  //var messageUpperCase = message!.toUpperCase();//The '!' will have no effect because the receiver can't be null.
  //! kullanark diyor ki developer ok sen bana guven ben ne yaptigmin farkindayim, bunun null olmayacagini sana garanti ediyiorum...
  //Yani ! kullanimi tehlikelidir, ama bazi durumlarda vardir ki bir degiskenimiz oyle bir durumda ki kesinlikle null olma ihtimali yok ve biz de
  //null olma ihtimalinin getirdigi ekstra islemlerden veya hata mesajlari vs bunlarla ugrasmak istemyoruz ama net 100% eminiz degisken null olamaz...
  // iste boyle durumlarda biz yazilimci olarak inisittif alrak ! kullanabilirz..
  print("messageToUpperCase:  ${messageUpperCase}");
  //Burda message a deger atdgimz icin warning verebilir hani sen buna deger atadin ? a gerek yok gibi ama bunu gormezden gelebilriz..

  //3.Yontem null kontrolu
  String? message2 = null;
  message2 = "This is my message";
  if(message2 != null)
  {
     print("uppercase: ${message2.toUpperCase()}");
  }else{
    print("Message is null");
  }
}