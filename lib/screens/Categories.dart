import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ecommerce/components/CategoryPage.dart';


class CategoriesPage extends StatefulWidget{
  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  bool _isCategoryDataFetched = false;
  var categoryData = [];
  final http.Client _httpClient = http.Client();

  void fetchData () async {
    var response = await http.get(Uri.parse("https://flutter-app-backend-qy7f.onrender.com/api/categories"));
    var responseData = json.decode(response.body);

    if(responseData["success"]){
      setState(() {
        categoryData = responseData["CategoryData"];
      });
    }
  }

  @override
  void initState() {
    super.initState();

    if(!_isCategoryDataFetched){
      fetchData();
    }
  }

  @override
  void dispose() {
    // Cancel ongoing network requests to avoid memory leaks
    _httpClient.close();

    // Clear any lists or resources that might cause memory leaks
    categoryData.clear();
    // Stop any ongoing animations or timers here if needed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("QuickShop"),
        ),

        body: Container(
          padding: EdgeInsets.only(top: 20),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,

            ),
            itemCount: categoryData.length,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return CategryPage(CategoryName : categoryData[index]["category"]);
                    }));

                  },

                child: Container(
                  padding: EdgeInsets.all(3),
                  margin: EdgeInsets.only(right: 5),

                  child: Column(
                    children: [
                      Container(
                        height: 130,
                        width: 150,
                        child : Image(image : NetworkImage(categoryData[index]["imageUrl"]) , fit: BoxFit.cover,),
                      ),

                      SizedBox(height: 8,),

                      Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(categoryData[index]["category"] , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 13),)
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        )

    );
  }
}