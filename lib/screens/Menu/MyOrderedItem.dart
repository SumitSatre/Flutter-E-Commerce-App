import 'package:flutter/material.dart';

class MyOrderedItemPage extends StatelessWidget{

  Map<dynamic , dynamic> orderedItem = {};

  MyOrderedItemPage({required this.orderedItem })

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
              image: NetworkImage(orderedItem["image"]),
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
                  orderedItem["title"],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "\₹${orderedItem["price"] * orderedItem["quantity"]}",
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
                      orderedItem["category"],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
