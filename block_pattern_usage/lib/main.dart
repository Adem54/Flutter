import 'package:block_pattern_usage/ui/cubit/homepage_cubit.dart';
import 'package:block_pattern_usage/ui/views/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(//MaterialApp i secip alt-enter yaparak widget ekleriz ve
      // MultiBlocProvider seceriz HomepageCubit yapimizi tanitmak icin'
      //  main.dartta ypama sebegimz tum uygulamada etki etmesi icin
      //Bu sekilde en ustekoyarak tanimliyoruz ve de ana MaterialApp i wrap etitiryouruz ki tum projede tanimli hale gelir cubitlerimiz
      providers: [BlocProvider(create: (context)=>HomepageCubit())],//Kac tane cubitimiz var ise hepsini burda tanitmamiz gerekiyoir
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        ),
        home: Homepage(),
      ),
    );
  }
}
