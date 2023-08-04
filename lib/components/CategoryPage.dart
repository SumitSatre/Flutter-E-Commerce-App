import 'package:ecommerce/components/ProductCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ecommerce/components/ViewProductPage.dart';

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
                  childAspectRatio: 1/1.5
              ),
              itemCount: filteredProductData.length,
              itemBuilder: (context, index) {
                var product = filteredProductData[index];
                return ProductCard(product: product);
              },
            );
          }
        },
      ),
    );
  }
}