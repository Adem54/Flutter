import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persons_app/ui/cubit/detail_page_cubit.dart';
import 'package:persons_app/ui/cubit/homepage_cubit.dart';
import 'package:persons_app/ui/cubit/register_page_cubit.dart';
import 'package:persons_app/ui/views/homepage.dart';
import 'package:persons_app/ui/views/homepage2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   // DIKKAT REGISTERPAGECUBIT IMIZI CALISMASI ICIN UYGULAMAMIZA MAINDARTTA ANA MATERIALAPP I
    // BIZIM MultiBlocProvider ILE SARMALAMZM GEREKIYORDU

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>RegisterPageCubit()),
        BlocProvider(create: (context)=>DetailPageCubit()),
        BlocProvider(create: (context)=>HomepageCubit()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
      
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        ),
        //home: const Homepage(),
        home: const Homepage2(),
      ),
    );
  }
}
/*
* Block patterni kullanabilmek icin flutter_bloc kutuphanesini yukleriz pubspec.yaml icerisinde:
* # versions available, run `flutter pub outdated`.
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc:  dikkat flutter ile ayni hizada olacak ve flutter_bloc: karsina birsey yazmassak son versiyonu alir ..
* */
