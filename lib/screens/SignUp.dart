import 'package:ecommerce/components/Home.dart';
import 'package:ecommerce/screens/Dashboard.dart';
import 'package:ecommerce/screens/Login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage>{

  bool _isPasswordVisible = false;

  var nameController = TextEditingController();
  var pwdController = TextEditingController();
  var emailController = TextEditingController();
  var contactController = TextEditingController();


  Future<void> registerUser(name , email , password , contact) async {

    // First we checck all values filled for not if not show dialog box
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
    }
    // start the procedure of post api
    else {
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
      var signUpMessage = responseData['message']; // Store the message in signUpMessage variable

      // If post api fetched correctly
      if (responseData['success']) {

        var pref = await SharedPreferences.getInstance();
        await pref.setString("authToken", responseData["authToken"]);

        FocusScope.of(context).unfocus();
        await Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      }

      // if post api fetched unsuccessfully
      else {
        // This automatically close the keyboard
        FocusScope.of(context).unfocus();
        // Show the AlertDialog with the signUpMessage
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sorry,'),
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
  }

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


            // Password
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

            /* Two buttons Continue and login
             On click Continue ->
                1.Check if all text fields are filled. If any field is empty, show an error dialog.
                2.If all fields are filled, send an HTTP POST request to the backend with the user data.
                3.Receive the response from the backend and check if the "success" field is true or false.
                4.If "success" is true, save the JSON Web Token (JWT) in local storage (SharedPreferences).
                5.Navigate to the Home page.
                6.If "success" is false, show an error dialog with the message received from the backend.
             */

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

                  await registerUser(name , email , password , contact);

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
            ),

            Container(
              margin: EdgeInsets.all(10),
              child: TextButton(
                  onPressed: ()async  {
                    await Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                    );
                  },
                  child: Text("Skip sign in" , style: TextStyle(color: Colors.blue , fontSize: 17),)),
            )

          ],
        ),
      ),
    );
  }
}

/*

SignUpPage explanation:

1. `SignUpPage` is a `StatefulWidget` that provides a form to create a new user account.
2. It contains text fields for the user to enter their name, email, contact number, and password(4 text fields).
3. The `_isPasswordVisible` boolean is used to toggle the visibility of the password field.
4. `nameController`, `emailController`, `contactController`, and `pwdController` are used to manage the text entered in their respective
    text fields.
5. When the user clicks the "Continue" button, the `onPressed` callback is triggered.
6. It checks if all text fields are filled; if any field is empty, it shows an error dialog asking the user to fill in all fields.
7. If all fields are filled, it sends an HTTP POST request to the backend with the user data (name, email, contact, password).
8. The backend processes the request and sends a response, which is received and decoded.
9. It checks the "success" field in the response; if it's true, the sign-up is successful.
10. If sign-up is successful, it saves the JSON Web Token (JWT) received in local storage using `SharedPreferences`.
11. The user is then navigated to the `MyHomePage` (Home page) using `Navigator.pushReplacement` to ensure the user can't go back to the SignUpPage.
12. If sign-up is unsuccessful (success is false), it shows an error dialog with the message received from the backend.
13. The "Login" button takes the user to the `LoginPage` using `Navigator.push`.
14. The user can enter the required details and click "Continue" to sign up, or they can click "Login" to navigate to the login page.
15. The page provides a user-friendly interface for signing up and handling various scenarios for a smooth user experience.
 */