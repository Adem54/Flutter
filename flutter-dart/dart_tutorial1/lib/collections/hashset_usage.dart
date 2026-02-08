import 'dart:collection';

void main()
{
  var cities = (["Skien","Porsgrunn"]);
  var plakalar = HashSet.from([16,23,6]);//bastan deger aktarma ozelligi bulunyor
  var fruits = HashSet<String>();

  //assign the value
  fruits.add("cherry");
  fruits.add("banana");
  bool result1 = fruits.add("apple");

  print("result1: ${result1}");//result1 true cunku add ile ekleyebildi...
  print(fruits);//{banana, cherry, apple} dikkat eddelim icerigini karistirarark veriyor

 bool result2 = fruits.add("banana");
  print("result2: ${result2}");//false icerisinde oldugu icin eklmiyor ve false return ediyor eklemedigi icin
  print("-------------------------------");
  print(fruits);//{banana, cherry, apple}...ayni item dan tekrar eklemiyor

  fruits.add("carrot");

  print("fruits: ${fruits}");//{banana, cherry, carrot, apple}...uniqe degil ise ekliyor ama karisk sekilde ekliyor

  //Okuma islemi yapabiliriz
  String fruit1 = fruits.elementAt(2);
  print("fruit1: ${fruit1}");//bu sekilde de bu index de bulunan elemente erisebiliriz

  print("fruit-lenght: ${fruits.length}");
  print("fruit-isEmpty: ${fruits.isEmpty}");

  //for donguleri ile icerigi alabilirz

  for(var fruit in fruits)
    {
      print("fruit!!!: ${fruit}");
    }

  for(var index=0; index<fruits.length; index++)
    {
      print("fruit with index:  index:${index} - ${fruits.elementAt(index)}");
    }//Tabi burda hashset icerigi karistiridgi icin index e cok guvenilmez...

  //Remove item
  fruits.remove("banana");
  print("fruits: *************** : ${fruits}");// {cherry, carrot, apple}

  //cleawr ile de temizleyebilirz
  fruits.clear();
  print("fruits-clear; ${fruits}");//fruits-clear; {}
}