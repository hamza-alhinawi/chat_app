import 'package:flutter/material.dart';

class CutomBottom extends StatelessWidget {
  const CutomBottom({super.key, required this.title, required this.ontap});
  final String title;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Text(title, style: TextStyle(color: Color(0xffC6ECE5))),
    );
  }
}
