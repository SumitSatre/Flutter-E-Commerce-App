import 'package:ecommerce/components/Categories.dart';
import 'package:ecommerce/components/Home.dart';
import 'package:ecommerce/components/Menu.dart';
import 'package:ecommerce/components/cart.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainPage extends StatefulWidget{

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _SelectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    CategoriesPage(),
    CartPage(),
    MenuPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[_SelectedIndex],

      bottomNavigationBar: Container(
        color: Color.fromRGBO(19, 111, 180, 0.98), // Light grey background color
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: GNav(
            backgroundColor: Color.fromRGBO(19, 111, 180, 1.0), // Light grey background color
            color: Colors.white,
            activeColor: Colors.black,
            tabActiveBorder: Border.all(width: 1 , color: Colors.black54),// White text color for the active tab
            tabBackgroundColor: Colors.blue, // Blue background color for the tabs
            gap: 4,
            tabs: [
              GButton(
                icon: Icons.home_outlined,
                text: "Home",
              ),
              GButton(
                icon: Icons.category_outlined,
                text: "Categories",
              ),
              GButton(
                icon: Icons.shopping_cart,
                text: "Cart",
              ),
              GButton(
                icon: Icons.person_outline,
                text: "You",
              ),
            ],
            selectedIndex: _SelectedIndex,
            onTabChange: (index){
              setState(() {
                _SelectedIndex = index;
              });
            },
          ),
        ),
      ),

    );
  }
}