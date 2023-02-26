import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/FireStore/ShowImage.dart';
import 'package:firebase/utils/toastmsg.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  //firebase_storage.FirebaseStorage storage=firebase_storage.FirebaseStorage.instance;
  CollectionReference fireStore=FirebaseFirestore.instance.collection('Profile');

  String imgUrl="";




  File? _image;
  final picker=ImagePicker();

  Future getGallryImage()async{
    final pickedImg=await picker.pickImage(source: ImageSource.gallery,imageQuality: 90);
    setState(() {
      if(pickedImg!=null)
      {
        _image=File(pickedImg.path);
        print('Images Picked !');
      }
      else
      {
        print("No Images Picked !");
      }
    });
  }
  Future getCameraImage()async{
    final pickedImg=await picker.pickImage(source: ImageSource.camera,imageQuality: 90);
    setState(() {
      if(pickedImg!=null)
      {
        _image=File(pickedImg.path);
        print('Images Picked !');
      }
      else
      {
        print("No Images Picked !");
      }
    });
  }


@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Images") ,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context) => ShowImage(),));
          }, icon: Icon(Icons.logout)),
        ],
      ),
drawer:Drawer() ,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
           /* Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black,width: 1),
              ),
              child:_image!=null? InkWell(child: Image.file(_image!.absolute,fit: BoxFit.cover,),onTap: (){getGallryImage();},): IconButton(
                icon: Icon(Icons.upload),
                onPressed: (){
                  getGallryImage();

                },
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: ()async{
              firebase_storage.Reference ref=firebase_storage.FirebaseStorage.instance.ref('/Images'+DateTime.now().millisecondsSinceEpoch.toString());
              firebase_storage.UploadTask uploadtask=ref.putFile(_image!.absolute);

              await Future.value(uploadtask).then((value) async{
                var imgUrl=await ref.getDownloadURL();

                fireStore.doc('${DateTime.now().millisecondsSinceEpoch}').set({
                  "Id":'111',
                  'Message':imgUrl.toString(),
                  'User Name':"Lalit Kumar",
                }).then((value) {
                  toastmsg().toast("Uploaded");

                }).onError((error, stackTrace){
                  toastmsg().Errortoast(error.toString());
                });

              }).onError((error, stackTrace){
                toastmsg().Errortoast(error.toString());
              });



            }, child: Text("Upload")),

            */
            SizedBox(height: 10,),

            InkWell(
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black,width: 1),
                ),
                child:_image!=null?Image.file(_image!.absolute,fit: BoxFit.cover,): Icon(Icons.camera_alt_outlined) ,
              ),
              onTap: () async{
                getCameraImage();
                if(_image==null)
                  {
                    return;
                  }

                String uniquename=DateTime.now().millisecondsSinceEpoch.toString();

                Reference refroot=FirebaseStorage.instance.ref();
                Reference UploadImage=refroot.child('ProfileImages').child(uniquename);

                try {
                  await UploadImage.putFile(File(_image!.path));
                  imgUrl=await UploadImage.getDownloadURL();
                  toastmsg().toast("Image Uploaded Successfully");
                  print("Uploaded------------------");
                }
                catch(e){
                  print("Exception is :"+e.toString());

                }
              },
            ),

            ElevatedButton(onPressed: () {

              if(imgUrl.isEmpty)
                {
                  toastmsg().Errortoast("Plz Upload Img");
               }
              String id=DateTime.now().millisecondsSinceEpoch.toString();
              fireStore.doc(id).set({
                "Id":id,
                "ImageUrl":imgUrl,
              }).then((value){
                toastmsg().toast("URl is set !");
              }).onError((error, stackTrace) {
                toastmsg().Errortoast("Something Went wrong");
              });


            }, child:Text("set Image URl into FireStore")),

            SizedBox(height: 10,),

            /*
            StreamBuilder<QuerySnapshot>(
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

                return Text("Unable to failed");
              },
            ),

             */






          ],
        ),
      ),
    );
  }
}
