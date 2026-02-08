void main()
{
  //1.Sayisaldan sayisala donusum..
  //int dan double a donusum
  //Risk yuksektir dikkat li olmakta fayda var..
  //2.Sayisaldan texte donusum
  //3.Metinden sayisala donusum
  //2,3 u cok fazla kullaniriz..en kolay yapilabilen 2.sayisaldan texte donusumdur
  //toDouble(), toInt(), toString(), int.parse(), double.parse()
  //TUM PLATFORMLARDA ARA YUZ UZERINDEN BIR VERI GIRILMESI OKUNMASI VS BUNLAR STRING OLUR..
  // AMA TABI KI BAZEN INTEGER DEGER GIRILIER ORAYA AMA STRING OLARAK ALINACAGI ICIN BIZIM BUNU INTEGER A CEVIRMEMIZ GEREKIR
  //DIKKAT BIR DEGERI ARAYUZDE YAZDIRIP GOSTERCEGIMZ ZAMANDA INTEGER OLARAK YAZDIRAMIYOIRUZ STRING OLARAK YAZDIRMAMIZ GEREKIYOR
  //BUNDAN DOLAYI BIZIM COK SIK, STRINGDEN INTEGER A, INTEGERDAN STRINGE DONUSUM YAPMAMIZ GEREKIYOR

  //int to double - double to int
  int i= 56;
  double d = 78.67;

  int result1 = d.toInt();
  double result2 = i.toDouble();

  print("result1: $result1");//78..78.67 den 78 e dusurerek verdi kusurati sildi..bu cok ciddi bir kayip..direk siliyor cunku...yuvarlama yapmiyor
  //seal-flor ile yukari asagi yuvarlama yapiyor...Ama price gibi hassas degerlerde dikkat edelim..bu buyuk bir kayip olabilir
  print("result2: $result2");//56.0 olarak veriyor burda herhangi bir kayip olmuyor

  int myNumber = 45;
  String result3 = myNumber.toString();//"45" olacaktir
  String result4 = d.toString();//"78.67" ye donusur..

  String text1 = "25";
  String text2 = "51.45";

  int result5 = int.parse(text1);
  double result6 = double.parse(text2);
  print("result5: $result5");
  print("result6: ${result6}");

  String text3 = "my Text";
  int result7 = int.parse(text3);

  var input="12";
  int number = int.parse(input);
  int calc = number * number;
  print(calc);
  String result = calc.toString();
  print(result);
}