import 'package:firebase/Screen/SignUp2.dart';
import 'package:firebase/Shared_preference/Shared_Demo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'Screen/SignUpScreen.dart';
import 'Screen/Splash_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: SplashScreen(),
      home: SplashScreen(),
      //home: SignUp2(),
    );
  }
}

