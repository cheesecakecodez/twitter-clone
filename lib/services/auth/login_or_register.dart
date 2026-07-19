import 'package:flutter/material.dart';
import 'package:twitter_clone/pages/login_page.dart';
import 'package:twitter_clone/pages/register_page.dart';



/*

Login or Register page

this determines whether to login or register
*/
class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {

  //initially show login page
  bool showLoginPage= true;

  //toggle between login and register page
  void togglePages(){
    setState(() {
      showLoginPage=!showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage();
    }
    else{
      return RegisterPage();
    }
  }
}