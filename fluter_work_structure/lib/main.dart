import 'package:fluter_work_structure/bttom_nav_usage/bottom_nav_homepage.dart';
import 'package:fluter_work_structure/homepage.dart';
import 'package:fluter_work_structure/user_interactions/user_interaction_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(//temamizi belirliyor
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,//yaparak, ana sayfada sag ust caprazda gelen debug yazisini kaldiririz
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
     // home: Homepage(),//
       // home:BottomNavHomepage()
        home:UserInteractionPage()
        //Ana sayfamizi gorebilmek icin, bunu main icerisinde home karsinda kullanmamiz gerekiyor
    );
  }
}
