import 'package:flutter/material.dart';
import 'package:twitter_clone/pages/drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("H O M E"),
        centerTitle: true,
        foregroundColor: Theme.of(context).colorScheme.primary,
        
      ),

    );
  }
}