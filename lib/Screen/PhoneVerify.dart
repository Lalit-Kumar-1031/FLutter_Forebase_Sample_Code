import 'package:firebase/FireStore/InsertScreen.dart';
//import 'package:firebase/Screen/PostScreen.dart';
import 'package:firebase/utils/toastmsg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneVerify extends StatefulWidget {
  final verificationid;
  const PhoneVerify({Key? key,required this.verificationid}) : super(key: key);

  @override
  State<PhoneVerify> createState() => _PhoneVerifyState();
}

class _PhoneVerifyState extends State<PhoneVerify> {

  final codeController=TextEditingController();
  final auth=FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify With Code"),
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
              Icons.security_sharp,
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
                  controller: codeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: Text("Enter 6 Digit code"),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 40, //MediaQuery.of(context).size.width*0.14,
              width: 140, //MediaQuery.of(context).size.width*0.35,
              child: OutlinedButton(
                onPressed: () async {

                  final authToken=PhoneAuthProvider.credential(
                      verificationId: widget.verificationid,
                      smsCode: codeController.text.toString());

                      try
                      {
                        await auth.signInWithCredential(authToken);
                        //Navigator.push(context,MaterialPageRoute(builder: (context) => PostScreen(),));
                        Navigator.push(context,MaterialPageRoute(builder: (context) => InsertScreen(),));

                        toastmsg().toast("User Verified !");

                      }
                      catch(e){
                        toastmsg().Errortoast(e.toString());
                      }

                },
                child: Text(
                  "Verify Code",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(primary: Colors.blue.shade300),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
