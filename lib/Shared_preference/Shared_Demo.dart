import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'EditText.dart';
class Shared_Demo extends StatefulWidget {
  const Shared_Demo({Key? key}) : super(key: key);

  @override
  State<Shared_Demo> createState() => _Shared_DemoState();
}

class _Shared_DemoState extends State<Shared_Demo> {
  var nameController =TextEditingController();
  final Keyname="name";
  var SavedData="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body:Center(
            child: Column(
              children: [
                SizedBox(height: 150,),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.7,
                  child: EditText(nameController,"Enter name",Icons.person),
                ),
                SizedBox(height: 150,),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.7,
                  child: EditText(nameController,"Enter Password",Icons.security_sharp),
                ),
                SizedBox(height: 20,),
                ElevatedButton(onPressed:()async{
                  var name=nameController.text.toString();
                  var prefs=await SharedPreferences.getInstance();
                  prefs.setString(Keyname,name);

                }, child: Text("Save Data")),
                SizedBox(height: 20,),
                Text(SavedData),
              ],
            ),
          ));
  }

  void getValue()async {

    var prefs=await SharedPreferences.getInstance();

    var getname=prefs.getString(Keyname);

    SavedData=getname!=null ? getname :"No Value are Saved ";
    setState(() {

    });

  }
}
