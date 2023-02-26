import 'package:firebase/Screen/LoginScreen.dart';
import 'package:firebase/Shared_preference/EditText.dart';
import 'package:firebase/utils/toastmsg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp2 extends StatefulWidget {
  const SignUp2({Key? key}) : super(key: key);

  @override
  State<SignUp2> createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  final auth= FirebaseAuth.instance;
  final emailcontroller = TextEditingController();
  final passController = TextEditingController();
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.indigo.shade100,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(height: 50),
            CircleAvatar(
              backgroundImage: AssetImage('assets/boy1.png'),
              radius: 40,
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: EditText(
                emailcontroller,
                "Enter Email",
                Icons.email,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: EditText(
                passController,
                "Enter Password",
                Icons.security,
              ),
            ),
            SizedBox(height:20),
            OutlinedButton(
              onPressed: () {
                auth.createUserWithEmailAndPassword(email:emailcontroller.text.toString(),
                    password: passController.text.toString()).then((value){
                      toastmsg().toast("User Register sucessfully");
                      emailcontroller.clear();
                      passController.clear();
                      Navigator.push(context, MaterialPageRoute(builder:(context) => LoginScreen(),));
                }).onError((error, stackTrace){
                  toastmsg().Errortoast(error.toString());

                });


              },
              child: Text("SignUp"),
              style: OutlinedButton.styleFrom(primary:Colors.white,backgroundColor: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
