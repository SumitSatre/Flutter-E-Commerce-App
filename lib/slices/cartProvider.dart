import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class cartProvider extends ChangeNotifier{
  List<Map<dynamic , dynamic>> cartItems =  [];

  Future<void> storeCartInMongoDbStorage() async {

    var pref = await SharedPreferences.getInstance();
    var UserEmail = await pref.getString("emailToken");

    if(UserEmail != null){
      var response = await http.post(
          Uri.parse("https://flutter-app-backend-qy7f.onrender.com/cart/update"),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            "email" : UserEmail,
            "orderData" : cartItems
          })
      );
    }
  }


  AddCartItem(String id ,String title ,String image ,int price ,int quantity ,String category){
    Map<dynamic , dynamic> item = {'id' : id , 'title' : title , 'image' : image, 'price' : price , 'quantity' : quantity , 'category' : quantity};
    cartItems.add(item);
    storeCartInMongoDbStorage();
    notifyListeners();
  }

  void updateCartItem(String id, int quantity, int price) {
    cartItems.forEach((item) {
      if (item['id'] == id) {
        item['quantity'] += quantity;
        item['price'] += price;
      }
    });

    storeCartInMongoDbStorage();
    notifyListeners(); // Notify listeners about the change in the cartItems list
  }

  void DeleteCartItem(String id){
    cartItems.removeWhere((item) =>  (item['id'] == id));

    storeCartInMongoDbStorage();
    notifyListeners();
  }

  void DropCart(){
    cartItems = [];

    storeCartInMongoDbStorage();
    notifyListeners();
  }

}