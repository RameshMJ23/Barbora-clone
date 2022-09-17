
import 'package:barboraapp/screeens/widgets/constants.dart';
import 'package:flutter/material.dart';

class UnselectedBookingScreen extends StatelessWidget {

  VoidCallback onPressed;

  UnselectedBookingScreen({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                offset: const Offset(1,1),
                blurRadius: 5.0,
              )
            ]
          ),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 25.0, left: 10.0),
                child: Text(
                  "Pickup location",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      color: Colors.black87
                  ),
                ),
              ),
              Padding(
                child: getConfirmationButton(buttonName: "Select", onPressed: onPressed),
                padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              ),
              const SizedBox(
                height: 20.0,
              )
            ],
          ),
        )
      ],
    );
  }
}
