// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function() onTap;
  const MyButton({Key? key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 60,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
