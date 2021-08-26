import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/header.dart';
import 'package:flutter_application_1/widgets/progress.dart';

final usersRef = FirebaseFirestore.instance.collection('users');

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<dynamic> users = [];
  @override
  void initState() {
    //getUsers();
    //getUsersById();
    //createUser();
    //updateUser();
    //deleteUser();
    super.initState();
  }

  createUser() {
    usersRef
        .doc("ahdhhahda")
        .set({"username": "Podio", "postsCount": 0, "isAdmin": false});
  }

  updateUser() async {
    final doc = await usersRef.doc("ahdhhahda").get();
    if (doc.exists) {
      doc.reference
          .update({"username": "Podio", "postsCount": 0, "isAdmin": false});
    }
  }

  deleteUser() async {
    final DocumentSnapshot doc = await usersRef.doc("ahdhhahda").get();
    if (doc.exists) {
      doc.reference.delete();
    }
  }

/*
  getUsers() async {
    final QuerySnapshot snapshot = await usersRef.get();

    setState(() {
      users = snapshot.docs;
    });

    //snapshot.docs.forEach((DocumentSnapshot doc) {
    
      print(doc.data());
      print(doc.exists);
      print(doc.id);
      
    });
    
  }
*/
/*
  getUsersById() async {
    final String id = 'BWvtG1fXvq13HXPAH5Yh';
    final DocumentSnapshot doc = await usersRef.doc(id).get();
    print(doc.data());
    print(doc.exists);
    print(doc.id);
            
  }
  */

  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: StreamBuilder<QuerySnapshot>(
          stream: usersRef.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return circularProgress();
            }
            final List<Text> children = snapshot.data!.docs
                .map((doc) => Text(doc['username']))
                .toList();
            return Container(
              child: ListView(
                children: children,
              ),
            );
          }),
      /*body: Container(
          child: ListView(children: users.map<Widget>((user) => Text(user['username'])).toList(),)
          ,)
    );
    */
    );
  }
}
