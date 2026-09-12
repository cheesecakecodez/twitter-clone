import 'package:flutter/material.dart';
import 'package:twitter_clone/components/my_drawer_tile.dart';
import 'package:twitter_clone/pages/home_page.dart';
//import 'package:twitter_clone/pages/login_page.dart';
import 'package:twitter_clone/pages/settings_page.dart';
//import 'package:twitter_clone/services/auth/login_or_register.dart';
import 'package:twitter_clone/services/auth/auth_service.dart';

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
  MyDrawer({super.key});

  //access auth service
  final _auth = AuthService();
  //logout method
  void logoutMethod() async{
    //attempt to logout
    try{
      await _auth.logout();
    }
    catch(e){
      //catch any errors and display them
      print(e.toString());
    }
  }

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
            const Spacer(),
            //logout list tile
            MyDrawerTile(
              title: "L O G O U T",
              icon: Icons.logout,
              onTap: logoutMethod,
            ),
            
          ],),
        ),
      )
    );
  }
}