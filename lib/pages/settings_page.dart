import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/components/my_settings_tile.dart';
import 'package:twitter_clone/themes/theme_provider.dart';

/* 

setting page
-dark mode
- blocked users
-account settings


*/
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    //Scaffold
    return Scaffold(
      //app bar
      appBar: AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Text("S E T T I N G S") ,
      centerTitle: true,
      foregroundColor: Theme.of(context).colorScheme.primary,

    ),

    //body
    body:Column(children: [
      //dark mode
      MySettingsTile(
        title: "Dark Mode",  
        action: CupertinoSwitch( 
          onChanged: (value)=>Provider.of<ThemeProvider>(context, listen: false).toogleTheme(),
          value: Provider.of<ThemeProvider>(context, listen: false). isDarkMode 
          )
        ),
      //blocked users
      MySettingsTile(
        title: "Blocked Users", 
        action:Switch(value: true, onChanged: (value){})),
      //account settings
      MySettingsTile(title: "Account Settings",
       action: Switch(value: true, onChanged: (value){}))
    ],)
    );
  }
}