import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme.dart';

class NotificationContent extends StatefulWidget {
  const NotificationContent({super.key, required this.payLoad});
  final String payLoad;
  @override
  State<NotificationContent> createState() => _NotificationContentState();
}

class _NotificationContentState extends State<NotificationContent> {

  String _payLoad ='';
@override
  void initState() {
    super.initState();
    _payLoad = widget.payLoad;

  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26.0),
        color: Get.isDarkMode?kdarkDo3: kLightGreen,
      ),
      child:  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.text_format_rounded,
                  size: 35,
                  color: Colors.white,),
                SizedBox(width: 20,),
                Text("title",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color:  Colors.white ,
                ),),
              ],
            ),
            const SizedBox(width: 10,),
            Text(_payLoad.toString().split('|')[0],
              style: const TextStyle(
                color: Colors.white,
              ),),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.description_rounded,
                  size: 35,
                  color: Colors.white,),
                SizedBox(width: 20,),
                Text("Description",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color:  Colors.white ,
                ),),
              ],
            ),
            Text(_payLoad.toString().split('|')[1],
              textAlign: TextAlign.justify,
              style: const TextStyle(
                color: Colors.white,
              ),),
            const SizedBox(width: 10,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.date_range_outlined,
                  size: 35,
                  color: Colors.white,),
                SizedBox(width: 20,),
                Text("Time",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color:  Colors.white ,
                ),),
              ],
            ),
            const SizedBox(width: 10,),
            Text(_payLoad.toString().split('|')[2],
              style: const TextStyle(
                color: Colors.white,
              ),),
          ],
        ),
      ),
    );
  

  }
}