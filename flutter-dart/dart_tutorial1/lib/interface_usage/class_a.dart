import 'package:dart_tutorial1/interface_usage/myinterface.dart';

//override keywordu ile kullanmak zorundayiz...
class classA implements MyInterface {
  @override
  int variable1  = 19;

  @override
  void method1() {
    // TODO: implement method1
    print("mehtod1 is working");
  }

  @override
  String method2() {
    // TODO: implement method2
    return "Mehtod2 is working";
  }

}