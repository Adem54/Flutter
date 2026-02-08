void main()
{
  //1.Compile error
  String x = "hello";
  //x = 12;//Bu compile error string bir degeere int atamaya calisrsak, yani type lar le igli hatalar ve run etmeden once karsilasaacagimiz hatalar

  //2.Run time de karsilsacagimz hatalar
  var list = <String>[];
  list.add("Adem");
  list.add("Zeynep");

  //Ama try-catch sayesinde hatayi biz goreiblme imkani buluruz log a vs yazarak,
  // ve de uygulamada aynmi zamanda cokmemis kirilmamis olur..kullaniclar islem yapaiblmeye devam eder
  try
  {
    String name = list[3];//3.index bulunmuyor ama biz almaya claisyourz iste bu run time da patlar, uygulamayi kirar..problem bu uygulama coker...
    print("name: ${name}");
  }catch(e)
  {
    print("No data exist in that index");//Artik evet uygulama patlamak yerine bu hata mesajin gosterir cunku catch icerisine dustu uygulama...
  }
}