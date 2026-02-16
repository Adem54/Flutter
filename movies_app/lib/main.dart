import 'package:flutter/material.dart';
import 'package:movies_app/ui/views/movies.dart';
import 'package:movies_app/ui/views/movies2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),

      ),

      home: const Movies2(),
    );
  }
}
