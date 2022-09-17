import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:flutter/material.dart';

class MyOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My orders"),
        centerTitle: true,
        backgroundColor: const Color(0xffE32323),
        leading: getAppLeadingWidget(context),
      ),
      body: noInfoWidget(
        context: context,
        buttonName: "Choose products",
        icon: Icons.notes,
        content: "You have not made any purchases yet"
      ),
    );
  }
}
