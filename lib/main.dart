
import 'package:flutter/material.dart';
import 'package:love_letter/signin/signin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     title: 'Love Letter',
     home: SignIn(),
   );
 }
}
