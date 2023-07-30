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
      appBar: AppBar(
        title: const Text(
          "GeeksForGeeks",
        ),
        actions: [
          IconButton(
            onPressed: () {
              // method to show the search bar
              showSearch(
                context: context,
                // delegate to customize the search bar
                delegate: CustomSearchDelegate(),
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),

      body: _pages[_SelectedIndex],

      bottomNavigationBar: Container(
        color: Colors.grey.shade200, // Light grey background color
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: GNav(
            backgroundColor: Colors.grey.shade200, // Light grey background color
            color: Colors.black,
            activeColor: Colors.white, // White text color for the active tab
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


class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, ''); // Pass null as the result
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement your search results here
    return Center(
      child: Text('Search results for "$query"'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement your search suggestions here
    return ListView(
      children: [
        ListTile(title: Text('Suggestion 1')),
        ListTile(title: Text('Suggestion 2')),
        ListTile(title: Text('Suggestion 3')),
      ],
    );
  }
}