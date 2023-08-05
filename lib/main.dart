import 'package:ecommerce/screens/Dashboard.dart';
import 'package:ecommerce/screens/SignUp.dart';
import 'package:ecommerce/slices/cartProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp( FlutterApp() );
}

class FlutterApp extends StatelessWidget{

   Future<Widget> checkLoginStatus() async {
     var pref = await SharedPreferences.getInstance();
     var getAuthToken = await pref.getString("authToken");

     if(getAuthToken != null && getAuthToken.length > 0){
       return MainPage();
     }
     return SignUpPage();
   }

   @override
   Widget build(BuildContext context) {
     return MultiProvider(
       providers: [
         ChangeNotifierProvider(create: (context)=> CartProvider() )
       ],
       child: MaterialApp(
         debugShowCheckedModeBanner: false,
         home: FutureBuilder<Widget>(
           future: checkLoginStatus(),
           builder: (context, snapshot) {
             if (snapshot.connectionState == ConnectionState.waiting) {
               // While the future is still running, show a loading indicator.
               return CircularProgressIndicator();
             } else if (snapshot.hasData) {
               // If the future completed successfully, show the data (widget).
               return snapshot.data!;
             } else {
               // If there was an error or no data, handle it accordingly.
               // For simplicity, let's return a Container as an example.
               return Container(
                 color: Colors.red,
                 child: Text('Error fetching data or no data available.'),
               );
             }
           },
         ),
       ),
     );
   }
}
