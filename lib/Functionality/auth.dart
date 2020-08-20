import 'package:firebase_auth/firebase_auth.dart';
import 'package:reminder_app/Models/user.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create custom user from FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid : user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  //sign in anon
  Future signInAnon() async{
    try{
      final AuthResult result = await _auth.signInAnonymously();
      final FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //return uid of user
  Future currentUser() async{
    try {
      final FirebaseUser user = await _auth.currentUser();
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in with email password

  //register with email password

  //logout
  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }


}