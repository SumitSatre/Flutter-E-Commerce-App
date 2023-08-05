import 'package:ecommerce/components/CartItem.dart';
import 'package:ecommerce/components/EmptyCart.dart';
import 'package:ecommerce/components/SigninAndSignup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce/slices/cartProvider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget{

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var isUserLoggedIn = false;
  List<dynamic> cartData = [];
  var UserEmail;

  Future<void> checkUser() async {
    var pref = await SharedPreferences.getInstance();
    var token = await pref.getString("authToken");

    if (token != null) {
      isUserLoggedIn = true;
    }

    UserEmail = await pref.getString("emailToken");
  }

  int calculateTotalPrice(List<dynamic> cartItems) {
    var totalPrice = 0;

    cartItems.forEach((item) {
      int price = item["price"] ?? 0;
      totalPrice = totalPrice + price;
    });

    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder : (context , cartProvider , child) => Scaffold(
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
              return cartProvider.cartItems.isEmpty ?
              EmptyCart() :
              Scaffold(
                body : Container(
                  child: ListView.builder(itemBuilder: (context, index) {
                    return CartItemPage(cartItem: cartProvider.cartItems[index] , DeleteItemCallback : cartProvider.deleteCartItem);
                  },
                    itemCount: cartProvider.cartItems.length,
                  ),
                ),

                bottomNavigationBar: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Total Price : ${calculateTotalPrice(cartProvider.cartItems)}")
                    ,
                    ElevatedButton(
                      onPressed: () {
                        print("Hi");
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.orange, // Text color
                        elevation: 4, // Elevation
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10), // Rounded corners
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Padding
                      ),
                      child: Text(
                        "Buy Now",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                  ],
                ),
              );
            }
          },
        )
        ,
      ),
    );
  }
}
