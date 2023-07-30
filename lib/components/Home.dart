import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var CategoryData = {};

  void fetchData () async {
    let responseData = await http.get(
      Uri("https://flutter-app-backend-qy7f.onrender.com/api/categories")
    );
  }

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
          children: [
            Row(
              children: [

              ],
            )
          ],
      ),
    );
  }
}

