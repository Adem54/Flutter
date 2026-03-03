
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persons_app/data/repo/persons_dao_repostory.dart';

class DetailPageCubit extends Cubit<void> {
  DetailPageCubit():super(0);//void oldugu icin parmetreye 0 verip geceriz yoksa hata aliyrouz

  var personDaoRepo =  PersonsDaoRepostory();
  Future<void> Update(int id,String name, String phone) async
  {
    await personDaoRepo.Update(id, name, phone);
  }

}

/*
* detailpage de update butonu var tetiklenen ve update butonum yaptigi is input-texfieldda
* update icin girilen name,tel datlarini alip veritabanindan guncellemek ama detail_page de
* update butonuna tiklandiktan sonra return edilen ui da gosterilecek olan bir data yok,
*  sadece veritabaninda update islemi yapilacak o zaman retrn void olacak, emit olmaycak,
*  user interface update methodu invoik edildiginde return edilip de emmit ile ui a ya
*  tekrar gonderilecek bir dataya ihtiyac yok o zaman
*
* */