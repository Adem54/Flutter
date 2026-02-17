class MathematicRepostory {

  ////emit burda calismaz, emitler cubitler icinde calisir
  int sum(String inputNumber1, String inputNumber2){
    int input1 = int.parse(inputNumber1) ?? 0;
    int input2 = int.parse(inputNumber2) ?? 0;
    int sumData = input1 + input2;
    return sumData;
  }


//emit burda calismaz, emitler cubitler icinde calisir
  int  multiple(String inputNumber1, String inputNumber2){
    int input1 = int.parse(inputNumber1) ?? 0;
    int input2 = int.parse(inputNumber2) ?? 0;
    int multipleData = input1 * input2;
    return multipleData;
  }
}