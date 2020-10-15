import 'package:firebase_auth/firebase_auth.dart';
import 'package:jn_chat_app/Modal/user.dart';

class AuthMethods {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Users _userfirebse(User user) {
    return user == null ? null : Users(userId: user.uid);
  }

  Future signInwithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User firebseuser = result.user;
      return _userfirebse(firebseuser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signupwithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User firebaseuser = result.user;
      return _userfirebse(firebaseuser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetPass(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
