import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvider extends ChangeNotifier {
  List<Map<dynamic, dynamic>> cartItems = [];

  // Constructor: Initialize the cartItems list by loading from local storage.
  CartProvider() {
    _loadCartItems();
  }

  void _loadCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve the cartItems list from local storage as JSON.
    String cartItemsJson = prefs.getString('cart_items') ?? '[]';
    // Convert the JSON string to a list of maps.
    cartItems = json.decode(cartItemsJson);
    notifyListeners();
  }

  void _saveCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convert the list of maps to JSON string.
    String cartItemsJson = json.encode(cartItems);
    // Save the JSON string to local storage.
    await prefs.remove('cart_items');
    await prefs.setString('cart_items', cartItemsJson);
  }

  void addCartItem(
      String id, String title, String image, int price, int quantity , String category) {
    Map<dynamic, dynamic> item = {
      'id': id,
      'title': title,
      'image': image,
      'price': price,
      'quantity': quantity,
      'category': category
    };
    cartItems.add(item);
    _saveCartItems(); // Save the updated cartItems list to local storage.
    notifyListeners();
  }

  void updateCartItem(String id, int price , int quantity) {
    cartItems.forEach((item) {
      if (item['id'] == id) {
        item['quantity'] = item['quantity'] + quantity;
      }
    });
    _saveCartItems(); // Save the updated cartItems list to local storage.
    notifyListeners();
  }

  void deleteCartItem(String id) {
    cartItems.removeWhere((item) => item['id'] == id);
    _saveCartItems(); // Save the updated cartItems list to local storage.
    notifyListeners();
  }

  void dropCart() {
    cartItems = [];
    _saveCartItems(); // Save the updated cartItems list to local storage.
    notifyListeners();
  }
}
