import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:ecommerce/components/CategoryPage.dart';
import 'package:ecommerce/components/ViewProductPage.dart';
import 'package:ecommerce/screens/Categories.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductCard extends StatefulWidget {
  Map<String, dynamic> product = {};

  ProductCard({required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int selectedQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewProductPage(product : this.widget.product)));
      },
      child: Card(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12 , width: 0.5)
              ),
              padding: EdgeInsets.only(top: 10,  left: 5 , right: 5, bottom: 2),
              height: 110,
              child: Image(
                image: NetworkImage(widget.product["image"]),
                fit: BoxFit.cover,
              ),
            ),

            Text(widget.product["title"] , style: TextStyle(fontWeight: FontWeight.bold),),

            // Choose Quantity Dropdown
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Choose Quantity:"),
                      DropdownButton<int>(
                        value: selectedQuantity,
                        items: List.generate(6, (i) => i + 1)
                            .map((value) => DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedQuantity = value!;
                          });
                        },
                      ),
                    ]
                )
            ),

            Text("\₹${(widget.product["price"]*75*selectedQuantity).toInt()}", style: TextStyle(fontWeight: FontWeight.bold , fontSize: 20)),

            Container(
              height : 35,
              margin: EdgeInsets.only(top: 5),
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
  }
}