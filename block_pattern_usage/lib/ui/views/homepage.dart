import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var textFeildNum1 = TextEditingController();
  var textFeildNum2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text("Bloc pattern")),
      body:Center(
        child:Column(
          children: [

            Text("result"),
            TextField(
              controller: textFeildNum1,
              onTap: (){

              },
            ),
            TextField(
              controller: textFeildNum1,
              onTap: (){

              },
            ),
            Row(
              children: [
                ElevatedButton(onPressed: (){}, child: const Text("Sum")),
                ElevatedButton(onPressed: (){}, child: const Text("Substraction")),
              ],
            )
          ],
        )
      )
    );
  }
}
