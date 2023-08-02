import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ecommerce/components/CategoryPage.dart';


class CategoriesPage extends StatefulWidget{
  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  var categoryData = [];
  final http.Client _httpClient = http.Client();

  Future<void> fetchCategoriesData () async {
    var response = await http.get(Uri.parse("https://flutter-app-backend-qy7f.onrender.com/api/categories"));
    var responseData = json.decode(response.body);

    if(responseData["success"]){
      categoryData = responseData["CategoryData"];
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

        body: FutureBuilder<void>(
          future: fetchCategoriesData(),
          builder: (context , snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }

            else if(snapshot.hasError){
              return Center(child: Text("Oops, Cannot Access Data" , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 25),),);
            }

            else{
              return Container(
                padding: EdgeInsets.only(top: 20),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
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
              ;
            }
          },
        ),

    );
  }
}
