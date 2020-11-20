import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:love_letter/auth/auth.dart';
import 'package:love_letter/models/letter_model.dart';
import 'package:love_letter/signin/signin.dart';
import '../letters/letters.dart';
import '../new_letter/new_letter.dart';

class LDrawer extends StatelessWidget {
  const LDrawer({
    Key key,
    @required this.user,
  }) : super(key: key);

  final FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple[900]),
            child: Column(
              children: <Widget>[
                SizedBox(height: 30),
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  user.email[0].toUpperCase(),
                  style: TextStyle(fontSize: 20.0, color: Colors.deepPurple[900]),
                ),
              ),
              SizedBox(height: 20,),
              Text(
                  user.email,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
            ],),
          ),
          ListTile(
            title: Text('Letters'),
            trailing: Icon(Icons.mail),
            onTap: () => Navigator.pushReplacement(context,
                       MaterialPageRoute(builder: (context) => Letters(user))),
          ),
          Divider(color: Colors.grey),
          ListTile(
            title: Text("New Letter"),
            trailing: Icon(Icons.add),
            onTap: () => Navigator.pushReplacement(context,
                       MaterialPageRoute(builder: (context) => NewLetter(user)))
          ),
          Divider(color: Colors.grey),
          ListTile(
            title: Text("Logout"),
            trailing: Icon(Icons.exit_to_app),
            onTap: () async {
              AuthProvider authProvider = new AuthProvider();
              await authProvider.logOut();
              Navigator.pushReplacement(context,
                       MaterialPageRoute(builder: (context) => SignIn()));
            }
          ),
        ],
      )
    );
  }
}


Future<void> showDeleteDialog(Letter letter, FirebaseUser user, BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.all(16),
        title: Text('Delete ?'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
        ),
        content: Text('Are you sure you want to delete this ? '),
        actions: <Widget>[
          FlatButton(onPressed: (){
            Navigator.pop(context);
          }, 
          child: Text('Cancel')),
          FlatButton(onPressed: (){
            letter.reference.delete();
            Navigator.pop(context);
            Navigator.pop(context);
          }, 
          child: Text('Delete', style: TextStyle(color: Colors.red),)),
        ],
      );
    },
  );
}
