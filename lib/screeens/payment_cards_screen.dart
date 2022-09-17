import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:flutter/material.dart';

class PaymentCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment cards"),
        centerTitle: true,
        backgroundColor: const Color(0xffE32323),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20.0,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            informationWidget(
                content: "You have no registered cards. You can register it by choosing payment card at the time of purchase",
              fontSize: 14.0
            )
          ],
        ),
      ),
    );
  }
}
