import 'package:flutter/material.dart';
import 'package:twitter_clone/components/my_button.dart';
import 'package:twitter_clone/components/my_textfield.dart';
import 'package:twitter_clone/pages/home_page.dart';
import 'package:twitter_clone/pages/register_page.dart';


/*

LOGIN PAGE

On this page an esixting user can log in with an email and a password
-email
-password
------------------------------------------------
once logged in user can go move to the home page 
or
else
they are directed to the registration page
*/
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  

//text controllers
  final TextEditingController emailController= TextEditingController();
  final TextEditingController pwController= TextEditingController();


  //UI
  Widget build(BuildContext context) {

    //Scaffold
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            //logo
            children: [
              const SizedBox(height: 150.0,),
              Icon(
                Icons.lock_open_rounded,
                size: 70, 
                color:Theme.of(context).colorScheme.primary),
                const SizedBox(height:50),
            //welcome back msg
              Text("Welcome back, You've been missed!",
              style: TextStyle( 
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16)),
          
          
              const SizedBox(height: 25.0),
            //email textfield
          
                  MyTextField(
                    controller: emailController,
                    hintText: "Enter email",
                    obscureText: false,
                  ),
                
                const SizedBox(height: 10,),
            //password textfield
          
            MyTextField(controller: pwController, 
            hintText: "Enter password", 
            obscureText: true),

            const SizedBox(height: 10,),

            //forgot password?
            Align(alignment: Alignment.centerRight,
              child: Text("Forgot password?",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              )
              )
              ),

              const SizedBox(height: 25),

            //sign in button
            MyButton(name:"Login", onTap: (){
                //pop the menu drawer
                Navigator.pop(context);
                //navigate to settings page
                Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage(),
                )
                );
              },),
              const SizedBox(height: 50),
            //not a member?register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                  Text("Not a member?", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                SizedBox(width: 5),
                GestureDetector(
                  onTap:() {
                    //pop the menu drawer
                Navigator.pop(context);
                //navigate to settings page
                Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterPage(),
                )
                );
                  },
                  child: Text("Register Now",
                  style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)
                  ),
                ),
              ],
            )
          ],),
        ),
      ),
    );
  }
}