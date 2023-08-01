import 'package:flutter/material.dart';

class CategryDescribe extends StatefulWidget {
  final String CategoryName;
  final List<dynamic> productData;

  CategryDescribe({required this.CategoryName, required this.productData});

  @override
  State<StatefulWidget> createState() {
    return CategoryDescribeState();
  }
}

class CategoryDescribeState extends State<CategryDescribe> {
  List<dynamic> filteredProductData = [];

  @override
  void initState() {
    super.initState();

    filteredProductData = widget.productData
        .where((data) => data["category"] == widget.CategoryName)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.CategoryName),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: filteredProductData.length,
        itemBuilder: (context, index) {
          var product = filteredProductData[index];
          return Card(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 2),
                  height: 110,
                  child: Image(
                    image: NetworkImage(product["image"]),
                    fit: BoxFit.cover,
                  ),
                ),
                Text(product["title"]),
                Text("Price: \₹${(product["price"] * 75).toInt()}"),
                Container(
                  height: 25,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Add to cart"),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
