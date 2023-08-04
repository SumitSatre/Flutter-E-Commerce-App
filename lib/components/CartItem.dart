import 'package:flutter/cupertino.dart';

class CartItemPage extends StatelessWidget{
  Map <dynamic , dynamic> cartItem ={};

  CartItemPage({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: Image(
            image: NetworkImage(cartItem["image"]),
          ),
        ),
      ],
    );
  }
}