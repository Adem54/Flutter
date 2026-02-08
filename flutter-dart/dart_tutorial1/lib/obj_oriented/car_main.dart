import 'package:dart_tutorial1/obj_oriented/car.dart';

void main()
{
  //Create car instance
   var bmw = Car(color:"Blue",speed: 120,isWorking: true);
   /*print("Color: ${bmw.color}");
   print("Speed: ${bmw.speed}");
   print("IsWorking: ${bmw.isWorking}"); */
   bmw.showAllValues();
   //DEgerlerini daha sonradan da degistirebildik bu hali ile class ta tanimlandiginda...yani write yapabiliyorz..
   /*bmw.color = "Yellow";
   bmw.speed = 130;
   bmw.isWorking = false; */
   bmw.setValues("Yellow", 130, false);
   //fieldlar i read yapabiliyurouz burda da
   /*print("Color: ${bmw.color}");
   print("Speed: ${bmw.speed}");
   print("IsWorking: ${bmw.isWorking}"); */
   bmw.stopTheCar();
   bmw.increaseSpeed(50);
   bmw.showAllValues();
   print("*******************************************");
   var toyota =  Car(color:"White",speed:110, isWorking:  true);
   //Dart ta new de yazsak yazmasak da Car class indan obje-instance olusturulmasinda birsey degismez ikisi de gecerlidir ayyni isi yapar
   /*
   print("Color: ${bmw.color}");
   print("Speed: ${bmw.speed}");
   print("IsWorking: ${bmw.isWorking}"); */
   toyota.showAllValues();
   //DEgerlerini daha sonradan da degistirebildik bu hali ile class ta tanimlandiginda...yani write yapabiliyorz..
   /*bmw.color = "Red";
   bmw.speed = 100;
   bmw.isWorking = false; */
   toyota.setValues("Red", 100, false);
   //fieldlar i read yapabiliyurouz burda da
   /*print("Color: ${bmw.color}");
   print("Speed: ${bmw.speed}");
   print("IsWorking: ${bmw.isWorking}"); */
   toyota.showAllValues();
   toyota.increaseSpeed(30);
   toyota.showAllValues();

   print("-----------------------------------------");

}