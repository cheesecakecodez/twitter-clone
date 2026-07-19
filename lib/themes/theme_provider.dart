import 'package:flutter/material.dart';
import 'package:twitter_clone/themes/dark_mode.dart';
import 'package:twitter_clone/themes/light_mode.dart';

/*

Theme Provider 
helps switch themes from dark mode to light mode and vice versa

*/ 

class ThemeProvider with ChangeNotifier{
  //initially set it as lightMode
  ThemeData _themeData = lightmode;
  //get current theme 
  ThemeData get themeData => _themeData ;
  // check if current theme is dark theme
  bool get isDarkMode => _themeData==darkmode;

  // set the theme
  set themeData(ThemeData themeData){
    _themeData= themeData;


  //update UI
  notifyListeners();
  }

//toggle between dark and light mode
void toogleTheme(){
  if(_themeData==lightmode){
    themeData=darkmode;
  }
  else{
    themeData=lightmode;
  }
}
}