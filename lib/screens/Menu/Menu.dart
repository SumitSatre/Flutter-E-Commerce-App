import 'package:ecommerce/components/SigninAndSignup.dart';
import 'package:ecommerce/screens/Menu/sourceCodeLink.dart';
import 'package:ecommerce/screens/Cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuPage extends StatefulWidget{

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

  List<String> MenuListItems = ["Address" , "MyOrders" , "MyCart" , "Get source code" ];
  List<Widget> MenuListWidgets = [CartPage() , CartPage() , CartPage() , ChromeLinkWidget(url: Uri.parse("https://github.com/SumitSatre/Flutter-E-Commerce-App"))];

  var isUserLoggedIn = false;

  Future<void> checkUser() async {
    var pref = await SharedPreferences.getInstance();
    var token = await pref.getString("authToken");

    if (token != null) {
      isUserLoggedIn = true;
    }
  }

  @override
  void initState() {
    super.initState();

    checkUser();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QuickShop"),
      ),
      body: FutureBuilder<void>(
        future: checkUser(),
        builder: (context , snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }

          else if(snapshot.hasError || isUserLoggedIn == false){
            return SigninAndSignup();
          }
          else{
            return  ListView.separated(itemBuilder: (context , index){
              return InkWell(

                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MenuListWidgets[index]));
                },

                child: ListTile(
                leading: Text("${index+1}" ,style: TextStyle(fontSize: 20),),
                title: Text("${MenuListItems[index]}" ,style: TextStyle(fontSize: 20)),
                subtitle: Text("Number"),
                trailing: Icon(Icons.arrow_forward_ios),
            ),
              );
            },

            itemCount: MenuListItems.length,

            separatorBuilder: (context, index) {
              return Container(height: 30);
            }
            );
          }
        },
      ),
    );
  }
}