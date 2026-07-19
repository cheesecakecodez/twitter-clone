import 'package:flutter/material.dart';
import 'package:twitter_clone/components/my_drawer_tile.dart';
import 'package:twitter_clone/pages/home_page.dart';
import 'package:twitter_clone/pages/login_page.dart';
import 'package:twitter_clone/pages/settings_page.dart';

/*
drawer accessed from the left side of app bar : the MENU
options:
home
profile
settings
search
logout

*/
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

//UI
  @override
  Widget build(BuildContext context) {

    //Drawer
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(children: [
            //app logo
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50.0),
              child: Icon(
                Icons.sunny,
              size: 72,
              color: Theme.of(context).colorScheme.primary,),
            ),
          
            //divider line
            Divider(
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height:10.0),
            //home list tile
            MyDrawerTile(
              title: "H O M E",
              icon: Icons.home,
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
              },
            ),
          
            //profile list tile
            MyDrawerTile(
              title: "P R O F I L E",
              icon: Icons.person,
              onTap: () {},
            ),
            // search list tile
            MyDrawerTile(
              title: "S E A R C H",
              icon: Icons.search,
              onTap: () {},
            ),
            //settings list tile
            MyDrawerTile(
              title: "S E T T I N G S",
              icon: Icons.settings,
              onTap: () {
                //pop the menu drawer
                Navigator.pop(context);
                //navigate to settings page
                Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsPage(),
                )
                );
              },
            ),
            // logout list tile
            MyDrawerTile(
              title: "L O G O U T",
              icon: Icons.logout,
              onTap:(){ Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder:(context)=>LoginPage()));},
            )
          ],),
        ),
      )
    );
  }
}