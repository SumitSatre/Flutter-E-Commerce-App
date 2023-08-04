import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Oops, Your Cart is Empty!!🥲🥲" , style: TextStyle(fontSize: 25 , color: Color.fromRGBO(193 ,53 ,132, 1)),),
    );
  }

}