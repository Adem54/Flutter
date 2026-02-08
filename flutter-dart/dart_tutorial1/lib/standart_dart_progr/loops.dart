void main()
{
  for(int i=0; i<10; i++)
    {
      if(i != 5)continue;
      print("i: ${i}");
    }

  int number = 10;
  while(number>0)
    {
      if(number == 5)break;
      print("number: ${number}");
      number--;
    }


  for(int i=0; i<10; i++)
  {
    if(i == 3)return;
    print("i: ${i}");
  }
}