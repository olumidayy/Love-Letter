import 'package:cloud_firestore/cloud_firestore.dart';

class Letter {
 final String title;
 final String body;
 final DocumentReference reference;

 Letter.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['title'] != null),
       assert(map['body'] != null),
       title = map['title'],
       body = map['body'];

 Letter.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

 @override
 String toString() => "Letter<$title>";
}