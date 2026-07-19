import 'package:flutter/material.dart';

/*
my setting tile

-title
-action


*/

class MySettingsTile extends StatelessWidget {
  
  final String title;
  final Widget action;

const MySettingsTile({super.key,
required this.title,
required this.action});
  @override
  Widget build(BuildContext context) {
    //container
    return Container(
      decoration: BoxDecoration(
        //color
        color: Theme.of(context).colorScheme.secondary,

        //curve
        borderRadius: BorderRadius.circular(12),
      ),
      //padding outside
      margin: const EdgeInsets.only(left:25,right: 25, top:  10),
      //padding inside
      padding: const EdgeInsets.all(25),
      //list tile
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          action
        ]
      ),
    );
  }
}