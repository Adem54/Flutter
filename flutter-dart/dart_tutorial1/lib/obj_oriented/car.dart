class Car
{
  //Class isimleri buyuk harfle baslamalidir
  //Class ve obje
  //Class bir taslak, model imiz olyor ondan urettgimz ornek lerede object-nesne diyoruz

 // String? color;//nullable hatasini boyle de kaldiraibliyorz
  //late String color;//late ile ben color i daha sonra tanimlayacagim da diyebilirz ve nullable hatasi vermeyi birakir
 // int? speed;
  //late int speed;
 // bool? isWorking;
  //late bool isWorking;//late ile daha sonra tanimlayacagim derssek nullable hata vermeyi birakir
  //C# daki nullable mantigi burda da var...

//Simdi yukardaki late de ? de ideal cozum deildir, nullable icin ondan dolayi biz simdi asagida ideal olan constructor olusturarak nullable hatasini cozmus olacagiz
//Olmasi gereken de budur
  String color;
  int speed;
  bool isWorking;

  //Mouse ile saga tiklayip GEnerate dersek ve constructor der ve de 3 properties veya fields i da secersek o zaman artik bize nullable hatasi vermeyi birakacaktir..
  //Ve ideal nullable hatasini cozme mantigmizda dart ta bu sekildedir...
  Car({required this.color, required this.speed, required this.isWorking});
  //Bu yapi constructor dir veya buna biz init mehtodu da diyebiliriz...bu ilk olarak calisacak methjod budur class new lendiginde
  //required, Zorunlu yapar fieldlarin instance olustururken verilmesini (compile-time hata verir)
//Kod okunabilirliğini artırır (hangi alanların şart olduğunu net gösterir)
  //Baslarina required eklersek o zaman bu class tan nesne, obje olustururuken, instance olustururken,
// bu field larinda basina gelmesini sagliyor daha anlasilir olmus oluyor..ve bu sekilde daha ideal dir kullanmak
//Create car instance
//var bmw = new Car(color:"Blue",speed: 120,isWorking: true);

  void showAllValues()
  {
    print("Color: ${color}");
    print("Speed: ${speed}");
    print("IsWorking: ${isWorking}");
  } //this olmadan da kullanilabilir, this kullanarak da kullanilabilir..C# dakki gibi

  void setValues(var color, var speed, var isWorking)
  {
    this.color = color;
    this.speed = speed;
    this.isWorking = isWorking;
  }

  void runTheCar()//Side effect..cunku class in field larini degismesine sebep oluyor
  {
    isWorking = true;//this kullanmadan da field lara class icinde atama yapabiliyoruz..., this kullanadabiirz kullanmasak da olur
    speed = 100;
  }
  void stopTheCar()
  {
    isWorking = false;
    speed = 0;
  }

  String getColor()
  {
    return this.color;
  }

  int getSpeed()
  {
    return this.speed;
  }

  bool getIsWorking()
  {
    return this.isWorking;
  }

  void setColor(String color)
  {
    this.color = color;
  }
  void setSpeed(int speed)
  {
    this.speed = speed;
  }
  void setIsWorking(bool isWorking)
  {
    this.isWorking = isWorking;
  }

  void increaseSpeed(int speedToIncrease)
  {
     speed+=speedToIncrease;
  }

  void decreaseSpeed(int speedToDecrease)
  {
    speed-=speedToDecrease;
  }
}