import 'package:firebase/FireStore/InsertScreen.dart';
import 'package:firebase/Screen/LoginWithPhone.dart';
//import 'package:firebase/Screen/PostScreen.dart';
import 'package:firebase/Screen/SignUpScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import '../utils/color_utils.dart';
import '../utils/toastmsg.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  final emailContrller = TextEditingController();
  final passContrller = TextEditingController();

  FirebaseAuth auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/register.png'), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.23,
                ),
                Icon(
                  Icons.lock,
                  size: 50,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "User Login",
                  style: TextStyle(fontSize: 30, color: Colors.indigo),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextFormField(
                    controller: emailContrller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      labelStyle: TextStyle(color:Colors.black),
                      label: Text("Enter Email here"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1),
                      ),
                    ),
                    validator: (value){
                      if(value!.isEmpty)
                      {
                        return "Email is Required !";
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextFormField(
                    controller: passContrller,
                    obscureText: true,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      labelStyle: TextStyle(color:Colors.black),
                      label: Text("Enter Password here"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(width: 1),
                      ),
                    ),
                    validator: (value){
                      if(value!.isEmpty)
                      {
                        return "Password is Required !";
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {

                          if(formkey.currentState!.validate()) {
                            auth.signInWithEmailAndPassword(
                                email: emailContrller.text,
                                password: passContrller.text.toString()).then((
                                value) {
                              toastmsg().toast(
                                  "You Have Logged In Successfully !");
                              emailContrller.clear();
                              passContrller.clear();
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => InsertScreen(),));
                            }).onError((error, stackTrace) {
                              toastmsg().Errortoast(error.toString());
                            });
                          }

                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        )),
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xff4c505b),
                      child: Icon(
                        Icons.arrow_forward,
                        size: 30,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "Don't have an Account",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              decoration: TextDecoration.underline),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ));
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        )),
                  ],
                ),
                SizedBox(height: 10,),

                ElevatedButton(onPressed: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context) => LoginWithPhone(),));
                }, child:Text("Login With Phone",style: TextStyle(color:Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo.shade300
                ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
