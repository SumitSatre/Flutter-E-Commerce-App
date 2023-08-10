import 'package:ecommerce/screens/Cart/CartItem.dart';
import 'package:ecommerce/screens/Cart/EmptyCart.dart';
import 'package:ecommerce/components/SigninAndSignup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerce/slices/cartProvider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var isUserLoggedIn = false;
  var UserEmail;
  var responseData;

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
      int price = item["price"] * item["quantity"] ?? 0;
      totalPrice = totalPrice + price;
    });

    return totalPrice;
  }

  Future<bool> HandleBuyNow(CartData) async {
    var data = {
      "email": UserEmail,
      "order_date": DateTime.now().toString(),
      "ordersData": CartData,
    };

    var response = await http.post(
      Uri.parse("https://flutter-app-backend-qy7f.onrender.com/api/myorders/update"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

     responseData = json.decode(response.body);

    if (responseData["success"]) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) => Scaffold(
        appBar: AppBar(),
        body: FutureBuilder<void>(
          future: checkUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (!isUserLoggedIn) {
              return SigninAndSignup();
            } else {
              return cartProvider.cartItems.isEmpty
                  ? EmptyCart()
                  : Scaffold(
                body: Container(
                  child: ListView.builder(
                    itemCount: cartProvider.cartItems.length,
                    itemBuilder: (context, index) {
                      return CartItemPage(
                        cartItem: cartProvider.cartItems[index],
                        DeleteItemCallback: cartProvider.deleteCartItem,
                        updateCartItem: cartProvider.updateCartItem,
                      );
                    },
                  ),
                ),
                bottomNavigationBar: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Total Price : ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "${calculateTotalPrice(cartProvider.cartItems)}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 170,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return FutureBuilder<bool>(
                                future: HandleBuyNow(cartProvider.cartItems),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(child: CircularProgressIndicator());
                                  } else if (!snapshot.hasData) {
                                    return AlertDialog(
                                      title: Text('Sorry,'),
                                      content: Text(responseData.toString()),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  } else {
                                    if (snapshot.data == true) {
                                      cartProvider.dropCart();
                                      return AlertDialog(
                                        title: Text('Thank you,'),
                                        content: Text(responseData["message"].toString()),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('OK'),
                                          ),
                                        ],
                                      );
                                    }
                                    // Handle failure scenario here
                                    return AlertDialog(
                                      title: Text('Sorry'),
                                      content: Text("Something went wrong!!"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  }
                                },
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.orange,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        child: Text(
                          "Buy Now",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
