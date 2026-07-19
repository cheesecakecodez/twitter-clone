import 'package:flutter/material.dart';
/*

drawer tile
simle drawer tile for our drawer menu
--------
to use this tile you need
function( eg gotohomepage)
icon
title
*/
class MyDrawerTile extends StatelessWidget {
  
  final String title;
  final IconData icon;
  final void Function()? onTap;
  const MyDrawerTile({super.key,
  required this.title,
  required this.icon,
  required this.onTap});

//UI
  @override
  Widget build(BuildContext context) {

    //list tile
    return ListTile(
      title:Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary
        )),
      leading:Icon(icon, color: Theme.of(context).colorScheme.primary),
      onTap: onTap

    );
  }
}