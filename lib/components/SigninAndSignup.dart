import 'package:ecommerce/screens/Login.dart';
import 'package:ecommerce/screens/SignUp.dart';
import 'package:flutter/material.dart';

class SigninAndSignup extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [

            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(vertical: 10 , horizontal: 10),
                child: Text("Sign in for the best Experience!!🥰" , style: TextStyle(fontSize: 35 , fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
            ),

            Container(
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 7 , horizontal: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(204, 182, 96, 1.0),
                ),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginPage()));
                },
                child: Text("Sign in" , style: TextStyle(fontSize: 20, color: Colors.black)),
              ),
            ),

            Container(
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 7 , horizontal: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white60,
                ),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUpPage()));
                },
                child: Text("Create Account" , style: TextStyle(fontSize: 20 , color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }

}