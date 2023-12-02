import 'package:flutter/material.dart';
import '../theme.dart';

class UiButton extends StatelessWidget {
  const UiButton({super.key, required this.label, required this.onTap});

  final String label;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: kdarkDo3
        ),
        child: Center(
          child: Text(label,
          style: const TextStyle(
            color: Colors.white,
          ),),
        ),
      ),
    );
  }
}
