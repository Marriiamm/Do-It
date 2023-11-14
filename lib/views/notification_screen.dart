import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key, required this.payLoad});

  final String payLoad;
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  String _payLoad ='';
@override
  void initState() {
    // TODO: implement initState
    super.initState();

    _payLoad = widget.payLoad;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.theme.primaryColor,
        centerTitle: true,
        title: Text(_payLoad.toString().split('|')[0],
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
        )),
    );
  }
}