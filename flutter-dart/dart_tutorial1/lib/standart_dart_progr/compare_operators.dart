void main()
{
  print("Compare operations");
  /*
  * ==, !=, ! true yu false, false u true yapar
  * && and, || or
  *
  * */
  int a = 40;
  int b = 50;
  int x = 90;
  int y=80;

  if(a < b)
    {
      print("yes a is smaller then b");
    }
  print("a==b : ${a == b}");

  print("a!=b : ${a != b}");

  print("a>b : ${a > b}");

  print("a>=b : ${a >= b}");

  print("a<b : ${a < b}");

  print("a<=b : ${a <= b}");

  String today = "Friday";

  //Kotlin de switch when olarak bilinir
  switch(today)
  {
    case "Monday":
      print("Today is Monday");
      break;
    case "Tuesday":
      print("Today is Tuesday");
      break;
    case "Wednesday":
      print("Today is Wednesday");
      break;
    case "Thursday":
      print("Today is Thursday");
      break;
    case "Friday":
      print("Today is Friday");
      break;
    default:
      print("Today is not one of the weekdays");
  }
}