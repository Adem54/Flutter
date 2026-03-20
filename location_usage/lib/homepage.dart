import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  double latitude = 0.0;
  double longitude = 0.0;

  Future<void> getLocationInfo() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location service kapalı");
      return;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Konum izni reddedildi");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Konum izni kalıcı olarak reddedildi");
      await Geolocator.openAppSettings();
      return;
    }
//yukardakiler tamemen test amacli kullanmasak da olur...zorunlu degil yani
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      //bu hassasiyet andoidde 0 a 100 metre, ios da ise 10 metre civarinda , best dersek daha yakin.
      //Ama bu hassasiyet ne kadar yukselirse batarya da o kadar tuketir
    );
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );

    setState(() {
       latitude = position.latitude;
       longitude = position.longitude;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Homepage"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Latitude:${latitude}", style: TextStyle(fontSize: 30),),
            SizedBox(height: 20),
            Text("Longitude:${longitude}", style: TextStyle(fontSize: 30),),
            SizedBox(height: 20),
             ElevatedButton(
            onPressed: (){
              getLocationInfo();
            },
            child: Text("Show-location"))
          ],
        ),
      ),
    );
  }
}
