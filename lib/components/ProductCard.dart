import 'package:ecommerce/slices/cartProvider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/components/ViewProductPage.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  Map<dynamic, dynamic> product = {};

  ProductCard({required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int selectedQuantity = 1;

  @override

  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder : (context , cartProvider , child) => InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ViewProductPage(product: this.widget.product),
          ));
        },
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                    image: DecorationImage(
                      image: NetworkImage(widget.product["image"]),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product["title"],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Quantity:",
                            style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                          ),
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
                        ],
                      ),
                    ),

                    Text(
                      "\₹${(widget.product["price"] * 75 * selectedQuantity).toInt()}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.green,
                      ),
                    ),

                    SizedBox(height: 10),

                    Container(
                      height: 35,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          colors: [Color(0xFFf15a24), Color(0xFFffcb39)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                        onPressed: () {
                          Map<dynamic, dynamic>  temp = {};
                          int productPrice = widget.product["price"].toInt() * 75 * selectedQuantity;

                          cartProvider.cartItems.forEach((element) {
                            if (widget.product["_id"] == element["id"]) {
                              temp = element; // Assign 'element' instead of 'widget.product' to 'temp'
                            }
                          });

                          // Item is not present in the list so you have to add it
                          if(!temp.isEmpty){
                            cartProvider.addCartItem(widget.product["_id"] , widget.product["title"] , widget.product["image"]
                            ,productPrice , selectedQuantity , widget.product["category"]);
                          }


                          // Item is present in the list so you have to update it
                          else{
                            cartProvider.updateCartItem( widget.product["_id"] , widget.product["quantity"]
                                ,productPrice );
                          }

                        },
                        child: Text(
                          "Add to Cart",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
