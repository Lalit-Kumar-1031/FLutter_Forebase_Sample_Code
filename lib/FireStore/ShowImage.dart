import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/utils/toastmsg.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ShowImage extends StatefulWidget {
  const ShowImage({Key? key}) : super(key: key);

  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  CollectionReference fireStore=FirebaseFirestore.instance.collection('Profile');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: fireStore.snapshots(),
        builder: ( BuildContext context,AsyncSnapshot snapshot){
          if(snapshot.hasData){

            QuerySnapshot querySnapshot=snapshot.data;
            List<QueryDocumentSnapshot> document=querySnapshot.docs;

            List<Map> items=document.map((e)=>
            e.data() as Map).toList();

            return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  Map thisItem=items[index];
                  return ListTile(
                    title: Text('${thisItem['Id']}'),
                    leading: Container(
                        height: 80,
                        width: 80,
                        child: thisItem.containsKey("ImageUrl")?Image.network('${thisItem['ImageUrl']}'):Container(color: Colors.black,)),
                  );

                });
          }

          return Text("Failed");
        },
      ),
    );
  }
}
