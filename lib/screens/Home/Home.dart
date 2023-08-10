import 'dart:async';
import 'package:ecommerce/components/Carousel.dart';
import 'package:ecommerce/screens/Categories/CategoryPage.dart';
import 'package:ecommerce/components/ProductCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List categoryData = [];
  List productData = [];

  Future<void> fetchData() async {
    var response =
    await http.get(Uri.parse("https://flutter-app-backend-qy7f.onrender.com/api/categories"));
    var responseData = json.decode(response.body);

    if (responseData["success"]) {
      categoryData = responseData["CategoryData"];
    }

    response = await http.get(Uri.parse("https://flutter-app-backend-qy7f.onrender.com/api/products"));
    responseData = json.decode(response.body);

    if (responseData["success"]) {
      productData = responseData["productsData"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(20, 110, 180, 1),
        title: const Text("QuickShop"),
      ),
      body: FutureBuilder<void>(
        future: fetchData(),
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Oops, Something Wrong Cannot Access Data",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            );
          }

          else {
            return ListView(
              children: [
                // Category Scroll Card
                Card(
                  child: Container(
                    padding: EdgeInsets.only(top: 15, bottom: 15),
                    color: Colors.white,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: categoryData.isNotEmpty
                            ? categoryData.map(
                              (value) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return CategryPage(CategoryName: value["category"]);
                                    },
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(3),
                                margin: EdgeInsets.only(right: 5),
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(value["imageUrl"]),
                                      radius: 35,
                                    ),
                                    SizedBox(height: 8),
                                    Text(value["category"]),
                                  ],
                                ),
                              ),
                            );
                          },
                        ).toList()
                            : [Center(child: Text("No Data"))],
                      ),
                    ),
                  ),
                )
                ,

                // Carousel
                Carousel(),

                // Top picks for you
                Container(
                  height: 60,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20, top: 20, bottom: 10),
                  margin: EdgeInsets.only(bottom: 20),
                  color: Color.fromRGBO(210, 176, 215, 0.45),
                  child: Text(
                    "Top picks for you!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),

                // Grid view for products
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1 / 1.5,
                  ),
                  itemCount: productData.length,
                  itemBuilder: (context, index) {
                    return ProductCard(product: productData[index]);
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
