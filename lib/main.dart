import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:todo/views/home.dart';

import 'theme.dart';
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
      theme: Themes.lightAppColors ,
      darkTheme: Themes.darkAppColors,
      themeMode: ThemeMode.light,
      home:  const NotificationScreen(),
    );
  }
}

