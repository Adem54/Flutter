import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> mapControl = Completer();

  //Ilk acildiginda gorunecek konumumuz
  var initialLocation = const CameraPosition(target:  LatLng(59.1746863,9.6254309), zoom:15);
  //ilk konum icin istegimz bir long-lat degerini kullanabilirz
  //Skien-Biltema:59.1746863,9.6254309 16z(zoom)
  //Pors-Bibliotek:59.1412663,9.6542408 16z(zoom)

  //Liste olarak olusturuyoruz cunku birden fazla isaret koyabiriz
  List<Marker> signs = <Marker>[];

  Future<void> goLocation() async {
    GoogleMapController controller = await mapControl.future;
    var theLocWillBeArrived = const CameraPosition(target:  LatLng(59.1412663,9.6542408), zoom:16);
    //CameraPosition dedigi haritanin cercevesi..yani...
    //controlerla da initial location dan hangi konuma gecis yapilacak ise onu belirlemis oluyoruz

    //Gidilecek isaret
    var signToShow = const Marker(markerId: MarkerId("id"),
    infoWindow: InfoWindow(title:"Larvik", snippet:"Larvik-sentrum")
    );//Marker

    setState(() {
       signs.add(signToShow);
    });

    controller.animateCamera(CameraUpdate.newCameraPosition(theLocWillBeArrived));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Map Usage"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //SizeeBox icine aliriz haritayi...ki tum sayfayi kaplamasin, alanini sinirlandirabilelim
          SizedBox(
            width: 500 ,
            height: 400,
            child: GoogleMap(
                initialCameraPosition: initialLocation,
              mapType: MapType.normal,
              markers: Set<Marker>.of(signs),//markeri da bu sekilde eklyebiliriz...Liste olarak geliyor cunku birden fazla isaret koyabiriz
              onMapCreated: (GoogleMapController controller){
                  mapControl.complete(controller);
              },
            ),
          ),
            ElevatedButton(
                onPressed: (){
                  goLocation();
                },
                child: Text("go-location"))
          ],
        ),
      ),
    );
  }
}
