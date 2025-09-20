import 'package:flutter/material.dart';

class CustomContainerButtom extends StatelessWidget {
  const CustomContainerButtom({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(child: Text(text, style: TextStyle(fontSize: 20))),
    );
  }
}
