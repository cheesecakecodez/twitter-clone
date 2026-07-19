import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String name;
  final void Function()? onTap;

  const MyButton({super.key,
  required this.name,
  required this.onTap});

  @override
  //UI
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12)
          
        ),
        padding: EdgeInsets.all(25),
        child: Center(
          child: Text(name, 
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          )),
        )
      )
    );
  }
}