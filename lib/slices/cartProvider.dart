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

  Future<void> _saveCartItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cartItemsJson = json.encode(cartItems);
    await prefs.setString('cart_items', cartItemsJson);
  }

  Future<void> addCartItem(
      String id, String title, String image, int price, int quantity, String category) async {
    Map<dynamic, dynamic> item = {
      'id': id,
      'title': title,
      'image': image,
      'price': price,
      'quantity': quantity,
      'category': category
    };
    cartItems.add(item);
    await _saveCartItems(); // Wait for the cart items to be saved.
    notifyListeners();
  }

  Future<void> updateCartItem(String id, int price, int quantity) async {
    cartItems.forEach((item) {
      if (item['id'] == id) {
        item['quantity'] = item['quantity'] + quantity;
      }
    });
    await _saveCartItems(); // Wait for the cart items to be saved.
    notifyListeners();
  }

  Future<void> deleteCartItem(String id) async {
    cartItems.removeWhere((item) => item['id'] == id);
    await _saveCartItems(); // Wait for the cart items to be saved.
    notifyListeners();
  }

  Future<void> dropCart() async {
    cartItems = [];
    await _saveCartItems(); // Wait for the cart items to be saved.
    notifyListeners();
  }

}
