import 'dart:collection';

void main(){

  var numbers = {"one":1,"two":2};//boyle tanimlanabilir ya da
  var cities = HashMap<int,String>();

  cities[16] = "Amsterdam";
  cities[5] = "Brussel";
  cities[0] = "Skien";
  cities[1] = "Porsgrunn";
  //Update
  cities[0] = "New Skien";
  String city1 = cities[1]!;//nullable durumunda dolayi ya deger sonuna  cities[1]! koyariz, ya da String? city1
  //A value of type 'String?' can't be assigned to a variable of type 'String'
  //Nullable dan kurtarmanin yolu ya String?, ya da ! koyaiz deger sonunba

  //Lenght-isEmpty
  print("cities-length: ${cities.length} - isEmpty: ${cities.isEmpty}");

  //for-each ile dongureilim
  var keys = cities.keys;
  for(var a in keys)
    {
      print("$a  -> ${cities[a]}");
    }

  //Remove edelim
  cities.remove(0);
  print("cities: ${cities}");

  cities.clear();
  print("cities2: ${cities}");
}