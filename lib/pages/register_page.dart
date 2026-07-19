import 'package:flutter/material.dart';
import 'package:twitter_clone/components/my_button.dart';
import 'package:twitter_clone/components/my_textfield.dart';
import 'package:twitter_clone/pages/home_page.dart';
import 'package:twitter_clone/pages/login_page.dart';

/* Registration page 
-email
-confirm password
-name
-password
----------------------------------------

if successfull redirects to home page
else
if user already exists it redirects to login page
*/
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController= TextEditingController();
  final TextEditingController emailController= TextEditingController();
  final TextEditingController pwController= TextEditingController();
  final TextEditingController cpwController= TextEditingController();

  @override

  //Build UI
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:25),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              SizedBox(height:50),
              //icon
              Icon(Icons.lock_open_rounded),
              //create an account
              Text("Let's create an account for you.",
              style: TextStyle( 
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16)),

                SizedBox(height: 25,),
              //name
              MyTextField(
                controller: nameController, 
                hintText: "Enter your name", 
                obscureText: false),

                SizedBox(height:10),
              //email
               MyTextField(
                controller: emailController, 
                hintText: "Enter your email", 
                obscureText: false),

                SizedBox(height:10),
              //password
               MyTextField(
                controller: pwController, 
                hintText: "Enter your password", 
                obscureText: true),

                SizedBox(height:10),
              //confirm password
               MyTextField(
                controller: cpwController, 
                hintText: "Confirm Password", 
                obscureText: true),

                SizedBox(height:50),
              MyButton(name:"Register", onTap: (){
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
                
                  Text("Already a member?", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                SizedBox(width: 5),
                GestureDetector(
                  onTap:() {
                    //pop the menu drawer
                Navigator.pop(context);
                //navigate to settings page
                Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage(),
                )
                );
                  },
                  child: Text("Login Now",
                  style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)
                  ),
                ),
            ],),
          ]),
        ),
      )
    ));
  }
}