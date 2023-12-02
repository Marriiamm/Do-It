import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/services/theme_services.dart';
import 'package:todo/size_config.dart';
import '../widgets/button.dart';
import '../widgets/textfield.dart';
import 'addtask.dart';
//import 'package:todo/views/notification_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage ({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: customAppBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UiButton(label: 'Add Task', onTap: () { Get.to( AddTaskView()); },),
              const SizedBox(height: 10,),
              TextFieldd(label: 'title', hint: 'enter any',),
            ],
          ),
        ),
      ),
    );
  }
  AppBar customAppBar(){
    return AppBar(
        backgroundColor: context.theme.primaryColor,
        centerTitle: true,
        leading: IconButton(
        icon: Icon(
          Get.isDarkMode?
          Icons.wb_sunny_rounded
          :Icons.nightlight_rounded,
          color
          : Get.isDarkMode? Colors.white 
          :Colors.black,
          ),
        onPressed:() => ThemeServices().switchTheme(),
        ),
        actions: const [
          CircleAvatar(
            radius: 19,
              backgroundImage: AssetImage("assets/images/businessman.png",
              ),
          ),
          SizedBox(width: 20,)

        ],
      );
  }
}
