import 'package:flutter/material.dart';

class ViewProductPage extends StatelessWidget {
  final Map<String, dynamic> product;

  ViewProductPage({required this.product});

  @override
  Widget build(BuildContext context) {
    int productPrice = (product["price"] * 75).toInt();

    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white38,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20, left: 18),
                alignment: Alignment.centerLeft,
                child: Text(
                  product["title"],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30 , color: Colors.black),
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 5, left: 18),
                alignment: Alignment.centerLeft,
                child: Text(
                  product["category"],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15 , color: Colors.redAccent),
                ),
              ),

              Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(15),
                child: Image(
                  image: NetworkImage(product["image"]),
                  height: 350,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              Container(
                height: 35,
                color: Colors.greenAccent,
                alignment: Alignment.center,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text : "24% OFF ",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28 , color: Colors.red),
                      ),

                      TextSpan(
                        text : "₹${(productPrice + (productPrice * 24) / 100).toInt()}",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25 ,color: Colors.blue,decoration: TextDecoration.lineThrough,
                          decorationStyle: TextDecorationStyle.solid,),
                      ),

                      TextSpan(
                        text : "  ₹$productPrice",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27 ,color: Colors.black),
                      ),
                    ]
                  ),
                )
              ),


              Container(
                margin: EdgeInsets.only(top: 10),
                child: RichText(
                  text: TextSpan(
                    children: [

                      TextSpan(text : "About Product : " ,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20 ,color: Colors.orange),),

                      TextSpan(text : " ${product["description"]}" ,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15 ,color: Colors.black , height: 1.2),),

                    ]
                  ),
                )
              ),

              Container(
                height: 60,
                width: 250,
                margin: EdgeInsets.symmetric(vertical: 18),
                child: ElevatedButton(
                  clipBehavior: Clip.hardEdge,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(8, 129, 120, 1),
                  ),
                  onPressed: () {
                    // Add your onPressed function here
                  },
                  child: Text("Add to cart" , style: TextStyle(fontSize: 20),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
