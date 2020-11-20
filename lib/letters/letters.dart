import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:love_letter/letter_detail/letter_detail.dart';
import 'package:love_letter/models/letter_model.dart';
import 'package:love_letter/new_letter/new_letter.dart';

import '../widgets/widgets.dart';

class Letters extends StatefulWidget {
  final FirebaseUser user;

  Letters(this.user);
  @override
  _LettersState createState() => _LettersState();
}

class _LettersState extends State<Letters> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Letters'),
        backgroundColor: Colors.deepPurple[900],
      ),
      drawer: LDrawer(user: widget.user),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('letters')
            .where('userID', isEqualTo: widget.user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          var letters = snapshot.data.documents;

          return letters.isEmpty
              ? Center(child: Text('No Saved Items yet'))
              : ListView.builder(
                  itemCount: letters.length,
                  itemBuilder: (context, index) {
                    var item = letters[index];
                    var letter = Letter.fromSnapshot(item);
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                        elevation: 4,
                          child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LetterDetail(
                                        letter: letter,
                                        user: widget.user,
                                      )));
                        },
                        title: Text(letter.title),
                      )),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple[900],
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => NewLetter(widget.user)));
        },
        tooltip: 'New letter',
        child: Icon(Icons.add),
      ),
    );
  }
}
