import 'package:firebase_auth/firebase_auth.dart';
import 'package:reminder_app/Models/user.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create custom user from FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid : user.uid) : null;
  }
  //sign in anon
  Future signInAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in with email password

  //register with email password

  //logout

}