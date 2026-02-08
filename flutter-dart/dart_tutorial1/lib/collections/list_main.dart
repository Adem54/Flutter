void main()
{
  var list = ["apple", "pear","banana"];

  //index ile deger okuma
  print(list[0]);
  print(list[1]);
  print(list[2]);

  list.add("orange");//en sonuna ekler..
  print(list);

  //length i bulabilirz
  print("length: ${list.length}");

  //bos olup olmadiigni sorgulayabiliriz
  bool isListEmpty = list.isEmpty;
  bool isListNotEmpty = list.isNotEmpty;
  print("isEmpty: ${isListEmpty}");
  print("isNotEmpty: ${isListNotEmpty}");

  //for-in ile gosterelim-foreach dongusu de deniyor bu yazima
  for(var fruit in list)
    {
      print("fruit; ${fruit}");
    }

  //hem index, hem de icerigi alabilirz-for dongusu ile
  for(var index=0; index<list.length; index++)
    {
      print("index${index}: ${list[index]}");
    }

  print("reverse-----");
  var myList = list.reversed.toList();
  print("myList: ${myList}");
  //myList: [orange, banana, pear, apple]

  list.sort();//sort bir sey return etmez listenin kendisi icinde sort eder
  print("sorted-list: ${list}");//sorted-list: [apple, banana, orange, pear]

  print("--------------------");
  //index ile eleman-value degistirme
  list[1] = "strawbarry";
  print(list);

  //“Index’i değiştirmek” direkt yapılmaz ama konum değişince index kayar
  var list2 = ["A","B","C"];//index 0,1,2
  list2.insert(1,"X");//1.index e X ekle diyoruz
  print(list2);//["A","X","B","C"];
  // // B artık index 2 oldu (önceden 1'di)

  //Silince index kayar: removeAt
  var list3 = ["A","B","C","D","E"];
  list3.removeAt(1);//index1 deki B yi sil diyoruz burda...
  print(list3);//[A, C, D, E]...artik index1 B degil C oldu

  //Aynı eleman eklenebilir (duplicate serbest)
  var list4 = ["a","b","c"];
  list4.insert(1,"a");
  print(list4);//[a, a, b, c]

  //Sıralama değişince index’ler değişir: sort
  var list5 = [3,2,1,4];
  print("0.INDEX: ${list5[0]}");
  print("1.INDEX: ${list5[1]}");
  print("2.INDEX: ${list5[2]}");
  print("3.INDEX: ${list5[3]}");
  /*
0.INDEX: 3
1.INDEX: 2
2.INDEX: 1
3.INDEX: 4
  * */

  print("*************sort*******************");
  list5.sort();
  print("0.INDEX: ${list5[0]}");
  print("1.INDEX: ${list5[1]}");
  print("2.INDEX: ${list5[2]}");
  print("3.INDEX: ${list5[3]}");
  /*
  0.INDEX: 1
  1.INDEX: 2
  2.INDEX: 3
  3.INDEX: 4
  * */

}