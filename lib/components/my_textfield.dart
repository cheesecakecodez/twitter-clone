import 'package:flutter/material.dart';


/*

Text Field
-------
hint text
controller to access what user entered
obscure bool true -> password: ********
*/ 
class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;


  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText});

//build UI
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(

        //unfocused text field
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.tertiary,
          ),
          borderRadius: BorderRadius.circular(12),
        ),

        //focused textfield
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: hintText,
        fillColor: Theme.of(context).colorScheme.secondary,
        filled: true,
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary)
      ),
      obscureText: obscureText,
    

    );
  }
}