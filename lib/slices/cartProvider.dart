import 'package:flutter/material.dart';

class cartProvider extends ChangeNotifier{
  List<Map<dynamic , dynamic>> cartItems =  [];

  AddCartItem(String id ,String title ,String image ,int price ,int quantity ,String category){
    Map<dynamic , dynamic> item = {'id' : id , 'title' : title , 'image' : image, 'price' : price , 'quantity' : quantity , 'category' : quantity};
    cartItems.add(item);
    notifyListeners();
  }

  void updateCartItem(String id, int quantity, int price) {
    cartItems.forEach((item) {
      if (item['id'] == id) {
        item['quantity'] += quantity;
        item['price'] += price;
      }
    });
    notifyListeners(); // Notify listeners about the change in the cartItems list
  }

  void DeleteCartItem(String id){
    cartItems.removeWhere((item) {
      return (item['id'] == id);
  }

  void DropCart(){
    cartItems = [];
  }

}