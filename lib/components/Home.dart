import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool _isCategoryDataFetched = false;
  List<String> list = ["https://source.unsplash.com/random/900x700/?biryani" , "https://source.unsplash.com/random/900x700/?biryani" , "https://source.unsplash.com/random/900x700/?biryani" , "https://source.unsplash.com/random/900x700/?biryani" , "https://source.unsplash.com/random/900x700/?biryani"];

  var CategoryData = [];

  void fetchData () async {
    var response = await http.get(Uri.parse("https://flutter-app-backend-qy7f.onrender.com/api/categories"));

    var responseData = json.decode(response.body);

    if(responseData["success"]){

        if(!_isCategoryDataFetched){
          setState(() {
            CategoryData = responseData["CategoryData"];
            _isCategoryDataFetched = true;
          });
        }
    }
  }

  @override
  void initState() {
    super.initState();

    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(20,110,180 ,1),
        title: const Text(
          "QuickShop",
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

      body: Column(
          children: [

            // Categories
            Card(
              child: Container(
                padding: EdgeInsets.only(top: 15 , bottom: 15),
                color: Colors.white,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: CategoryData != [] ?
                    CategoryData.map((value){
                      return Container(
                        padding: EdgeInsets.all(3),
                        margin: EdgeInsets.only(right: 5),
                        child: Column(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(value["imageUrl"]),
                              radius: 35,
                            ),

                            SizedBox(height: 8,),

                            Text(value["category"])
                          ],
                        ),
                      );
                    } ).toList()
                    : [Center(child: Text("No Data"))],
                  ),
                ),
              ),
            ),

            Container(
                child: CarouselSlider(
                  options: CarouselOptions(
                    disableCenter: true,
                  ),
                  items: list
                      .map((item) => Container(
                    child: Image(image: NetworkImage(item)),
                    color: Colors.green,
                  ))
                      .toList(),
                )),

          ],
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