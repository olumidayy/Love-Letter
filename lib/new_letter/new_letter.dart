import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:love_letter/letter_detail/letter_detail.dart';
import 'package:love_letter/letters/letters.dart';
import 'package:love_letter/models/letter_model.dart';
import '../widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewLetter extends StatefulWidget {
  final FirebaseUser user;

  NewLetter(this.user);
  @override
  _NewLetterState createState() => _NewLetterState();
}

class _NewLetterState extends State<NewLetter> {

  
  bool checkStr(String str) => str != null && str.isNotEmpty;

  String title, body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Letter'), backgroundColor: Colors.deepPurple[900],),
      drawer: LDrawer(user: widget.user),
      body: SafeArea(
              child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
                    child: Column(
              children: <Widget>[
            TextField(
                  onChanged: (str) {
                    setState(() {
                      title = str;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Title: ',
                      filled: true,
                      fillColor: Color(0xFFE5E4F1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ))),
            SizedBox(height: 20,),
            TextField(
                  onChanged: (str) {
                    setState(() {
                      body = str;
                    });
                  },
                  maxLines: 16,
                  decoration: InputDecoration(
                    labelText: 'body',
                      filled: true,
                      fillColor: Color(0xFFE5E4F1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ))),
            SizedBox(height: 20),
            Container(
              width: 150,
              height: 40,
              child: RaisedButton(
                color: Colors.deepPurple[700],
                onPressed: () async {
                  print(checkStr(body));
                  if(checkStr(title) && checkStr(body)){
                    var data = {
                      'title': title,
                      'body': body,
                      'userID': widget.user.uid
                    };
                    await Firestore.instance.collection('letters').add(data);
                    await Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Letters(widget.user)));
                  }              
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Text(
                  'Create',
                  style: TextStyle(color: Colors.white, letterSpacing: 1.5),
                ),
              ),
            ) 
        ],),
          ),),
      ),
    );
  }
}