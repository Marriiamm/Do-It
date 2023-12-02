import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../size_config.dart';
import '../theme.dart';

class TextFieldd extends StatelessWidget {
  const TextFieldd(
      {super.key,
      required this.label,
      required this.hint,
      this.controller,
      this.widget});

  final String label;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,style: titleStyle,),
          Container(
          width: SizeConfig.screenWidth,
          height: 52,
          padding: const EdgeInsets.only(left:10),
          margin: const EdgeInsets.only(left: 0,top: 4),
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: kdarkDo1,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                 controller: controller, 
                 autofocus: false,
                 style: supTitleStyle,
                 readOnly: widget!= null? true:false,
                 cursorColor: Get.isDarkMode? Colors.black :Colors.deepOrangeAccent,
                 decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: supTitleStyle,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 0,
                      color: context.theme.colorScheme.background,
                    )
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 0,
                      color: context.theme.colorScheme.background,
                    )
                  ),
                 ),
                ),
              ),
              widget ??Container(),
            ],
          ),
    ),
        ],
      ),
    );
  }
}
