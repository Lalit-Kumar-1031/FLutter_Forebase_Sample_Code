import 'dart:async';

import 'package:firebase/FireStore/InsertScreen.dart';
import 'package:firebase/Image_Upload/Img_Upload.dart';
import 'package:firebase/Screen/LoginScreen.dart';
import 'package:firebase/Screen/SignUp2.dart';
//import 'package:firebase/Screen/PostScreen.dart';
//import 'package:firebase/Screen/SignUpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    //Check if user Already Login
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;

    if (user != null)
    {
      Timer(Duration(seconds: 5), () {
        //Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>InsertScreen()));
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>ForgotPasswordScreen() ,));
      });
    }
    else
      {
        Timer(Duration(seconds: 5), () {
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>ForgotPasswordScreen()));
        });
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade100,
      body: Center(child: Text("Firebase Tutorials",style:TextStyle(fontSize:30,fontWeight: FontWeight.bold,fontFamily: "Lalit") ,)),
    );
  }
}
