import 'package:flutter/material.dart';
import 'package:twitter_clone/components/my_button.dart';
import 'package:twitter_clone/components/my_textfield.dart';
//import 'package:twitter_clone/pages/home_page.dart';
import 'package:twitter_clone/services/auth/auth_service.dart';
import 'package:twitter_clone/components/my_loading_circle.dart';
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
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //access auth service
  final _auth = AuthService();

//text controllers
  final TextEditingController emailController= TextEditingController();
  final TextEditingController pwController= TextEditingController();

//login method
void loginMethod() async{
  //show loading circle
  showLoadingCircle(context);
  //attempt to login with email and password
  try{
    await _auth.loginEmailAndPassword(
      emailController.text, 
      pwController.text);

      //login finished
      if (mounted) hideLoadingCircle(context);
  }
  catch(e){
    if (mounted) hideLoadingCircle(context);
    //catch any errors and display them
    print(e.toString());
  }
}
  //UI
  @override
  Widget build(BuildContext context) {
  
    //Scaffold
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
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
              MyButton(name:"Login", onTap: loginMethod),
                const SizedBox(height: 50),
              //not a member?register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                    Text("Not a member?", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text("Register Now",
                    style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold)
                    ),
                  ),
                ],
              )
            ],),
          ),
        ),
      ),
    );
  }
}