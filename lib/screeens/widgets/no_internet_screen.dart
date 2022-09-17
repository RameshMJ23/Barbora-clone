
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/no internet img.jpg",
              height: 300.0,
              width: 300.0,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 60.0, bottom: 10.0),
              child: Text(
                "No Internet",
                style: TextStyle(
                    fontSize: 25.0
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 25.0),
              child: Text(
                "Make sure your internet is turned on",
                style: TextStyle(
                  fontSize: 16.0
                ),
              ),
            ),
            getConfirmationButton(
              buttonName: "Try again",
              buttonColor: Colors.red,
              onPressed: (){

              }
            )
          ],
        ),
      ),
    );
  }
}
