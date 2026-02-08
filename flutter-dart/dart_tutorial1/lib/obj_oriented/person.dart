class Person {

  late String firstName;
  late String lastName;
  late int age;
  //Eger constructor icerisinde bu fieldlari atamayacaksak o zaman hata almamak icin
  // fieldlari late ile tanimlariz ki dart bizim onlari sonradan atyacaimgzi bilsin ve hata vermesin
  Person(){//bos constructor
      print("Person-constructor");
  }

  //Person(this.firstName) {} bunu tanimlayamiyorz normalde C# da bir constructorin farkli versiyonlarini tanimlyabiiyorduk parametreleri degistirmek sarti ile.ama bu Dart dilinde yok
  //Overloding dart dilinde yok..


  void ShowFields()
  {
    print("FirstName: ${firstName} -  LastName: ${lastName}  -  Age: ${age}");
  }

  String getValue(String name)
  {
    return name;
  }

  //int getValue(int age){return age;}//already defined diye uyari aliriz..overloading yok...bu mantikta C# da biz fonks olusturabiiyorduk
  //Optional positional parameter usage with square brackets([])
  void setFirstName([String newFirstName = "Mehmet"])
  {
    firstName = newFirstName;
  }

  //Named parameter with curly brackets({})
  //It is very common usage in Flutter
  void setLastName({String newLastName = "Erbas"})
  {
    lastName = newLastName;
  }

  String getFirstName()
  {
    return firstName;
  }

}