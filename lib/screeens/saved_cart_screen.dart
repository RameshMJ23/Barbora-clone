import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:flutter/material.dart';


class SavedCartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select saved cart"),
        centerTitle: true,
        backgroundColor: const Color(0xffE32323),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20.0,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: noInfoWidget(
          context: context,
          buttonName: "Create saved cart",
          icon: Icons.shopping_cart,
          content: "You have no saved carts. Create them to quickly add products to your cart the next time you shop"
      ),
    );
  }
}
