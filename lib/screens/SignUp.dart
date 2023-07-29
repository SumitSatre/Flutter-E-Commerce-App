import 'package:flutter/material.dart';


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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome," , style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold ),),
        backgroundColor: Colors.cyan,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.only(top: 15 , left: 20),
            child: Text("Sign Up" , style: TextStyle(fontSize: 28 , fontWeight: FontWeight.bold , color: Colors.redAccent )),
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

          Row(
            children: [
              ElevatedButton(
                  onPressed: (){,
                  child: Text("Continue")
              )
            ],
          )
        ],
      ),
    );
  }
}