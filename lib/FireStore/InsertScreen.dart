import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/FireStore/Add_FireStrore_Post.dart';
import 'package:firebase/Screen/LoginScreen.dart';
import 'package:firebase/utils/toastmsg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InsertScreen extends StatefulWidget {
  @override
  State<InsertScreen> createState() => InsertScreenState();
}

class InsertScreenState extends State<InsertScreen> {
  final auth = FirebaseAuth.instance;
  final userController = TextEditingController();
  final msgController = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection('FireStore_Post').snapshots();

  //both line have same purpose you can use onyone
  CollectionReference ref=FirebaseFirestore.instance.collection('FireStore_Post');

  //final ref1=FirebaseFirestore.instance.collection("FireStore_Post");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FireStore Screen"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout_rounded,
            ),
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
              }).onError((error, stackTrace) {
                toastmsg().Errortoast(error.toString());
              });
            },
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Add_FireStrore_Post(),
              ));
        },
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.indigo.shade100,
        child: Column(
          children: [
            SizedBox(height: 10,),
            StreamBuilder<QuerySnapshot>(
              stream: firestore,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot!.hasError) {
                  return Text("An Error Occured !");
                }
                return Expanded(

                    child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final name=snapshot.data!.docs[index]['User Name'].toString();
                    final msg=snapshot.data!.docs[index]['Message'].toString();
                    final id=snapshot.data!.docs[index]['Id'].toString();

                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.comment),
                        title: Text(snapshot.data!.docs[index]["User Name"].toString()),
                        subtitle: Text(snapshot.data!.docs[index]['Message'].toString()),
                        trailing: PopupMenuButton(
                          icon: Icon(Icons.more_vert),
                          itemBuilder:  (context)=>
                          [
                            PopupMenuItem(
                                child:ListTile(
                                leading: Icon(Icons.edit),
                                  title: Text("Edit"),
                                  onTap: (){
                                    Navigator.pop(context);
                                    openEditDialog(id, name, msg);

                                  },
                                )
                            ),
                            PopupMenuItem(
                                child: ListTile(
                              leading: Icon(Icons.delete_outline),
                                  title: Text("Delate Post"),
                                  onTap: (){
                                Navigator.pop(context);
                                ref.doc(id).delete();

                                  },
                            ))

                          ]
                        ),
                      ),
                    );
                  },
                ));
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> openEditDialog(String id, String name, String msg) async {
    userController.text = name;
    msgController.text = msg;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Update"),
          content: Container(
            height: MediaQuery.of(context).size.width * 0.7,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: userController,
                    decoration: InputDecoration(
                        hintText: "Enter Updated Name ",
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    maxLines: 4,
                    controller: msgController,
                    decoration: InputDecoration(
                        hintText: "Enter Updated Message  ",
                        border: OutlineInputBorder()),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.white),
              ),
              style:
                  TextButton.styleFrom(backgroundColor: Colors.indigo.shade300),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ref.doc(id).update({
                  'User Name':userController.text.toString(),
                  'Message':msgController.text.toString(),
                }).then((value) {
                  toastmsg().toast("Post Updated Successfully !");

                }).onError((error, stackTrace){
                  toastmsg().Errortoast(error.toString());

                });

              },
              child: Text(
                "Update",
                style: TextStyle(color: Colors.white),
              ),
              style:
                  TextButton.styleFrom(backgroundColor: Colors.indigo.shade300),
            ),
          ],
        );
      },
    );
  }
}
