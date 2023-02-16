import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase/utils/toastmsg.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


/*
For Image Uploading in Database must be added two permission in AnroidManifest.xml at above to application

<uses-permission android:name="android.permission.INTERNET"></uses-permission>
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>

 */

class ImgUpload extends StatefulWidget {
  const ImgUpload({Key? key}) : super(key: key);

  @override
  State<ImgUpload> createState() => _ImgUploadState();
}

class _ImgUploadState extends State<ImgUpload> {

  firebase_storage.FirebaseStorage storage=firebase_storage.FirebaseStorage.instance;

  File? _image;
  final picker=ImagePicker();

  Future getGallaryImage()async{

    final pickedImg=await picker.pickImage(source: ImageSource.gallery,imageQuality: 90);
    setState(() {
      if(pickedImg!=null)
        {
          _image=File(pickedImg.path);

        }
      else
      {
        toastmsg().Errortoast('No Image Picked By User !');

        }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  child: Container(
                    height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45,width: 1),
                        color: Colors.indigo.shade50
                      ),
                      child:_image!=null? Image.file(_image!.absolute,fit: BoxFit.cover,):Icon(Icons.file_upload_rounded,size: 40,)),
                onTap: (){
                    getGallaryImage();
                },
              ),
              SizedBox(height: 30,),
              ElevatedButton(onPressed: (){}, child: Text("Upload Image"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
