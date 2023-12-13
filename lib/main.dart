import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo/db/db_helper.dart';
import 'services/theme_services.dart';
import 'theme.dart';
import 'views/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.initDb();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Do It',
      debugShowCheckedModeBanner: false,
      theme: Themes.lightAppColors,
      darkTheme: Themes.darkAppColors,
      themeMode: ThemeServices().theme,
      home: const SplashView(),
    );
  }
}
