import 'package:dart_tutorial1/dart_extra_topics/boxSize.dart';

void main()
{
  //Enum..ile biz string i gidip direk yazmak yerine Enum sayesinde eger secim sayisi 2 den fazla ise
  // o zaman bunlari enum yaparak kullaniriz ve hata yapmak ten kurtulmus oluruz...
  //seedColor: Colors.deepPurple), bu ornegin main.dart icinde Enumeragble dir..
  calcPrice(BoxSize.middle, 5);
  calcPrice(BoxSize.big, 8);
}

void calcPrice(BoxSize _size, int quantity)
{
  switch(_size)
  {
    case BoxSize.small:
      print("Cost-Amount: ${quantity * 10}");
      break;

    case BoxSize.middle:
      print("Cost-Amount: ${quantity * 20}");
      break;

    case BoxSize.big:
      print("Cost-Amount: ${quantity * 30}");
      break;
    default:
      print("Cost-Amount: ${quantity * 20}");
      break;
  }
}