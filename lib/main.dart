import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outshade/controller/user.controller.dart';
import 'package:outshade/screen/UserList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'OutShades',
      theme: ThemeData(
     
      primaryColor:const Color.fromARGB(255, 252, 1, 64),
      appBarTheme: const AppBarTheme(backgroundColor:Color.fromARGB(255, 252, 1, 64) ),
      
      ),
      home: const UserListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
