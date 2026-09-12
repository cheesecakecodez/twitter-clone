import 'package:flutter/material.dart';
/*

Loading circle widget
*/
//show loading circle
void showLoadingCircle(BuildContext context){
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      )
    ),
  );
}
  

//hide loading circle
void hideLoadingCircle(BuildContext context){
  Navigator.pop(context);
}