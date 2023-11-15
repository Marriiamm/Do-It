import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/notification_content.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.primaryColor,
        centerTitle: true,
        title: Text("Reminder",
        style: TextStyle(
          color: Get.isDarkMode? Colors.white :Colors.black,
        ),),
        leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed:() => Get.back(),
        )
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Column(
              children: [
                Text("Hello, Mart",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Get.isDarkMode? Colors.white :Colors.black,
                ),),
                const SizedBox(height: 10,),
                Text("you have a new reminder",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  color: Get.isDarkMode? Colors.white :Colors.black,
                ),),
              ],
            ),
            const SizedBox(height: 10,),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: NotificationContent(payLoad: 'notificatio|content|date',),
              )),
            const SizedBox(height: 10,),
          ],
        )),
    );
  }
}

