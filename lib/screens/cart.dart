import 'package:ecommerce/components/CartItem.dart';
import 'package:ecommerce/components/EmptyCart.dart';
import 'package:ecommerce/components/SigninAndSignup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget{

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var isUserLoggedIn = false;
  List<dynamic> cartData = [];

  Future<void> checkUser() async {
    var pref = await SharedPreferences.getInstance();
    var token = await pref.getString("authToken");

    var UserEmail = await pref.getString("emailToken");

    if (token != null) {
      isUserLoggedIn = true;
    }
  }

  Future<void> getCart() async {
    if(isUserLoggedIn){
      var response = await http.post(
          Uri.parse("https://flutter-app-backend-qy7f.onrender.com/api/cart") ,

      );
      var responseData = json.decode(response.body);

      if(responseData["success"]){
        setState(() {

        });
        cartData = responseData["UserCart"];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),

      body: FutureBuilder<void>(
        future: checkUser(),
        builder: (context , snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          else if(!isUserLoggedIn){
            return SigninAndSignup();
          }
          else{
            return cartData.isEmpty ?
            Text(cartData.toString()) :
            Container(
              child: ListView.builder(itemBuilder: (context, index) {
                  return CartItemPage(cartItem: cartData[index]);
                },
                  itemCount: cartData.length,
                  reverse: true,
                  itemExtent: 200,
                ),

            )
            ;
          }
        },
      )
      ,
    );
  }
}
