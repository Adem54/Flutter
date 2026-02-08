import 'package:dart_tutorial1/obj_oriented/product.dart';

void main()
{
  var product1 = Product(firstName:"Pc",title:"NewPc",price:100);

  var product2 = Product.onlyFirstName("Ipad");

  var product3 = Product.onlyTitle("NewIpad");

  var product4 = Product.onlyNameAndTitle("Bike", "Bmx");
}