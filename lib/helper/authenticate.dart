import 'package:flutter/material.dart';
import 'package:jn_chat_app/screens/signin.dart';
import 'package:jn_chat_app/screens/signup.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleview() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Signin(toggle: toggleview);
    } else {
      return Signup(toggle: toggleview);
    }
  }
}
