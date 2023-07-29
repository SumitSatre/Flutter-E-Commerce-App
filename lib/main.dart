import 'package:ecommerce/screens/Home.dart';
import 'package:ecommerce/screens/SignUp.dart';
import 'package:flutter/material.dart';

void main(){
  runApp( FlutterApp() );
}

class FlutterApp extends StatelessWidget{

  // Widget CheckLoginStatus(){}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignUpPage(),
    );
  }

}
