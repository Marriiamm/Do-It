import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:todo/views/home.dart';

import 'views/notification_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Do It',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xffFFFBEB),
        scaffoldBackgroundColor: Color(0xffFFFBEB),
        useMaterial3: true,
      ),
      home:  const NotificationScreen(),
    );
  }
}

