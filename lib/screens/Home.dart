import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:ecommerce/components/CategoryPage.dart';
import 'package:ecommerce/components/ViewProductPage.dart';
import 'package:ecommerce/screens/Categories.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isCategoryDataFetched = false;
  List<Widget> carouselImages = [];
  var categoryData = [];
  var productData = [];

  Future<void> fetchCategoryData () async {
    var response = await http.get(Uri.parse("https://flutter-app-backend-qy7f.onrender.com/api/categories"));
    var responseData = json.decode(response.body);

    if(responseData["success"]){
      categoryData = responseData["CategoryData"];
    }
  }

  Future<void> fetchProductData () async {
    var response = await http.get(Uri.parse("https://flutter-app-backend-qy7f.onrender.com/api/products"));
    var responseData = json.decode(response.body);

    if(responseData["success"]){
      productData = responseData["productsData"];
    }
  }

  @override
  void initState() {
    super.initState();

    carouselImages.addAll([
      Image.network("https://source.unsplash.com/random/900x700/?fashion"),
      Image.network("https://source.unsplash.com/random/900x700/?girl"),
      Image.network("https://source.unsplash.com/random/900x700/?women"),
    ]);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(20, 110, 180, 1),
        title: const Text(
          "QuickShop",
        ),
      ),
      body: ListView(
        children: [

          // Category Scroll Card
          FutureBuilder<void>(
              future: fetchCategoryData(),
              builder: (context , snapshot){

                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                }

                else if(snapshot.hasError){
                  return Center(child: Text("Oops, Cannot Access Data" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 25),),);
                }

                else{
                  return Card(
                    child: Container(
                      padding: EdgeInsets.only(top: 15 , bottom: 15),
                      color: Colors.white,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: categoryData != [] ?
                          categoryData.map((value){
                            return InkWell(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                  return CategryPage(CategoryName : value["category"]);
                                }));

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

                                    SizedBox(height: 8,),

                                    Text(value["category"])
                                  ],
                                ),
                              ),
                            );
                          } ).toList()
                              : [Center(child: Text("No Data"))],
                        ),
                      ),
                    ),
                  );
                }  // else
              } // FutureBuilder builder
          ),

          // Carousel
          SizedBox(
            height: 250,
            width: double.infinity,
            child: carouselImages.isNotEmpty
                ? AnotherCarousel(
              images: carouselImages,
              dotSize: 6,
              indicatorBgPadding: 10,
              dotIncreasedColor: Colors.lightBlue,
              autoplay: true,
              autoplayDuration: Duration(seconds: 8),
            )
                : Center(child: Text("No Images")),
          ),


          // Top picks for you
          Container(
            height: 60,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20 , top: 20 , bottom: 10),
            margin: EdgeInsets.only( bottom: 20),
            color: Color.fromRGBO(210, 176, 215, 0.45),
            child: Text("Top picks for you!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          ),

          // Grid view for products
          FutureBuilder<void>(
              future: fetchProductData(),
              builder: (context , snapshot){

                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator());
                }

                else if(snapshot.hasError){
                  return Center(child: Text("Oops, Cannot Access Data" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 25),),);
                }

                else{
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,

                    ),
                    itemCount: productData.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewProductPage(product :productData[index])));
                        },
                        child: Card(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 10,  left: 20 , right: 20 , bottom: 2),
                                height: 110,
                                child: Image(
                                  image: NetworkImage(productData[index]["image"]),
                                  fit: BoxFit.cover,
                                ),
                              ),

                              Text(productData[index]["title"]),

                              Text("Price: \₹${(productData[index]["price"]*75).toInt()}"),

                              Container(
                                height : 25,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color.fromRGBO(8, 129, 120, 1),
                                  ),
                                  onPressed: () {
                                    // Add your onPressed function here
                                  },
                                  child: Text("Add to cart"),
                                ),

                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }
          )

        ],
      ),
    );
  }
}
