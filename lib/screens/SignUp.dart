import 'package:ecommerce/screens/Home.dart';
import 'package:ecommerce/screens/Login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage>{

  bool _isPasswordVisible = false;

  var signUpMessage = "";

  var nameController = TextEditingController();
  var pwdController = TextEditingController();
  var emailController = TextEditingController();
  var contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome," , style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold ),),
        backgroundColor: Colors.cyan,
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.only(top: 15 , left: 20),
              child: Text("Create Account" , style: TextStyle(fontSize: 28 , fontWeight: FontWeight.bold , color: Colors.redAccent )),
            ),

            Container(
              margin: EdgeInsets.only(top: 20 , bottom: 7),
              child: Center(
                child: FractionallySizedBox(
                    widthFactor: 0.8,
                    child: TextField(
                      controller : nameController,
                      decoration: InputDecoration(
                          hintText: "First and last name",
                          prefixIcon: Icon(Icons.person_outline_outlined ) ,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),

                          )
                      ),
                    )
                ),
              ),
            ),

            // This is used for email
            Container(
              margin: EdgeInsets.only(top: 10 , bottom: 7),
              child: Center(
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: TextField(
                    controller : emailController,
                    decoration: InputDecoration(
                        hintText: "Enter Email ",
                        suffixText: ".com",
                        prefixIcon: Icon(Icons.email_outlined ) ,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),

                        )
                    ),
                  )
                ),
              ),
            ),

            // Mobile number
            Container(
              margin: EdgeInsets.only(top: 20 , bottom: 7),
              child: Center(
                child: FractionallySizedBox(
                    widthFactor: 0.8,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller : contactController,
                      decoration: InputDecoration(
                        prefixText: "+91",
                          hintText: "Mobile number",
                          prefixIcon: Icon(Icons.phone ) ,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),

                          )
                      ),
                    )
                ),
              ),
            ),


            Container(
              margin: EdgeInsets.only(top: 20 , bottom: 7),
              child: Center(
                child: FractionallySizedBox(
                    widthFactor: 0.8,
                    child: TextField(
                      controller : pwdController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                          hintText: "set password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.redAccent,
                          ),
                          onPressed: (){
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    )
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

              Container(
              margin: EdgeInsets.only(right: 20, left: 15),
              height: 50,
              width: 100,
              child: ElevatedButton(
                onPressed: () async {
                  String name = nameController.text;
                  String email = emailController.text;
                  String password = pwdController.text;
                  String contact = contactController.text;

                  if (name.isEmpty || email.isEmpty || password.isEmpty || contact.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('Please fill in all the fields.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    var data = {
                      'name': name,
                      'email': email,
                      'password': password,
                      'contact': contact,
                    };

                    var response = await http.post(
                      Uri.parse("https://flutter-app-backend-qy7f.onrender.com/api/user/signup"),
                      headers: {
                        'Content-Type': 'application/json',
                      },
                      body: json.encode(data),
                    );

                    var responseData = json.decode(response.body);
                    signUpMessage = responseData['message']; // Store the message in signUpMessage variable

                    if (responseData['success']) {
                      FocusScope.of(context).unfocus();
                      await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                    } else {
                      // This automatically close the keyboard
                      FocusScope.of(context).unfocus();
                      // Show the AlertDialog with the signUpMessage
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Thank You'),
                            content: Text(signUpMessage),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                },
                child: Text("Continue"),
              ),
            ),


            Container(
                    margin: EdgeInsets.only(right: 20, left: 15),
                    height: 50,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage() ));
                      },
                      child: Text("Login"),
                    ),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}