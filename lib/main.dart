import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'services/notification_services.dart';
import 'services/theme_services.dart';
import 'theme.dart';
import 'views/home.dart';

void main()async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  //NotifyHelper().initializeNotification();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Do It',
      debugShowCheckedModeBanner: false,
      theme: Themes.lightAppColors ,
      darkTheme: Themes.darkAppColors,
      themeMode: ThemeServices().theme,
      home:  const MyHomePage(),
    );
  }
}

