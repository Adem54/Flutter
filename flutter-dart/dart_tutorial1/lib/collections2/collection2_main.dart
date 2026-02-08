import 'package:dart_tutorial1/collections2/person.dart';
import 'package:dart_tutorial1/collections2/student.dart';
import 'package:dart_tutorial1/collections2/teacher.dart';

void main()
{

  IPerson person1 = Student(id: 1, no:112, firstName: "Adem", lastName: "Erbas");
  IPerson person2 = Teacher(id: 2, no:103, firstName: "Zeynep", lastName: "Erbas");
  IPerson person3 = Student(id: 3,no:109, firstName: "Zehra", lastName: "Erbas");
  IPerson person4 = Teacher(id: 4, no:121, firstName: "Sercan", lastName: "Lale");
  IPerson person5 = Student(id: 5, no:100,firstName: "Selma", lastName: "Tayyar");

  var myPersonList = [person1, person2, person3,person4,person5];
  for(var person in myPersonList)
  {
    print("person: ${person.firstName} - ${person.lastName}");
  }

  print("------------------------------------------------------------");

  var myPersonList2 = <IPerson>[];
  var p1 = Student(id: 1, no:45, firstName: "John", lastName: "Dale");
  var p2 = Teacher(id: 2, no:343, firstName: "Kaja", lastName: "Tre");

  myPersonList2.add(p1);
  myPersonList2.add(p2);

  //Bu seklde biz baska bir list i de listemize eklemis olduk
  myPersonList2.insertAll(2, myPersonList);

  for(var p in myPersonList2)
  {
    print("${p.firstName} - ${p.lastName}");
  }


  var studentList = <Student>[];
  List<Student> studentList2 = <Student>[];
  List<Student> studentList3 = [Student(id:3,no:34,firstName: "Serjab", lastName: "Darr")];

  List<Student> studentList4 = <Student>[Student(id:3, no:33,firstName: "Serjab", lastName: "Darr")];


  //SIRALAMA-COMPARE ALGORITMASI FONKS OLUTURUP BUNU PERSONLISTEIMZDE KULLANMAK
  //Siralama algoritmasin fonsk oluturalim ilk once - NO YA GORE KUCUKTEN BUYUGE DOGRU SIRALAMAK
  Comparator<IPerson> sortinAlgFunc = (x,y)=>x.no.compareTo(y.no);//2 recordu karsilastiryor dikkat edelim...id ler uzerinden

  //NO YA GORE BUYUKITEN KUCUGE DOGRU SIRALAMA...
  Comparator<IPerson> sortinAlgFunc2 = (x,y)=>y.no.compareTo(x.no);


  //METNINSEL OLARAK A DAN Z YE

  Comparator<IPerson> sortinAlgFunc3 =  (x,y)=>x.firstName.compareTo(y.firstName);
  myPersonList.sort(sortinAlgFunc3);

//METNINSEL OLARAK Z DEN A YA
  Comparator<IPerson> sortinAlgFunc4 =  (x,y)=>y.firstName.compareTo(x.firstName);
  myPersonList.sort(sortinAlgFunc4);


  for(var per in myPersonList)
  {
    print("per-id: ${per.id} -per-no: ${per.no} -- perfirstname: ${per.firstName}");
  }

  print("*************************FILTEREDLIST***************************************");
  //FILTRELEME ISLEMLERI..
  Iterable<IPerson> filterAlgFunc1 = myPersonList.where((person)=>person.no > 100 && person.lastName=="Erbas");

  List<IPerson> filteredList1 = filterAlgFunc1.toList();//myPersonList den aldigmz verilerle baska bir liste olustuurlmus oluyor dikkat edelim...

  var filteredList2 = filteredList1.toList();//myPersonList den aldigmz verilerle baska bir liste olustuurlmus oluyor dikkat edelim...

  //String-text icerisinde "Se" olanlari filtrele
  Iterable<IPerson> filteredList3 = myPersonList.where((person)
  {
    return person.firstName.contains("Se");
  });

  var filteredList33 = filteredList3.toList();
  for(var per in filteredList33)
  {
    print("per-id: ${per.id} -per-no: ${per.no} -- perfirstname: ${per.firstName}");
  }


}