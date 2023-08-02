import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategryPage extends StatefulWidget {
  final String CategoryName;

  CategryPage({required this.CategoryName});

  @override
  State<StatefulWidget> createState() {
    return CategryPageState();
  }
}

class CategryPageState extends State<CategryPage> {
  List<dynamic> filteredProductData = [];

  Future<void> fetchCategoryProducts() async {
    var response = await http.get(
      Uri.parse("https://flutter-app-backend-qy7f.onrender.com/api/products/${widget.CategoryName}")
    );

    var responseData = await json.decode(response.body);

    if(responseData["success"]){
      filteredProductData = responseData["filteredData"];
    }

  }
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.CategoryName),
      ),
      body: FutureBuilder<void>(
        future: fetchCategoryProducts(),
        builder: (context , snapshot){
          if(snapshot.connectionState == ConnectionState.waiting ){
            return Center(child: CircularProgressIndicator());
          }

          else if(filteredProductData.isEmpty){
            return Center(
                child: Text("Sorry, No Data For This Category 😓😓" , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),)
            );
          }

          else{
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: filteredProductData.length,
              itemBuilder: (context, index) {
                var product = filteredProductData[index];
                return Card(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 2),
                        height: 110,
                        child: Image(
                          image: NetworkImage(product["image"]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(product["title"]),
                      Text("Price: \₹${(product["price"] * 75).toInt()}"),
                      Container(
                        height: 25,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(8, 129, 120, 1),
                          ),
                          onPressed: () {},
                          child: Text("Add to cart"),
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
/*

GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: filteredProductData.length,
        itemBuilder: (context, index) {
          var product = filteredProductData[index];
          return Card(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 2),
                  height: 110,
                  child: Image(
                    image: NetworkImage(product["image"]),
                    fit: BoxFit.cover,
                  ),
                ),
                Text(product["title"]),
                Text("Price: \₹${(product["price"] * 75).toInt()}"),
                Container(
                  height: 25,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Add to cart"),
                  ),
                )
              ],
            ),
          );
        },
      ) :
          Center(
              child: Text("Sorry, No Data For This Category" , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),)
          )
 */