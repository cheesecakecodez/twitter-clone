/* AUTHENTICATION SERVICE 
this handles everything to do with authentication and firebase

---------------------------------------------------
- Login 
- Register
- Logout
-delete account( required if u want to publish it in the app store)
*/

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // get instance of authentication
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get current user and user id
  User? getCurrentUser() => _auth.currentUser;
  String getCurrentUserId() => _auth.currentUser!.uid;
  // login-> email and pw and google auth button
  Future<UserCredential> loginEmailAndPassword(String email, String password) async {
    //attempt login
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password,
        );

      return userCredential;
    }
    // catch any errors and throw them
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // register-> email and pw and google auth button
  Future<UserCredential> registerEmailAndPassword(String email, String password) async {
    //attempt register
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password,
        );

      return userCredential;
    }
    // catch any errors and throw them
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //logout-> sign out user
  Future<void> logout() async {
    await _auth.signOut();
  }

  //delete account-> delete user account from firebase auth
}