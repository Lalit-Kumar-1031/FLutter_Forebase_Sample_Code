import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/utils/toastmsg.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

//How to insert Data in FireStore

class Add_FireStrore_Post extends StatefulWidget {
  const Add_FireStrore_Post({Key? key}) : super(key: key);

  @override
  State<Add_FireStrore_Post> createState() => _Add_FireStrore_PostState();
}

class _Add_FireStrore_PostState extends State<Add_FireStrore_Post> {

  final fireStore=FirebaseFirestore.instance.collection('FireStore_Post');
  final formkey=GlobalKey<FormState>();
  final postController=TextEditingController();
  final userController=TextEditingController();


  @override
  Widget build(BuildContext)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add FireStore Post"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50,),
                Icon(Icons.note_add,size: 40,color: Colors.indigo,),
                SizedBox(height: 30,),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width*0.82,
                    child: TextFormField(
                      controller: userController,
                      decoration: InputDecoration(
                        label: Text("Enter Your Name."),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return "User Name is Required !";
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width*0.82,
                    child: TextFormField(
                      maxLines: 4,
                      controller: postController,
                      decoration: InputDecoration(
                        hintText: "What is in your mind?",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value){
                        if(value!.isEmpty)
                        {
                          return "Enter Your Suggestion here !";
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20,),

                ElevatedButton(onPressed: (){

                  if(formkey.currentState!.validate()) {

                    String id=DateTime.now().millisecondsSinceEpoch.toString();

                    fireStore.doc(id).set({

                      'User Name':userController.text.toString(),
                      'Message':postController.text.toString(),
                      'Id':id

                    }).then((value) {
                      toastmsg().toast("FireStore Post are Added !");

                    }).onError((error, stackTrace) {
                      toastmsg().Errortoast(error.toString());
                    });

                    postController.clear();
                    userController.clear();

                  }

                }, child: Text("Add Notes"),
                  style: ElevatedButton.styleFrom(
                    textStyle:TextStyle(
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.indigo,
                  ),
                ),
                SizedBox(height: 50 ,)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
