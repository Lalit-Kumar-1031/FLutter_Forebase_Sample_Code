import 'package:firebase/Posts/AddPost.dart';
import 'package:firebase/Screen/LoginScreen.dart';
import 'package:firebase/utils/toastmsg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

/*
There are Two Method of Fetching the data from database

1.Using FirebaseAnimatedList
2.Using StreamBuilder (This is use in any place)
 */

/*
Implementation of fetching the data from Firebase both method

-----------------------------------------------------------------------------------------------------------------
class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final postRef = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Screen"),
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
                builder: (context) => AddPost(),
              ));
        },
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.indigo.shade100,
        child: Column(
          children: [
            Expanded(child: StreamBuilder(
              stream: postRef.onValue,
              builder: (context,AsyncSnapshot<DatabaseEvent> snapshot) {

                if(!snapshot.hasData)
                {
                  return CircularProgressIndicator();

                  }
                else
                  {
                    Map<dynamic,dynamic> map=snapshot.data!.snapshot.value as dynamic;
                    List<dynamic>list=[];
                    list.clear();
                    list=map.values.toList();

                    return ListView.builder(
                      itemCount: snapshot.data!.snapshot.children.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(list[index]['User Name']),
                          subtitle: Text(list[index]['Message']),
                        );
                      },
                    );
                  }

              },
            )),
            Container(
             height: 50,
              child: Text("Method 1 of Fetching Data :FirebaseAnimatedList "),
            ),

            Expanded(
              //Impementation od Method 1
              child: FirebaseAnimatedList(
                  query: postRef,
                  defaultChild: Text("Loading....."),
                  itemBuilder: (context, snapshot, animation, index) {
                    return ListTile(
                      title: Text(snapshot.child('User Name').value.toString()),
                      subtitle:
                          Text(snapshot.child('Message').value.toString()),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
----------------------------------------------------------------------------------------------------------------------------
 */

/*

Implementation of Search Filter from database
---------------------------------------------------------------------------------------------------------------


class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final postRef = FirebaseDatabase.instance.ref('Post');
  final searchFiter=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Post Screen"),
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
                builder: (context) => AddPost(),
              ));
        },
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.indigo.shade100,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchFiter,
                decoration: InputDecoration(
                    hintText: "Search Here",
                    prefixIcon: Icon(Icons.search_rounded),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                onChanged: (String value){
                  setState(() {

                  });
                },
              ),
            ),
            Expanded(
              //Impementation od Method 1
              child: FirebaseAnimatedList(
                  query: postRef,
                  defaultChild: Text("Loading....."),
                  itemBuilder: (context, snapshot, animation, index) {
                    final search1=snapshot.child('Message').value.toString();
                    final search2=snapshot.child('User Name').value.toString();

                    if(searchFiter.text.isEmpty) //when user does not search anything
                    {
                      return ListTile(
                        title: Text(snapshot.child('User Name').value.toString()),
                        subtitle:
                        Text(snapshot.child('Message').value.toString()),
                      );
                    }
                    else if(search1.toLowerCase().contains(searchFiter.text.toLowerCase()) || search2.toLowerCase().contains(searchFiter.text.toLowerCase()) )
                    {    //When User Search something
                      return ListTile(
                        title: Text(snapshot.child('User Name').value.toString()),
                        subtitle:
                        Text(snapshot.child('Message').value.toString()),
                      );
                    }
                    else
                    {
                      return Container();

                      }

                  }),
            ),
          ],
        ),
      ),
    );
  }
}

------------------------------------------------------------------------------------------------------------------------------
 */

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final postRef = FirebaseDatabase.instance.ref('Post');
  final userController=TextEditingController();
  final msgController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Screen"),
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
                builder: (context) => AddPost(),
              ));
        },

      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.indigo.shade100,
        child: Column(
          children: [

            Expanded(
              //Impementation od Method 1
              child: FirebaseAnimatedList(
                  query: postRef,
                  defaultChild: Text("Loading....."),
                  itemBuilder: (context, snapshot, animation, index) {

                    final name=snapshot.child('User Name').value.toString();
                    final msg=snapshot.child('Message').value.toString();
                    final id=snapshot.child('Id').value.toString();

                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.supervised_user_circle),
                        title: Text(snapshot.child('User Name').value.toString()),
                        subtitle: Text(snapshot.child('Message').value.toString()),
                        trailing: PopupMenuButton(
                          icon: Icon(Icons.more_vert),
                          itemBuilder: (context) =>[
                            PopupMenuItem(
                                child:ListTile(
                                  leading: Icon(Icons.edit),
                                  title: Text("Edit"),
                                  onTap: (){
                                    Navigator.pop(context);
                                    openEditDialog(id,name,msg);
                                  },
                                )
                            ),
                            PopupMenuItem(
                                child:ListTile(
                                  leading: Icon(Icons.delete_outline),
                                  title: Text("Delate"),
                                  onTap: (){
                                    Navigator.pop(context);
                                    postRef.child(id).remove();
                                  },
                                )
                            ),


                          ]

                        ),

                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> openEditDialog(String id,String name,String msg) async{
    userController.text=name;
    msgController.text=msg;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Update"),
            content: Container(
              height: MediaQuery.of(context).size.width*0.7,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: userController,
                      decoration: InputDecoration(
                          hintText: "Enter Updated Name ",
                          border: OutlineInputBorder()
                      ),
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      maxLines: 4,
                      controller: msgController,
                      decoration: InputDecoration(
                          hintText: "Enter Updated Message  ",
                          border: OutlineInputBorder()
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Cancel",style: TextStyle(color: Colors.white),),
                style: TextButton.styleFrom(backgroundColor: Colors.indigo.shade300),
              ),
              TextButton(onPressed: (){
                Navigator.pop(context);
                postRef.child(id).update({
                  'User Name':userController.text.toString(),
                  'Message':msgController.text.toString(),

                }).then((value){
                  toastmsg().toast("Record Updated Successfully !");

                }).onError((error, stackTrace) {

                  toastmsg().Errortoast(error.toString());

                });
                
              }, 
                child: Text("Update",style: TextStyle(color: Colors.white),),
                style: TextButton.styleFrom(backgroundColor: Colors.indigo.shade300),
              ),
            ],

          );

        },);
  }
}

/*
content: Column(
              children: [
                TextFormField(
                  controller: userController,
                  decoration: InputDecoration(
                    hintText: "Enter Updated Name ",
                    border: OutlineInputBorder()
                  ),
                ),
                SizedBox(height: 15,),
                TextFormField(
                  controller: msgController,
                  decoration: InputDecoration(
                      hintText: "Enter Updated Message  ",
                      border: OutlineInputBorder()
                  ),
                ),
              ],
            ),
 */