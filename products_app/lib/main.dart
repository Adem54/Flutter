import 'package:flutter/material.dart';
import 'package:products_app/ui/views/products.dart';
import 'package:products_app/ui/views/products2.dart';
import 'package:products_app/ui/views/products3.dart';

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
      home: Products3(),
    );
  }
}
