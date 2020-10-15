import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:jn_chat_app/helper/authenticate.dart';
import 'package:jn_chat_app/helper/helperFunction.dart';
import 'package:jn_chat_app/screens/chatroom.dart';
//import 'package:jn_chat_app/screens/signin.dart';
//import 'package:jn_chat_app/screens/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn = false;
  @override
  void initState() {
    getloggedInstate();
    super.initState();
  }

  getloggedInstate() async {
    await HelperFunctions.getUserLoggedInsharedPreference().then((value) => {
          setState(() {
            userIsLoggedIn = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff145C9E),
        scaffoldBackgroundColor: Color(0xff1F1F1F),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: userIsLoggedIn != null
          ? userIsLoggedIn ? ChatRoom() : Authenticate()
          : Container(
              child: Center(
                child: Authenticate(),
              ),
            ),
    );
  }
}
