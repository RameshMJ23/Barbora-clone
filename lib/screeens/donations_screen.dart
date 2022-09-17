import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:flutter/material.dart';

class DonationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Donations"),
        centerTitle: true,
        backgroundColor: const Color(0xffE32323),
        leading: getAppLeadingWidget(context),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Time for good deeds!",
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Select the organisation you'd loke to donate to, choose the products to donate and add them to the shopping cart",
                style: TextStyle(
                  fontSize: 15.0
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "You will see those products in your shopping cart and will be able to edit them",
                style: TextStyle(
                  fontSize: 15.0
                ),
              ),
            ),
            _buildDonationImages("assets/donate1.jpg"),
            _buildDonationImages("assets/donate2.jpg"),
          ],
        ),
      ),
    );
  }

  Widget _buildDonationImages(String image) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
    child: Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
      ),
      elevation: 5.0,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        child: Ink(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  image,
                ),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5.0,
                  offset: Offset(1,1),
                  spreadRadius: 5.0
                )
              ]
          ),
          height: 175.0,
          //width: 100.0,
        ),
        onTap: (){

        },
        splashColor: Colors.grey.withOpacity(0.05),
      ),
    ),
  );

}
