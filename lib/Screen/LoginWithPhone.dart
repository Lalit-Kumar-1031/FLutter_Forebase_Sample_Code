import 'package:firebase/Screen/PhoneVerify.dart';
import 'package:firebase/utils/toastmsg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({Key? key}) : super(key: key);

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  final phoneController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login with Phone"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Icon(
              Icons.phone_android_rounded,
              size: 40,
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextFormField(

                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: 'Ex - +91',
                    hintStyle: TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: Text("Enter Phone no here"),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 40, //MediaQuery.of(context).size.width*0.14,
              width: 100, //MediaQuery.of(context).size.width*0.35,
              child: OutlinedButton(
                onPressed: () {
                  auth.verifyPhoneNumber(
                    phoneNumber: phoneController.text,
                    verificationCompleted: (_) {},
                    verificationFailed: (e) {
                      toastmsg().Errortoast(e.toString());
                    },
                    codeSent: (String verification_id, int? token) {
                      toastmsg().toast("Verification code sent to your Mobile number => ${phoneController.text.toString()} !");
                      phoneController.clear();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PhoneVerify(
                              verificationid: verification_id,
                            ),
                          ));

                    },
                    codeAutoRetrievalTimeout: (e) {
                      toastmsg().Errortoast(e.toString());
                    },
                  );
                },
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(primary: Colors.indigo),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
