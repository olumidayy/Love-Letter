import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:love_letter/models/letter_model.dart';
import 'package:love_letter/widgets/widgets.dart';

class LetterDetail extends StatelessWidget {

  LetterDetail({@required this.letter, @required this.user});

  final Letter letter;
  final FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
          child: Icon(Icons.delete),
          onTap: (){
            showDeleteDialog(letter, user, context);
          },
        ),
        SizedBox(width: 15),
        GestureDetector(
            child: Icon(
              Icons.share,
              size: 20,
            ),
            onTap: () async {
              await Share.share(this.letter.body);
            },),
        SizedBox(width: 15),
        ],
        iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
        title: Text(
          letter.title,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(14),
          child: Text(letter.body,
              textAlign: TextAlign.left, style: TextStyle(fontSize: 15)),
        ),
      ),
    );
  }
}
