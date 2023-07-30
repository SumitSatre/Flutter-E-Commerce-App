import 'package:ecommerce/screens/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage>{

  bool _isPasswordVisible = false;

  var LoginMessage = "";

  var pwdController = TextEditingController();
  var emailController = TextEditingController();

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
              child: Text("Sign Up" , style: TextStyle(fontSize: 28 , fontWeight: FontWeight.bold , color: Colors.redAccent )),
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


            // This is used for password
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
                        String email = emailController.text;
                        String password = pwdController.text;

                        if (email.isEmpty || password.isEmpty) {
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
                            'email': email,
                            'password': password,
                          };

                          var response = await http.post(
                            Uri.parse("https://flutter-app-backend-qy7f.onrender.com/api/user/login"),
                            headers: {
                              'Content-Type': 'application/json',
                            },
                            body: json.encode(data),
                          );

                          var responseData = json.decode(response.body);
                          LoginMessage = responseData['message']; // Store the message in LoginMessage variable

                          if (responseData['success']) {

                            var pref = await SharedPreferences.getInstance();
                            await pref.setString("authToken", responseData["authToken"]);

                            FocusScope.of(context).unfocus();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => MainPage()),
                                  (route) => false, // This predicate ensures that all previous routes are removed
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
                                  content: Text(LoginMessage),
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
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}

/*

Sure! Here's an explanation of the `LoginPage` with key points:

1. `LoginPage` is a `StatefulWidget` that provides a login interface to existing users.
2. It contains text fields for the user to enter their email and password.
3. The `_isPasswordVisible` boolean is used to toggle the visibility of the password field.
4. `emailController` and `pwdController` are used to manage the text entered in their respective text fields.
5. When the user clicks the "Continue" button, the `onPressed` callback is triggered.
6. It checks if both email and password fields are filled; if any field is empty,it shows an error dialog asking the user to fill in all fields.
7. If both fields are filled, it sends an HTTP POST request to the backend with the user's login credentials (email and password).
8. The backend processes the request and sends a response, which is received and decoded.
9. It checks the "success" field in the response; if it's true, the login is successful.
10. If login is successful, it saves the JSON Web Token (JWT) received in local storage using `SharedPreferences` and navigates the user to the `MyHomePage`. If login is unsuccessful (success is false), it shows an error dialog with the message received from the backend.
11. This `LoginPage` allows existing users to log in securely and efficiently while handling various scenarios to provide a smooth user experience.


 */