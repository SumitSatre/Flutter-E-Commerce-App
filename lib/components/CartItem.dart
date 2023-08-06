import 'package:flutter/material.dart';

class CartItemPage extends StatefulWidget {
  Map<dynamic, dynamic> cartItem = {};
  final Function? DeleteItemCallback ;
  final Function? updateCartItem ;

  CartItemPage({required this.cartItem , required this.DeleteItemCallback , required this.updateCartItem});

  @override
  State<CartItemPage> createState() => _CartItemPageState();
}

class _CartItemPageState extends State<CartItemPage> {

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 6.0,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Image(
              image: NetworkImage(widget.cartItem["image"]),
              fit: BoxFit.cover,
              height: 100,
              width: 80,
            ),
          ),

          SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.cartItem["title"],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "\₹${widget.cartItem["price"] * widget.cartItem["quantity"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),

                SizedBox(height: 5),

                Row(
                  children: [
                    Icon(Icons.category, size: 18),
                    SizedBox(width: 5),
                    Text(
                      widget.cartItem["category"],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (widget.cartItem["quantity"] > 1) {
                            widget.updateCartItem!(widget.cartItem["id"] , widget.cartItem["price"] , -1);
                          }
                        });
                      },
                      icon: Icon(Icons.remove),
                    ),
                    Text(
                      "${widget.cartItem["quantity"]}",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          widget.updateCartItem!(widget.cartItem["id"] , widget.cartItem["price"] , 1);
                        });
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              widget.DeleteItemCallback!(widget.cartItem["id"]);
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
